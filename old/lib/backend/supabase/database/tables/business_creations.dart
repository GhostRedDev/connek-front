import '../database.dart';

class BusinessCreationsTable extends SupabaseTable<BusinessCreationsRow> {
  @override
  String get tableName => 'business_creations';

  @override
  BusinessCreationsRow createRow(Map<String, dynamic> data) =>
      BusinessCreationsRow(data);
}

class BusinessCreationsRow extends SupabaseDataRow {
  BusinessCreationsRow(super.data);

  @override
  SupabaseTable get table => BusinessCreationsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get idempotencyKey => getField<String>('idempotency_key')!;
  set idempotencyKey(String value) =>
      setField<String>('idempotency_key', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  String? get error => getField<String>('error');
  set error(String? value) => setField<String>('error', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
