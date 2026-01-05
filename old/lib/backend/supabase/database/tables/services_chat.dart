import '../database.dart';

class ServicesChatTable extends SupabaseTable<ServicesChatRow> {
  @override
  String get tableName => 'services_chat';

  @override
  ServicesChatRow createRow(Map<String, dynamic> data) => ServicesChatRow(data);
}

class ServicesChatRow extends SupabaseDataRow {
  ServicesChatRow(super.data);

  @override
  SupabaseTable get table => ServicesChatTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get clientId => getField<int>('client_id');
  set clientId(int? value) => setField<int>('client_id', value);

  String? get content => getField<String>('content');
  set content(String? value) => setField<String>('content', value);

  String? get threadId => getField<String>('thread_id');
  set threadId(String? value) => setField<String>('thread_id', value);
}
