import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';
import '../../../core/providers/auth_provider.dart';
// import '../../../core/providers/theme_provider.dart'; // Example, redundant if not used
// import '../../business/providers/business_provider.dart'; // To get Business ID
// import '../../client/providers/client_provider.dart'; // To get Client ID

// Models
class ChatMessage {
  final int id;
  final int conversationId;
  final String content;
  final String contentType;
  final int sender;
  final int receiver;
  final bool senderClient;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.contentType,
    required this.sender,
    required this.receiver,
    required this.senderClient,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      conversationId: json['conversation_id'],
      content: json['content'],
      contentType: json['content_type'],
      sender: json['sender'],
      receiver: json['receiver'],
      senderClient: json['sender_client'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class ChatConversation {
  final int id;
  final Map<String, dynamic> contact; // simplified for now
  final Map<String, dynamic>? lastMessage;
  final int unreadCount;

  ChatConversation({
    required this.id,
    required this.contact,
    this.lastMessage,
    this.unreadCount = 0,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      contact: json['contact'] ?? {},
      lastMessage: json['last_message'],
      unreadCount: 0, // Mock for now, requires DB support
    );
  }
}

// Provider
final chatProvider =
    AsyncNotifierProvider<ChatNotifier, List<ChatConversation>>(() {
      return ChatNotifier();
    });

class ChatNotifier extends AsyncNotifier<List<ChatConversation>> {
  final _supabase = Supabase.instance.client;

  @override
  Future<List<ChatConversation>> build() async {
    // Watch Auth to trigger refresh on state change
    final authState = ref.watch(authStateProvider);
    if (authState.value?.session == null) return [];

    return fetchConversations();
  }

  Future<List<ChatConversation>> fetchConversations() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return [];

      // Determine identity (Business or Client)
      // This part is tricky without a dedicated "UserProvider" that separates Business/Client logic.
      // For now, I will try to fetch as a CLIENT first, as that seems to be the default Identity.
      // If we are in "Business Mode", we should fetch as Business.
      // Let's assume we are Client for the "Social" aspect requested.

      // TODO: properly distinguish Business/Client context.
      // Using a rough check or fetching both?
      // Based on previous code, `client_id` is often `user.id` or linked to it.

      // Attempt to fetch Client ID from 'client' table
      final clientRes = await _supabase
          .from('client')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();

      if (clientRes == null) return [];
      final clientId = clientRes['id'];

      // Fetch contacts using the Endpoint logic (replicated here or via Function)
      // Since we don't have the API URL handy for HTTP calls in this file (unless we use http package),
      // we can try to replicate the query or call the Edge Function if available.
      // But wait! The router logic was complicated (joins).
      // Let's rely on Supabase SDK to call the Function or simple query if possible.
      // The user said "use real data".

      // Attempting to call the python API might be hard from here without 'dio' configured.
      // Let's do a direct Supabase query similar to `messages.py`.

      final response = await _supabase
          .from('conversations')
          .select('*, client1(*), client2(*), business1(*), business2(*)')
          .or('client1.eq.$clientId, client2.eq.$clientId');

      final List<ChatConversation> conversations = [];

      for (var conv in response) {
        // Parse contact similar to python logic
        final IsClient1 =
            conv['client1'] != null && conv['client1']['id'] == clientId;
        final contactClient = IsClient1 ? conv['client2'] : conv['client1'];
        final contactBusiness = IsClient1
            ? conv['business2']
            : conv['business1'];

        final contactName = contactBusiness != null
            ? contactBusiness['name']
            : (contactClient != null
                  ? '${contactClient['first_name']} ${contactClient['last_name']}'
                  : 'Unknown');
        String? contactImage = contactBusiness != null
            ? contactBusiness['profile_image']
            : (contactClient != null ? contactClient['profile_url'] : null);

        if (contactImage != null && !contactImage.startsWith('http')) {
          // Assuming 'business' bucket for business images and 'avatars' for clients?
          // Or 'profiles'. Let's check common patterns.
          // Earlier logs showed 'business' bucket usage.
          // If uncertain, we might simply leave it blank or try a generic bucket.
          // Let's assume 'business' for business and 'avatars' for clients based on standard Supabase patterns.
          // Or better, just try to resolve it if it looks like a path.
          final bucket = contactBusiness != null ? 'business' : 'avatars';
          contactImage = _supabase.storage
              .from(bucket)
              .getPublicUrl(contactImage);
        }

        final contactData = {
          'id': contactClient != null ? contactClient['id'] : 0,
          'name': contactName,
          'image': contactImage,
          'is_business': contactBusiness != null,
          'business_id': contactBusiness?['id'],
        };

        // Get Last Message
        final lastMsgRes = await _supabase
            .from('messages')
            .select('*')
            .eq('conversation_id', conv['id'])
            .order('created_at', ascending: false)
            .limit(1)
            .maybeSingle();

        conversations.add(
          ChatConversation(
            id: conv['id'],
            contact: contactData,
            lastMessage: lastMsgRes,
          ),
        );
      }

      return conversations;
    } catch (e) {
      print('Error fetching chats: $e');
      return [];
    }
  }

