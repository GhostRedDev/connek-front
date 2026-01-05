import '../database.dart';

class ResourcesTable extends SupabaseTable<ResourcesRow> {
  @override
  String get tableName => 'resources';

  @override
  ResourcesRow createRow(Map<String, dynamic> data) => ResourcesRow(data);
}

class ResourcesRow extends SupabaseDataRow {
  ResourcesRow(super.data);

  @override
  SupabaseTable get table => ResourcesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get businessId => getField<int>('business_id')!;
  set businessId(int value) => setField<int>('business_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  bool get active => getField<bool>('active')!;
  set active(bool value) => setField<bool>('active', value);

  dynamic get serviceTime => getField<dynamic>('service_time');
  set serviceTime(dynamic value) => setField<dynamic>('service_time', value);

  String? get resourceType => getField<String>('resource_type');
  set resourceType(String? value) => setField<String>('resource_type', value);

  String? get profileImage => getField<String>('profile_image');
  set profileImage(String? value) => setField<String>('profile_image', value);
}
