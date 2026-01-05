import '../database.dart';

class BusinessCategoryTable extends SupabaseTable<BusinessCategoryRow> {
  @override
  String get tableName => 'business_category';

  @override
  BusinessCategoryRow createRow(Map<String, dynamic> data) =>
      BusinessCategoryRow(data);
}

class BusinessCategoryRow extends SupabaseDataRow {
  BusinessCategoryRow(super.data);

  @override
  SupabaseTable get table => BusinessCategoryTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get slug => getField<String>('slug')!;
  set slug(String value) => setField<String>('slug', value);

  double get code => getField<double>('code')!;
  set code(double value) => setField<double>('code', value);

  bool get restricted => getField<bool>('restricted')!;
  set restricted(bool value) => setField<bool>('restricted', value);
}
