import '../database.dart';

class BalanceTable extends SupabaseTable<BalanceRow> {
  @override
  String get tableName => 'balance';

  @override
  BalanceRow createRow(Map<String, dynamic> data) => BalanceRow(data);
}

class BalanceRow extends SupabaseDataRow {
  BalanceRow(super.data);

  @override
  SupabaseTable get table => BalanceTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get balanceCents => getField<int>('balance_cents')!;
  set balanceCents(int value) => setField<int>('balance_cents', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);
}
