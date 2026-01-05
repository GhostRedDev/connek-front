import '../database.dart';

class ClientTable extends SupabaseTable<ClientRow> {
  @override
  String get tableName => 'client';

  @override
  ClientRow createRow(Map<String, dynamic> data) => ClientRow(data);
}

class ClientRow extends SupabaseDataRow {
  ClientRow(super.data);

  @override
  SupabaseTable get table => ClientTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get firstName => getField<String>('first_name');
  set firstName(String? value) => setField<String>('first_name', value);

  String get lastName => getField<String>('last_name')!;
  set lastName(String value) => setField<String>('last_name', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  int? get phone => getField<int>('phone');
  set phone(int? value) => setField<int>('phone', value);

  bool? get hasBusiness => getField<bool>('has_business');
  set hasBusiness(bool? value) => setField<bool>('has_business', value);

  String? get stripeId => getField<String>('stripe_id');
  set stripeId(String? value) => setField<String>('stripe_id', value);

  String? get photoId => getField<String>('photo_id');
  set photoId(String? value) => setField<String>('photo_id', value);

  DateTime? get dob => getField<DateTime>('dob');
  set dob(DateTime? value) => setField<DateTime>('dob', value);

  String? get aboutMe => getField<String>('about_me');
  set aboutMe(String? value) => setField<String>('about_me', value);

  String? get workingAt => getField<String>('working_at');
  set workingAt(String? value) => setField<String>('working_at', value);

  String? get profileUrl => getField<String>('profile_url');
  set profileUrl(String? value) => setField<String>('profile_url', value);

  String? get bannerUrl => getField<String>('banner_url');
  set bannerUrl(String? value) => setField<String>('banner_url', value);

  String? get fcmToken => getField<String>('fcm_token');
  set fcmToken(String? value) => setField<String>('fcm_token', value);

  bool? get verifiedIdentity => getField<bool>('verified_identity');
  set verifiedIdentity(bool? value) =>
      setField<bool>('verified_identity', value);

  String get images => getField<String>('images')!;
  set images(String value) => setField<String>('images', value);
}
