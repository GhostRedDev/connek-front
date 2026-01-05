import '../database.dart';

class EmployeesTable extends SupabaseTable<EmployeesRow> {
  @override
  String get tableName => 'employees';

  @override
  EmployeesRow createRow(Map<String, dynamic> data) => EmployeesRow(data);
}

class EmployeesRow extends SupabaseDataRow {
  EmployeesRow(super.data);

  @override
  SupabaseTable get table => EmployeesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get purpose => getField<String>('purpose')!;
  set purpose(String value) => setField<String>('purpose', value);

  String get description => getField<String>('description')!;
  set description(String value) => setField<String>('description', value);

  String get skills => getField<String>('skills')!;
  set skills(String value) => setField<String>('skills', value);

  int get price => getField<int>('price')!;
  set price(int value) => setField<int>('price', value);

  String get frequency => getField<String>('frequency')!;
  set frequency(String value) => setField<String>('frequency', value);

  String get currency => getField<String>('currency')!;
  set currency(String value) => setField<String>('currency', value);

  String get stripePriceId => getField<String>('stripe_price_id')!;
  set stripePriceId(String value) => setField<String>('stripe_price_id', value);
}
