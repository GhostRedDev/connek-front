// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> chatbotTestMessages(int chatbotTestId) async {
  final SupabaseClient supabase = Supabase.instance.client;

  // Define the function to handle updates
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

  print('Creating channel for chatbotTestId: $chatbotTestId');

  // Create a real-time channel for the specific chatbotTestId
  final channel = supabase
      .channel('public:messages_test:chatbot_test_id=eq.$chatbotTestId');

  // Add the PostgreSQL changes listener
  channel.onPostgresChanges(
    event: PostgresChangeEvent.insert,
    schema: 'public',
    table: 'messages_test',
    filter: PostgresChangeFilter(
      type: PostgresChangeFilterType.eq,
      column: 'chatbot_test_id',
      value: chatbotTestId,
    ),
    callback: (payload) async {
      print('Change received: ${payload.toString()}');

      // Extract the new record using the updated payload property
      final newRecord = payload.newRecord as Map<String, dynamic>?;

      // If the record matches the chatbotTestId, handle the update
      if (newRecord != null && newRecord['chatbot_test_id'] == chatbotTestId) {
        await handleUpdate(newRecord);
      }
    },
  );

  // Subscribe to the channel
  try {
    print('Subscribing to channel.');
    channel.subscribe();
    print('Subscription successful.');
  } catch (e) {
    print('Failed to subscribe to channel: $e');
  }
}
