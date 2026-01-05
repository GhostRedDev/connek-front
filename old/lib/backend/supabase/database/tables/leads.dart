import '../database.dart';

class LeadsTable extends SupabaseTable<LeadsRow> {
  @override
  String get tableName => 'leads';

  @override
  LeadsRow createRow(Map<String, dynamic> data) => LeadsRow(data);
}

class LeadsRow extends SupabaseDataRow {
  LeadsRow(super.data);

  @override
  SupabaseTable get table => LeadsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  int? get requestId => getField<int>('request_id');
  set requestId(int? value) => setField<int>('request_id', value);

  bool get seen => getField<bool>('seen')!;
  set seen(bool value) => setField<bool>('seen', value);

  bool get clientContacted => getField<bool>('client_contacted')!;
  set clientContacted(bool value) => setField<bool>('client_contacted', value);

  bool get bookingMade => getField<bool>('booking_made')!;
  set bookingMade(bool value) => setField<bool>('booking_made', value);

  bool get paymentMade => getField<bool>('payment_made')!;
  set paymentMade(bool value) => setField<bool>('payment_made', value);

  bool get proposalSent => getField<bool>('proposal_sent')!;
  set proposalSent(bool value) => setField<bool>('proposal_sent', value);

  bool get proposalAccepted => getField<bool>('proposal_accepted')!;
  set proposalAccepted(bool value) =>
      setField<bool>('proposal_accepted', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  int? get serviceId => getField<int>('service_id');
  set serviceId(int? value) => setField<int>('service_id', value);
}
