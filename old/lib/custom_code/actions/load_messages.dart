// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> loadMessages(int conversationId) async {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> handleUpdate(Map<String, dynamic>? newRecord) async {
    if (newRecord == null) {
      print('Received null record in handleUpdate.');
      return;
    }

    // Update the AppState variable
    print('Updating state with new record: $newRecord');
    FFAppState().update(() {
      FFAppState().updateMessage = 'new message';
    });
  }

  print('Creating channel for conversationId: $conversationId');

  final channel =
      supabase.channel('public:messages:conversation_id=eq.$conversationId');

  channel.onPostgresChanges(
    event: PostgresChangeEvent.insert,
    schema: 'public',
    table: 'messages',
    filter: PostgresChangeFilter(
      type: PostgresChangeFilterType.eq,
      column: 'conversation_id',
      value: conversationId,
    ),
    callback: (payload) async {
      print('Change received: ${payload.toString()}');

      // Use `newRecord` instead of `payload['new']`
      final newRecord = payload.newRecord as Map<String, dynamic>?;

      if (newRecord != null && newRecord['conversation_id'] == conversationId) {
        await handleUpdate(newRecord);
      }
    },
  );

  try {
    print('Subscribing to channel.');
    channel.subscribe();
    print('Subscription successful.');
  } catch (e) {
    print('Failed to subscribe to channel: $e');
  }
}
