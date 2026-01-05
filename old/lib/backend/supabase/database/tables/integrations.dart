import '../database.dart';

class IntegrationsTable extends SupabaseTable<IntegrationsRow> {
  @override
  String get tableName => 'integrations';

  @override
  IntegrationsRow createRow(Map<String, dynamic> data) => IntegrationsRow(data);
}

class IntegrationsRow extends SupabaseDataRow {
  IntegrationsRow(super.data);

  @override
  SupabaseTable get table => IntegrationsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get clientId => getField<int>('client_id');
  set clientId(int? value) => setField<int>('client_id', value);

  String? get tokenName => getField<String>('token_name');
  set tokenName(String? value) => setField<String>('token_name', value);

  String? get tokenValue => getField<String>('token_value');
  set tokenValue(String? value) => setField<String>('token_value', value);

  double? get expiresIn => getField<double>('expires_in');
  set expiresIn(double? value) => setField<double>('expires_in', value);

  String? get integration => getField<String>('integration');
  set integration(String? value) => setField<String>('integration', value);
}
