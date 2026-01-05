import '../database.dart';

class QuoteItemTable extends SupabaseTable<QuoteItemRow> {
  @override
  String get tableName => 'quote_item';

  @override
  QuoteItemRow createRow(Map<String, dynamic> data) => QuoteItemRow(data);
}

class QuoteItemRow extends SupabaseDataRow {
  QuoteItemRow(super.data);

  @override
  SupabaseTable get table => QuoteItemTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get quantity => getField<int>('quantity');
  set quantity(int? value) => setField<int>('quantity', value);

  int? get price => getField<int>('price');
  set price(int? value) => setField<int>('price', value);

  int? get quoteId => getField<int>('quote_id');
  set quoteId(int? value) => setField<int>('quote_id', value);
}
