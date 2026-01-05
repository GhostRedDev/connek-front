import '../database.dart';

class BusinessClientsTable extends SupabaseTable<BusinessClientsRow> {
  @override
  String get tableName => 'business_clients';

  @override
  BusinessClientsRow createRow(Map<String, dynamic> data) =>
      BusinessClientsRow(data);
}

class BusinessClientsRow extends SupabaseDataRow {
  BusinessClientsRow(super.data);

  @override
  SupabaseTable get table => BusinessClientsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get businessId => getField<int>('business_id')!;
  set businessId(int value) => setField<int>('business_id', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  int get forBusinessId => getField<int>('for_business_id')!;
  set forBusinessId(int value) => setField<int>('for_business_id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
