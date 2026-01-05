import '../database.dart';

class QuoteTable extends SupabaseTable<QuoteRow> {
  @override
  String get tableName => 'quote';

  @override
  QuoteRow createRow(Map<String, dynamic> data) => QuoteRow(data);
}

class QuoteRow extends SupabaseDataRow {
  QuoteRow(super.data);

  @override
  SupabaseTable get table => QuoteTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get leadId => getField<int>('lead_id')!;
  set leadId(int value) => setField<int>('lead_id', value);

  int? get serviceId => getField<int>('service_id');
  set serviceId(int? value) => setField<int>('service_id', value);

  int get amountCents => getField<int>('amountCents')!;
  set amountCents(int value) => setField<int>('amountCents', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  DateTime? get expiring => getField<DateTime>('expiring');
  set expiring(DateTime? value) => setField<DateTime>('expiring', value);

  bool get paid => getField<bool>('paid')!;
  set paid(bool value) => setField<bool>('paid', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);
}
