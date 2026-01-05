import '../database.dart';

class AddressesTable extends SupabaseTable<AddressesRow> {
  @override
  String get tableName => 'addresses';

  @override
  AddressesRow createRow(Map<String, dynamic> data) => AddressesRow(data);
}

class AddressesRow extends SupabaseDataRow {
  AddressesRow(super.data);

  @override
  SupabaseTable get table => AddressesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);

  String? get country => getField<String>('country');
  set country(String? value) => setField<String>('country', value);

  String? get postalCode => getField<String>('postal_code');
  set postalCode(String? value) => setField<String>('postal_code', value);

  String? get state => getField<String>('state');
  set state(String? value) => setField<String>('state', value);

  bool? get billing => getField<bool>('billing');
  set billing(bool? value) => setField<bool>('billing', value);

  bool? get location => getField<bool>('location');
  set location(bool? value) => setField<bool>('location', value);

  String? get line1 => getField<String>('line_1');
  set line1(String? value) => setField<String>('line_1', value);

  String? get line2 => getField<String>('line_2');
  set line2(String? value) => setField<String>('line_2', value);
}
