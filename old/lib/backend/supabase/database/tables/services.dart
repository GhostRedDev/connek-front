import '../database.dart';

class ServicesTable extends SupabaseTable<ServicesRow> {
  @override
  String get tableName => 'services';

  @override
  ServicesRow createRow(Map<String, dynamic> data) => ServicesRow(data);
}

class ServicesRow extends SupabaseDataRow {
  ServicesRow(super.data);

  @override
  SupabaseTable get table => ServicesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  int? get priceLowCents => getField<int>('price_low_cents');
  set priceLowCents(int? value) => setField<int>('price_low_cents', value);

  int? get priceHighCents => getField<int>('price_high_cents');
  set priceHighCents(int? value) => setField<int>('price_high_cents', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  String? get images => getField<String>('images');
  set images(String? value) => setField<String>('images', value);

  String? get serviceCategory => getField<String>('service_category');
  set serviceCategory(String? value) =>
      setField<String>('service_category', value);

  String? get profileImage => getField<String>('profile_image');
  set profileImage(String? value) => setField<String>('profile_image', value);

  int get priceCents => getField<int>('price_cents')!;
  set priceCents(int value) => setField<int>('price_cents', value);

  int get durationMinutes => getField<int>('duration_minutes')!;
  set durationMinutes(int value) => setField<int>('duration_minutes', value);

  String get resourcesList => getField<String>('resources_list')!;
  set resourcesList(String value) => setField<String>('resources_list', value);
}
