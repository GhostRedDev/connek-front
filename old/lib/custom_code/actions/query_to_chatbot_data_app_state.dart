// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart';

Future<List<ChatbotDataStruct>> queryToChatbotDataAppState(
    List<ChatbotRow> chatbotQuery) async {
  // convert the List supabase rows to a list data type.

  List<ChatbotDataStruct> chatbotDataList = [];

  for (ChatbotRow row in chatbotQuery) {
    // Convert DateTime to String in 'yyyy-MM-dd' format
    String? formattedCreatedAt = DateFormat('yyyy-MM-dd').format(row.createdAt);

    ChatbotDataStruct chatbotData = ChatbotDataStruct(
        id: row.id,
        createdAt: formattedCreatedAt,
        assistantId: row.assistantId,
        instructions: row.instructions,
        businessId: row.businessId,
        name: row.name,
        employeeId: row.employeeId,
        status: row.status);
    chatbotDataList.add(chatbotData);
  }

  return chatbotDataList;
}
