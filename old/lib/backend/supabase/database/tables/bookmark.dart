import '../database.dart';

class BookmarkTable extends SupabaseTable<BookmarkRow> {
  @override
  String get tableName => 'bookmark';

  @override
  BookmarkRow createRow(Map<String, dynamic> data) => BookmarkRow(data);
}

class BookmarkRow extends SupabaseDataRow {
  BookmarkRow(super.data);

  @override
  SupabaseTable get table => BookmarkTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  int get bookBusinessId => getField<int>('book_business_id')!;
  set bookBusinessId(int value) => setField<int>('book_business_id', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
