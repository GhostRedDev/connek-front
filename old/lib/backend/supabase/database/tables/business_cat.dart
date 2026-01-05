import '../database.dart';

class BusinessCatTable extends SupabaseTable<BusinessCatRow> {
  @override
  String get tableName => 'business_cat';

  @override
  BusinessCatRow createRow(Map<String, dynamic> data) => BusinessCatRow(data);
}

class BusinessCatRow extends SupabaseDataRow {
  BusinessCatRow(super.data);

  @override
  SupabaseTable get table => BusinessCatTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get category => getField<String>('category')!;
  set category(String value) => setField<String>('category', value);

  String? get mainCategory => getField<String>('main_category');
  set mainCategory(String? value) => setField<String>('main_category', value);

  String? get mcc => getField<String>('mcc');
  set mcc(String? value) => setField<String>('mcc', value);

  String? get mccName => getField<String>('mcc_name');
  set mccName(String? value) => setField<String>('mcc_name', value);

  String? get mccSlug => getField<String>('mcc_slug');
  set mccSlug(String? value) => setField<String>('mcc_slug', value);

  bool? get mccRestricted => getField<bool>('mcc_restricted');
  set mccRestricted(bool? value) => setField<bool>('mcc_restricted', value);
}