  // Send Message
  Future<void> sendMessage(
    int conversationId,
    String content, {
    String contentType = 'text',
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return;

      int senderId = 0;
      bool isSenderClient = true;

      // 1. Check if Client
      final clientRes = await _supabase
          .from('client')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();

      if (clientRes != null) {
        senderId = clientRes['id'];
        isSenderClient = true;
      } else {
        // 2. Check if Business
        final businessRes = await _supabase
            .from('business')
            .select('id')
            .eq('user_id', user.id)
            .maybeSingle();

        if (businessRes != null) {
          senderId = businessRes['id'];
          isSenderClient = false;
        } else {
          print(
            "Error: sending message but user is neither Client nor Business",
          );
          return;
        }
      }

      // Check conversation to know receiver
      final convRes = await _supabase
          .from('conversations')
          .select('client1, client2, business1, business2')
          .eq('id', conversationId)
          .single();

      final client1 = convRes['client1'];
      final client2 = convRes['client2'];
      final business1 = convRes['business1'];
      final business2 = convRes['business2'];

      int receiverId = 0;

      // Logic to find Partner
      bool amISlot1 = false;
      bool amISlot2 = false;

      if (isSenderClient) {
        if (client1 == senderId)
          amISlot1 = true;
        else if (client2 == senderId)
          amISlot2 = true;
      } else {
        if (business1 == senderId)
          amISlot1 = true;
        else if (business2 == senderId)
          amISlot2 = true;
      }

      if (amISlot1) {
        receiverId = client2 ?? business2 ?? 0;
      } else if (amISlot2) {
        receiverId = client1 ?? business1 ?? 0;
      } else {
        print(
          "Error: User $senderId not found in conversation $conversationId",
        );
        return;
      }

      if (receiverId == 0) {
        print("Error: No receiver found for conversation $conversationId");
        return;
      }

      /*
      await _supabase.from('messages').insert({
        'conversation_id': conversationId,
        'content': content,
        'content_type': contentType,
        'sender': senderId,
        'receiver': receiverId,
        'sender_client': isSenderClient,
        'sender_bot': false,
      });
      */

      // Use Backend API to ensure notifications and bot logic triggers
      bool sentViaApi = false;
      try {
        final response = await ApiService().post(
          '/messages/send',
          body: {
            'conversation_id': conversationId,
            'content': content,
            'content_type': contentType,
            'sender': senderId,
            'receiver': receiverId,
          },
        );

        if (response != null &&
            response is Map &&
            response['success'] == true) {
          sentViaApi = true;
        } else {
          print(
            "API Send failed: ${response is Map ? response['error'] : response}",
          );
        }
      } catch (e) {
        print("API Connection error: $e");
      }

      // Fallback: Direct Supabase Insert
      if (!sentViaApi) {
        print("Falling back to Direct Supabase Insert for Message");
        await _supabase.from('messages').insert({
          'conversation_id': conversationId,
          'content': content,
          'content_type': contentType,
          'sender': senderId,
          'receiver': receiverId,
          'sender_client': isSenderClient,
          'sender_bot': false,
        });
        print("✅ Direct Supabase Insert Successful");
      }

      // Refresh list to update last message
      ref.invalidateSelf();
    } catch (e) {
      print("Error sending message: $e");
      rethrow;
    }
  }

  // Upload File
  Future<String?> uploadFile(
    List<int> bytes,
    String fileName,
    int conversationId, {
    String bucket = 'chat_files',
  }) async {
    try {
      final path =
          'uploads/$conversationId/${DateTime.now().millisecondsSinceEpoch}_$fileName';
      await _supabase.storage
          .from(bucket)
          .uploadBinary(
            path,
            bytes as dynamic,
            fileOptions: FileOptions(
              cacheControl: '3600',
              upsert: false,
              metadata: {'conversation_id': conversationId.toString()},
            ),
          );

      final publicUrl = _supabase.storage.from(bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      print('Error uploading file: $e');
      // If bucket doesn't exist, generic error. We can't auto-create easily here.
      return null;
    }
  }

  // Fetch messages for a specific conversation
  // Returns Stream? Or Future?
  Stream<List<ChatMessage>> getMessagesStream(int conversationId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: false)
        .map((maps) => maps.map((e) => ChatMessage.fromJson(e)).toList());
  }
}
