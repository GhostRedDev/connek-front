import '../database.dart';

class BookingsTable extends SupabaseTable<BookingsRow> {
  @override
  String get tableName => 'bookings';

  @override
  BookingsRow createRow(Map<String, dynamic> data) => BookingsRow(data);
}

class BookingsRow extends SupabaseDataRow {
  BookingsRow(super.data);

  @override
  SupabaseTable get table => BookingsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  int get businessId => getField<int>('business_id')!;
  set businessId(int value) => setField<int>('business_id', value);

  int get addressId => getField<int>('address_id')!;
  set addressId(int value) => setField<int>('address_id', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  int? get requestId => getField<int>('request_id');
  set requestId(int? value) => setField<int>('request_id', value);

  DateTime get startTimeUtc => getField<DateTime>('start_time_utc')!;
  set startTimeUtc(DateTime value) =>
      setField<DateTime>('start_time_utc', value);

  DateTime? get endTimeUtc => getField<DateTime>('end_time_utc');
  set endTimeUtc(DateTime? value) => setField<DateTime>('end_time_utc', value);

  int? get quoteId => getField<int>('quote_id');
  set quoteId(int? value) => setField<int>('quote_id', value);

  int? get resourceId => getField<int>('resource_id');
  set resourceId(int? value) => setField<int>('resource_id', value);

  int? get oboBusinessId => getField<int>('obo_business_id');
  set oboBusinessId(int? value) => setField<int>('obo_business_id', value);
}
