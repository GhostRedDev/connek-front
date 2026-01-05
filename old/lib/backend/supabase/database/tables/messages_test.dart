import '../database.dart';

class MessagesTestTable extends SupabaseTable<MessagesTestRow> {
  @override
  String get tableName => 'messages_test';

  @override
  MessagesTestRow createRow(Map<String, dynamic> data) => MessagesTestRow(data);
}

class MessagesTestRow extends SupabaseDataRow {
  MessagesTestRow(super.data);

  @override
  SupabaseTable get table => MessagesTestTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get chatbotTestId => getField<int>('chatbot_test_id')!;
  set chatbotTestId(int value) => setField<int>('chatbot_test_id', value);

  String get content => getField<String>('content')!;
  set content(String value) => setField<String>('content', value);

  String get contentType => getField<String>('content_type')!;
  set contentType(String value) => setField<String>('content_type', value);

  bool get senderBusiness => getField<bool>('sender_business')!;
  set senderBusiness(bool value) => setField<bool>('sender_business', value);
}
