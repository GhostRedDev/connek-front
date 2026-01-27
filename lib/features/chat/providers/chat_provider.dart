import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/user_mode_provider.dart'; // Added
// import '../../../core/providers/theme_provider.dart'; // Example, redundant if not used
// import '../../business/providers/business_provider.dart'; // To get Business ID
// import '../../client/providers/client_provider.dart';
import '../../business/providers/business_provider.dart'; // To get Client ID

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
  final DateTime createdAt; // Added for sorting

  ChatConversation({
    required this.id,
    required this.contact,
    this.lastMessage,
    this.unreadCount = 0,
    required this.createdAt,
  });

  int get contactId => contact['id'];
  bool get isBusiness => contact['is_business'] ?? false;

  DateTime get lastActivityTime {
    if (lastMessage != null && lastMessage!['created_at'] != null) {
      return DateTime.parse(lastMessage!['created_at']);
    }
    return createdAt;
  }

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      contact: json['contact'] ?? {},
      lastMessage: json['last_message'],
      unreadCount: 0, // Mock for now, requires DB support
      createdAt: DateTime.parse(
        json['created_at'],
      ), // Assuming 'created_at' exists in conversation JSON
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
  RealtimeChannel? _conversationsSubscription;

  @override
  Future<List<ChatConversation>> build() async {
    // Watch Auth to trigger refresh on state change
    final authState = ref.watch(authStateProvider);

    // Dispose subscription on rebuild/dispose
    ref.onDispose(() {
      _conversationsSubscription?.unsubscribe();
    });

    if (authState.value?.session == null) return [];

    return fetchConversations();
  }

  Future<List<ChatConversation>> fetchConversations() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return [];

      // CHECK MODE
      final isBusinessMode = ref.watch(userModeProvider);
      final myId = await getMyId(isBusinessMode);
      if (myId == null) return [];

      String idColumn1 = isBusinessMode ? 'business1' : 'client1';
      String idColumn2 = isBusinessMode ? 'business2' : 'client2';

      // Setup Realtime Subscription
      if (_conversationsSubscription == null) {
        _initializeChatSubscription(myId, isBusinessMode);
      }

      print(
        'ChatProvider DBG: MyID=$myId, Mode=${isBusinessMode ? "BUS" : "CLI"}',
      );
      print('ChatProvider DBG: Querying $idColumn1 OR $idColumn2 for $myId');

      final response = await _supabase
          .from('conversations')
          .select('*, client1(*), client2(*), business1(*), business2(*)')
          .or('$idColumn1.eq.$myId, $idColumn2.eq.$myId')
          .order('created_at', ascending: false);

      print('ChatProvider DBG: Response Count=${response.length}');
      if (response.isNotEmpty) {
        print(
          'ChatProvider DBG: Sample Row 0: ${response[0]['id']} - Cl1:${response[0]['client1']} Cl2:${response[0]['client2']} B1:${response[0]['business1']} B2:${response[0]['business2']}',
        );
      }
      final List<ChatConversation> conversations = [];

      for (var conv in response) {
        // Identify Contact based on MY ID
        // If I am business1/2, then contact is client (usually) or another business (B2B?)
        // Assuming Standard: Client <-> Business

        // If I am Business:
        // Contact is likely in client1 or client2 (whichever is not null OR handled by logic)
        // If I am Client:
        // Contact is likely in business1 or business2

        // Let's make it generic:
        Map<String, dynamic>? contactClient;
        Map<String, dynamic>? contactBusiness;

        if (isBusinessMode) {
          // I am Business.
          // Am I business1? -> Partner is client1/2 or business2
          // Am I business2? -> Partner is client1/2 or business1

          bool amIBusiness1 =
              conv['business1'] != null && conv['business1']['id'] == myId;
          bool amIBusiness2 =
              conv['business2'] != null && conv['business2']['id'] == myId;

          if (amIBusiness1) {
            print('ChatProvider DBG: I am Business 1');
            contactClient = conv['client1'] ?? conv['client2'];
            contactBusiness = conv['business2'];
          } else if (amIBusiness2) {
            print('ChatProvider DBG: I am Business 2');
            contactClient = conv['client1'] ?? conv['client2'];
            contactBusiness = conv['business1'];
          } else {
            print('ChatProvider DBG: I am Business but NOT in B1 or B2?');
            contactClient = conv['client1'] ?? conv['client2'];
          }
        } else {
          // I am Client.
          bool amIClient1 =
              conv['client1'] != null && conv['client1']['id'] == myId;
          bool amIClient2 =
              conv['client2'] != null && conv['client2']['id'] == myId;

          if (amIClient1) {
            print('ChatProvider DBG: I am Client 1');
            contactClient = conv['client2'];
            contactBusiness = conv['business1'] ?? conv['business2'];
          } else if (amIClient2) {
            print('ChatProvider DBG: I am Client 2');
            contactClient = conv['client1'];
            contactBusiness = conv['business1'] ?? conv['business2'];
          } else {
            print('ChatProvider DBG: I am Client but NOT in C1 or C2?');
            contactBusiness = conv['business1'] ?? conv['business2'];
          }
        }

        final contactName = contactBusiness != null
            ? contactBusiness['name']
            : (contactClient != null
                  ? '${contactClient['first_name']} ${contactClient['last_name'] ?? ''}'
                  : 'Unknown');

        // Resolve Image
        String? contactImage = contactBusiness != null
            ? contactBusiness['profile_image']
            : (contactClient != null
                  ? contactClient['photo_id'] ?? contactClient['profile_url']
                  : null);

        if (contactImage != null &&
            contactImage.isNotEmpty &&
            !contactImage.startsWith('http')) {
          String path = contactImage;
          String bucket = 'client';
          int? id;

          if (contactBusiness != null) {
            bucket = 'business';
            id = contactBusiness['id'];
          } else if (contactClient != null) {
            bucket = 'client';
            id = contactClient['id'];
          }

          // Fix: Prepend folder ID if missing (path is just filename)
          if (!path.contains('/') && id != null) {
            path = '$id/$path';
          }

          contactImage = _supabase.storage.from(bucket).getPublicUrl(path);
        }

        final contactData = {
          'id': contactBusiness != null
              ? contactBusiness['id']
              : (contactClient != null ? contactClient['id'] : 0),
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

        print(
          'ChatProvider: Processing conv ${conv['id']}. ContactName: $contactName',
        );

        conversations.add(
          ChatConversation(
            id: conv['id'],
            contact: contactData,
            lastMessage: lastMsgRes,
            createdAt: DateTime.parse(conv['created_at']),
          ),
        );
      }

      // Deduplicate: Keep only the latest conversation per Contact
      final Map<String, ChatConversation> uniqueConversations = {};

      for (var c in conversations) {
        final key = '${c.isBusiness ? "B" : "C"}_${c.contactId}';
        if (uniqueConversations.containsKey(key)) {
          // existing
          if (c.lastActivityTime.isAfter(
            uniqueConversations[key]!.lastActivityTime,
          )) {
            uniqueConversations[key] = c;
          }
        } else {
          uniqueConversations[key] = c;
        }
      }

      final sortedList = uniqueConversations.values.toList()
        ..sort((a, b) => b.lastActivityTime.compareTo(a.lastActivityTime));

      state = AsyncValue.data(sortedList);
      print(
        'ChatProvider: Fetched ${sortedList.length} unique conversations (from ${response.length} raw)',
      );
      return sortedList;
    } catch (e) {
      print('ChatProvider: Error fetching chats: $e');
      // Rethrow to let UI handle error state (e.g. Retry button)
      rethrow;
    }
  }

  void _initializeChatSubscription(int myId, bool isBusinessMode) {
    String idColumn1 = isBusinessMode ? 'business1' : 'client1';
    String idColumn2 = isBusinessMode ? 'business2' : 'client2';

    _conversationsSubscription = _supabase
        .channel('public:conversations:user:$myId:mode:$isBusinessMode')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'conversations',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: idColumn1,
            value: myId,
          ),
          callback: (payload) {
            print(
              'Realtime: Conversation update ($idColumn1) -> Refreshing list',
            );
            ref.invalidateSelf();
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'conversations',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: idColumn2,
            value: myId,
          ),
          callback: (payload) {
            print(
              'Realtime: Conversation update ($idColumn2) -> Refreshing list',
            );
            ref.invalidateSelf();
          },
        )
        .subscribe();
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

      final isBusinessMode = ref.read(userModeProvider);

      if (isBusinessMode) {
        // Fetch Business ID (User -> Client -> Business)
        final cliRes = await _supabase
            .from('client')
            .select('id')
            .eq('user_id', user.id)
            .maybeSingle();
        if (cliRes == null) {
          print('Error: Sender has no client profile (Business Mode)');
          return;
        }
        final clientId = cliRes['id'];

        try {
          final busData = await ref
              .read(businessRepositoryProvider)
              .getMyBusiness(clientId);

          if (busData == null) {
            print('Error: Sender has no business profile (Business Mode)');
            return;
          }
          senderId = busData['id'];
        } catch (e) {
          print('Error fetching business for send: $e');
          return;
        }

        isSenderClient = false;
      } else {
        // Fetch Client ID
        final cliRes = await _supabase
            .from('client')
            .select('id')
            .eq('user_id', user.id)
            .maybeSingle();
        if (cliRes == null) {
          print('Error: Sender has no client profile (Client Mode)');
          return;
        }
        senderId = cliRes['id'];
        isSenderClient = true;
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

      // Identify ME and PARTNER
      // Logic:
      // If I am Client1, partner is Client2, Business1, or Business2.
      // If I am Client2, partner is Client1, Business1, or Business2.
      // If I am Business1, partner is Business2, Client1, or Client2.
      // If I am Business2, partner is Business1, Client1, or Client2.

      bool amIClient1 = client1 == senderId && isSenderClient;
      bool amIClient2 = client2 == senderId && isSenderClient;
      bool amIBusiness1 = business1 == senderId && !isSenderClient;
      bool amIBusiness2 = business2 == senderId && !isSenderClient;

      if (amIClient1) {
        receiverId = client2 ?? business1 ?? business2 ?? 0;
      } else if (amIClient2) {
        receiverId = client1 ?? business1 ?? business2 ?? 0;
      } else if (amIBusiness1) {
        receiverId = business2 ?? client1 ?? client2 ?? 0;
      } else if (amIBusiness2) {
        receiverId = business1 ?? client1 ?? client2 ?? 0;
      } else {
        print(
          "Error: Sender $senderId (Client: $isSenderClient) not found in conversation slots.",
        );
        return;
      }

      if (receiverId == 0) {
        // Fallback: This might happen if data is corrupted (only me in conversation).
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

      // Auto-Reply Simulation (For Testing Self-Chat)
      // If I am Client sending to Business, and that Business is ALSO ME (or just generally for demo),
      // we can trigger a fake bot reply.

      // Check if receiver is a business
      if (business1 == receiverId || business2 == receiverId) {
        // It is a message TO a business.
        // Let's verify if the Business Owner is the current user (Self-Chat)
        // We can't easily check owner from here without a query, but we can check if it's the specific test case.

        // OR just always echo for now if it's the "Healing Massage" business (Demo Mode).
        // Ideally, check if 'sender_bot' is false to avoid loops.

        // SIMULATION: If I message my own business, respond.
        // We know 'receiverId' is the Business ID.
        // We need to check if that Business belongs to 'user.id'.

        final busOwnerRes = await _supabase
            .from('business')
            .select('client_id, client(user_id)')
            .eq('id', receiverId)
            .maybeSingle();

        if (busOwnerRes != null) {
          final ownerUserId = busOwnerRes['client']['user_id'];
          if (ownerUserId == user.id) {
            // IT IS MY STORE!
            print(
              '🤖 Auto-Reply: User messaged their own store. Triggering Bot Response...',
            );

            // Delay slightly for realism
            Future.delayed(const Duration(seconds: 2), () async {
              try {
                await _supabase.from('messages').insert({
                  'conversation_id': conversationId,
                  'content':
                      '👋 Hola! Soy el asistente virtual de tu tienda. He recibido tu mensaje: "$content"',
                  'content_type': 'text',
                  'sender': receiverId, // Business sends it
                  'receiver': senderId, // Client receives it
                  'sender_client': false, // Sent by Business
                  'sender_bot': true,
                });
                print('🤖 Bot Replied Successfully');
              } catch (e) {
                print('🤖 Bot Reply Failed: $e');
              }
            });
          }
        }
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

  // Create Conversation
  Future<int?> createConversation({
    required int myId,
    required bool amIBusiness,
    required int peerId,
    required bool isPeerBusiness,
  }) async {
    try {
      // Determine Participants
      int? client1, client2, business1, business2;

      if (amIBusiness && isPeerBusiness) {
        business1 = myId;
        business2 = peerId;
      } else if (!amIBusiness && !isPeerBusiness) {
        client1 = myId;
        client2 = peerId;
      } else {
        if (amIBusiness) {
          business1 = myId;
          client1 = peerId;
        } else {
          client1 = myId;
          business1 = peerId;
        }
      }

      // Check for EXISTING Conversation
      // We construct a query based on the non-null IDs.
      // This is simpler than the RPC or complicated OR logic because we know exactly which 2 slots we want.
      // NOTE: We assume slot 1 is standard. We might check reversed slots if strictness needed, but normally app initiates in fixed slots.

      var query = _supabase.from('conversations').select('id');

      if (business1 != null) query = query.eq('business1', business1);
      if (business2 != null) query = query.eq('business2', business2);
      if (client1 != null) query = query.eq('client1', client1);
      if (client2 != null) query = query.eq('client2', client2);

      final existing = await query.maybeSingle();

      if (existing != null) {
        print('ChatProvider: Found existing conversation ${existing['id']}');
        return existing['id'];
      }

      print('ChatProvider: Creating NEW conversation via RPC');

      // Use RPC which handles logic and constraints safely
      final res = await _supabase.rpc(
        'get_or_create_conversation',
        params: {
          'param_business_id': business1,
          'param_client_id': client1,
          'param_peer_business_id': business2, // Might be null
          'param_peer_client_id': client2, // Might be null
        },
      );

      // RPC usually returns the ID directly or a row.
      // If it returns an Integer (ID), use it.
      // If it returns a Map, access 'id'.
      // Based on typical Supabase RPC patterns for scalar returns:
      if (res is int) return res;
      if (res is Map && res.containsKey('id')) return res['id'];
      if (res is List && res.isNotEmpty) return res[0]['id'];

      // Fallback
      return res;
    } catch (e) {
      print('Error creating conversation: $e');
      // If RPC fails (e.g. missing), try fallback insert with minimal defaults?
      // But we know manual insert failed on client2 constraint.
      // Try insert with explicit 0s or empty strings?
      // Only as last resort.
      return null;
    }
  }

  // Search Users
  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    if (query.isEmpty) return [];

    try {
      // Search Clients
      final clients = await _supabase
          .from('client')
          .select('id, first_name, last_name, photo_id, profile_url')
          .ilike('first_name', '%$query%') // or last_name
          .limit(10);

      // Search Businesses
      final businesses = await _supabase
          .from('business')
          .select('id, name, profile_image')
          .ilike('name', '%$query%')
          .limit(10);

      final results = <Map<String, dynamic>>[];

      for (var c in clients) {
        results.add({
          'id': c['id'],
          'name': '${c['first_name']} ${c['last_name'] ?? ''}',
          'image': c['photo_id'] ?? c['profile_url'],
          'is_business': false,
        });
      }

      for (var b in businesses) {
        // Resolve Image (Same logic as in ProfileRepo/ChatProvider)
        String? img = b['profile_image'];
        if (img != null && !img.startsWith('http')) {
          // We'll trust the view to handle it or resolve it here?
          // Better to resolve it here for NewChatPage
          String bPid = img;
          if (!bPid.contains('/')) {
            bPid = '${b['id']}/$bPid';
          }
          img = _supabase.storage.from('business').getPublicUrl(bPid);
        }

        results.add({
          'id': b['id'],
          'name': b['name'],
          'image': img,
          'is_business': true,
        });
      }

      return results;
    } catch (e) {
      print('Error searching users: $e');
      return [];
    }
  }

  // Get Suggested Users (Popular/Recent)
  Future<List<Map<String, dynamic>>> getSuggestedUsers() async {
    try {
      // For now, just return some Businesses and Clients
      // In a real app, this would be "Recent Contacts" or "Popular Businesses"

      final businesses = await _supabase
          .from('business')
          .select('id, name, profile_image')
          .limit(10); // Simple limit for suggestions

      final results = <Map<String, dynamic>>[];

      for (var b in businesses) {
        String? img = b['profile_image'];
        if (img != null && !img.startsWith('http') && img.isNotEmpty) {
          String bPid = img;
          if (!bPid.contains('/')) {
            bPid = '${b['id']}/$bPid';
          }
          img = _supabase.storage.from('business').getPublicUrl(bPid);
        }

        results.add({
          'id': b['id'],
          'name': b['name'],
          'image': img,
          'is_business': true,
        });
      }
      return results;
    } catch (e) {
      print('Error fetching suggested users: $e');
      return [];
    }
  }

  // Helper: Get My ID based on Mode
  Future<int?> getMyId(bool isBusinessMode) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    if (isBusinessMode) {
      // 1. Get Client ID
      final cliRes = await _supabase
          .from('client')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();
      if (cliRes == null) return null;
      final clientId = cliRes['id'];

      // 2. Get Business ID
      try {
        final busData = await ref
            .read(businessRepositoryProvider)
            .getMyBusiness(clientId);
        return busData?['id'];
      } catch (e) {
        return null;
      }
    } else {
      // Get Client ID
      final cliRes = await _supabase
          .from('client')
          .select('id')
          .eq('user_id', user.id)
          .maybeSingle();
      return cliRes?['id'];
    }
  }
}
