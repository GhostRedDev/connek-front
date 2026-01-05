import '../database.dart';

class RequestsTable extends SupabaseTable<RequestsRow> {
  @override
  String get tableName => 'requests';

  @override
  RequestsRow createRow(Map<String, dynamic> data) => RequestsRow(data);
}

class RequestsRow extends SupabaseDataRow {
  RequestsRow(super.data);

  @override
  SupabaseTable get table => RequestsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  int? get budgetMinCents => getField<int>('budget_min_cents');
  set budgetMinCents(int? value) => setField<int>('budget_min_cents', value);

  int? get budgetMaxCents => getField<int>('budget_max_cents');
  set budgetMaxCents(int? value) => setField<int>('budget_max_cents', value);

  bool get isDirect => getField<bool>('is_direct')!;
  set isDirect(bool value) => setField<bool>('is_direct', value);

  bool get clientContacted => getField<bool>('client_contacted')!;
  set clientContacted(bool value) => setField<bool>('client_contacted', value);

  bool get proposalSent => getField<bool>('proposal_sent')!;
  set proposalSent(bool value) => setField<bool>('proposal_sent', value);

  bool get proposalAccepted => getField<bool>('proposal_accepted')!;
  set proposalAccepted(bool value) =>
      setField<bool>('proposal_accepted', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  bool get paymentMade => getField<bool>('payment_made')!;
  set paymentMade(bool value) => setField<bool>('payment_made', value);

  bool get bookingMade => getField<bool>('booking_made')!;
  set bookingMade(bool value) => setField<bool>('booking_made', value);

  int? get serviceId => getField<int>('service_id');
  set serviceId(int? value) => setField<int>('service_id', value);

  String? get files => getField<String>('files');
  set files(String? value) => setField<String>('files', value);

  int? get oboBusinessId => getField<int>('obo_business_id');
  set oboBusinessId(int? value) => setField<int>('obo_business_id', value);
}
