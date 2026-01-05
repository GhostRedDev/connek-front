import '../database.dart';

class PreferencesTable extends SupabaseTable<PreferencesRow> {
  @override
  String get tableName => 'preferences';

  @override
  PreferencesRow createRow(Map<String, dynamic> data) => PreferencesRow(data);
}

class PreferencesRow extends SupabaseDataRow {
  PreferencesRow(super.data);

  @override
  SupabaseTable get table => PreferencesTable();

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  bool get pushEnabled => getField<bool>('push_enabled')!;
  set pushEnabled(bool value) => setField<bool>('push_enabled', value);

  bool get emailEnabled => getField<bool>('email_enabled')!;
  set emailEnabled(bool value) => setField<bool>('email_enabled', value);

  bool get smsEnabled => getField<bool>('sms_enabled')!;
  set smsEnabled(bool value) => setField<bool>('sms_enabled', value);

  bool get notifyMessages => getField<bool>('notify_messages')!;
  set notifyMessages(bool value) => setField<bool>('notify_messages', value);

  bool get notifyBookings => getField<bool>('notify_bookings')!;
  set notifyBookings(bool value) => setField<bool>('notify_bookings', value);

  bool get notifyPayments => getField<bool>('notify_payments')!;
  set notifyPayments(bool value) => setField<bool>('notify_payments', value);

  bool get notifyPromotions => getField<bool>('notify_promotions')!;
  set notifyPromotions(bool value) =>
      setField<bool>('notify_promotions', value);

  bool get notifySystem => getField<bool>('notify_system')!;
  set notifySystem(bool value) => setField<bool>('notify_system', value);

  bool get doNotDisturb => getField<bool>('do_not_disturb')!;
  set doNotDisturb(bool value) => setField<bool>('do_not_disturb', value);

  PostgresTime? get dndStart => getField<PostgresTime>('dnd_start');
  set dndStart(PostgresTime? value) =>
      setField<PostgresTime>('dnd_start', value);

  PostgresTime? get dndEnd => getField<PostgresTime>('dnd_end');
  set dndEnd(PostgresTime? value) => setField<PostgresTime>('dnd_end', value);

  String? get timezone => getField<String>('timezone');
  set timezone(String? value) => setField<String>('timezone', value);

  bool get marketingOptIn => getField<bool>('marketing_opt_in')!;
  set marketingOptIn(bool value) => setField<bool>('marketing_opt_in', value);

  String? get language => getField<String>('language');
  set language(String? value) => setField<String>('language', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);

  int? get businessMain => getField<int>('business_main');
  set businessMain(int? value) => setField<int>('business_main', value);
}
