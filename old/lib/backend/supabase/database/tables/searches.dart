import '../database.dart';

class SearchesTable extends SupabaseTable<SearchesRow> {
  @override
  String get tableName => 'searches';

  @override
  SearchesRow createRow(Map<String, dynamic> data) => SearchesRow(data);
}

class SearchesRow extends SupabaseDataRow {
  SearchesRow(super.data);

  @override
  SupabaseTable get table => SearchesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get prompt => getField<String>('prompt');
  set prompt(String? value) => setField<String>('prompt', value);

  int? get clientId => getField<int>('client_id');
  set clientId(int? value) => setField<int>('client_id', value);
}
