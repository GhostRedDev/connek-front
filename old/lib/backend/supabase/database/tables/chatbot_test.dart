import '../database.dart';

class ChatbotTestTable extends SupabaseTable<ChatbotTestRow> {
  @override
  String get tableName => 'chatbot_test';

  @override
  ChatbotTestRow createRow(Map<String, dynamic> data) => ChatbotTestRow(data);
}

class ChatbotTestRow extends SupabaseDataRow {
  ChatbotTestRow(super.data);

  @override
  SupabaseTable get table => ChatbotTestTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get threadId => getField<String>('thread_id');
  set threadId(String? value) => setField<String>('thread_id', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  int? get chatbotId => getField<int>('chatbot_id');
  set chatbotId(int? value) => setField<int>('chatbot_id', value);
}
