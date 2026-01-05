import '../database.dart';

class ConversationsTable extends SupabaseTable<ConversationsRow> {
  @override
  String get tableName => 'conversations';

  @override
  ConversationsRow createRow(Map<String, dynamic> data) =>
      ConversationsRow(data);
}

class ConversationsRow extends SupabaseDataRow {
  ConversationsRow(super.data);

  @override
  SupabaseTable get table => ConversationsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get client1 => getField<int>('client1')!;
  set client1(int value) => setField<int>('client1', value);

  int get client2 => getField<int>('client2')!;
  set client2(int value) => setField<int>('client2', value);

  bool get botActive => getField<bool>('bot_active')!;
  set botActive(bool value) => setField<bool>('bot_active', value);

  bool get client1Business => getField<bool>('client1_business')!;
  set client1Business(bool value) => setField<bool>('client1_business', value);

  bool get client2Business => getField<bool>('client2_business')!;
  set client2Business(bool value) => setField<bool>('client2_business', value);

  int? get activeRequest => getField<int>('active_request');
  set activeRequest(int? value) => setField<int>('active_request', value);

  int? get activeLead => getField<int>('active_lead');
  set activeLead(int? value) => setField<int>('active_lead', value);

  String? get activeThread => getField<String>('active_thread');
  set activeThread(String? value) => setField<String>('active_thread', value);

  DateTime? get deletedAt => getField<DateTime>('deleted_at');
  set deletedAt(DateTime? value) => setField<DateTime>('deleted_at', value);

  int? get business1 => getField<int>('business1');
  set business1(int? value) => setField<int>('business1', value);

  int? get business2 => getField<int>('business2');
  set business2(int? value) => setField<int>('business2', value);
}
