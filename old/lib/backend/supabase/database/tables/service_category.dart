import '../database.dart';

class ServiceCategoryTable extends SupabaseTable<ServiceCategoryRow> {
  @override
  String get tableName => 'service_category';

  @override
  ServiceCategoryRow createRow(Map<String, dynamic> data) =>
      ServiceCategoryRow(data);
}

class ServiceCategoryRow extends SupabaseDataRow {
  ServiceCategoryRow(super.data);

  @override
  SupabaseTable get table => ServiceCategoryTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get category => getField<String>('category')!;
  set category(String value) => setField<String>('category', value);

  String? get mainCategory => getField<String>('main_category');
  set mainCategory(String? value) => setField<String>('main_category', value);

  String? get mcc => getField<String>('mcc');
  set mcc(String? value) => setField<String>('mcc', value);
}
