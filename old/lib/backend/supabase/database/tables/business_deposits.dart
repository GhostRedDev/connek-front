import '../database.dart';

class BusinessDepositsTable extends SupabaseTable<BusinessDepositsRow> {
  @override
  String get tableName => 'business_deposits';

  @override
  BusinessDepositsRow createRow(Map<String, dynamic> data) =>
      BusinessDepositsRow(data);
}

class BusinessDepositsRow extends SupabaseDataRow {
  BusinessDepositsRow(super.data);

  @override
  SupabaseTable get table => BusinessDepositsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get transit => getField<String>('transit');
  set transit(String? value) => setField<String>('transit', value);

  String? get institution => getField<String>('institution');
  set institution(String? value) => setField<String>('institution', value);

  String? get account => getField<String>('account');
  set account(String? value) => setField<String>('account', value);

  int get businessId => getField<int>('business_id')!;
  set businessId(int value) => setField<int>('business_id', value);

  bool get automaticTransfers => getField<bool>('automatic_transfers')!;
  set automaticTransfers(bool value) =>
      setField<bool>('automatic_transfers', value);
}
