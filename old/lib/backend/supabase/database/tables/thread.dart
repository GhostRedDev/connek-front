import '../database.dart';

class ThreadTable extends SupabaseTable<ThreadRow> {
  @override
  String get tableName => 'thread';

  @override
  ThreadRow createRow(Map<String, dynamic> data) => ThreadRow(data);
}

class ThreadRow extends SupabaseDataRow {
  ThreadRow(super.data);

  @override
  SupabaseTable get table => ThreadTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get chatbotId => getField<int>('chatbot_id');
  set chatbotId(int? value) => setField<int>('chatbot_id', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  int? get clientId => getField<int>('client_id');
  set clientId(int? value) => setField<int>('client_id', value);

  String get threadId => getField<String>('thread_id')!;
  set threadId(String value) => setField<String>('thread_id', value);

  bool get testThread => getField<bool>('test_thread')!;
  set testThread(bool value) => setField<bool>('test_thread', value);
}
