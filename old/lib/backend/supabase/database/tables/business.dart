import '../database.dart';

class BusinessTable extends SupabaseTable<BusinessRow> {
  @override
  String get tableName => 'business';

  @override
  BusinessRow createRow(Map<String, dynamic> data) => BusinessRow(data);
}

class BusinessRow extends SupabaseDataRow {
  BusinessRow(super.data);

  @override
  SupabaseTable get table => BusinessTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String get category => getField<String>('category')!;
  set category(String value) => setField<String>('category', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  bool get validated => getField<bool>('validated')!;
  set validated(bool value) => setField<bool>('validated', value);

  String? get ownerUser => getField<String>('owner_user');
  set ownerUser(String? value) => setField<String>('owner_user', value);

  String? get businessEmail => getField<String>('business_email');
  set businessEmail(String? value) => setField<String>('business_email', value);

  int get ownerClientId => getField<int>('owner_client_id')!;
  set ownerClientId(int value) => setField<int>('owner_client_id', value);

  String? get stripeId => getField<String>('stripe_id');
  set stripeId(String? value) => setField<String>('stripe_id', value);

  String? get googleBusinessId => getField<String>('google_business_id');
  set googleBusinessId(String? value) =>
      setField<String>('google_business_id', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  int get addressId => getField<int>('address_id')!;
  set addressId(int value) => setField<int>('address_id', value);

  bool get payments => getField<bool>('payments')!;
  set payments(bool value) => setField<bool>('payments', value);

  int? get phone => getField<int>('phone');
  set phone(int? value) => setField<int>('phone', value);

  String? get profileImage => getField<String>('profile_image');
  set profileImage(String? value) => setField<String>('profile_image', value);

  String? get bannerImage => getField<String>('banner_image');
  set bannerImage(String? value) => setField<String>('banner_image', value);

  String? get instagramHandle => getField<String>('instagram_handle');
  set instagramHandle(String? value) =>
      setField<String>('instagram_handle', value);

  String? get tiktokHandle => getField<String>('tiktok_handle');
  set tiktokHandle(String? value) => setField<String>('tiktok_handle', value);

  String? get facebookHandle => getField<String>('facebook_handle');
  set facebookHandle(String? value) =>
      setField<String>('facebook_handle', value);

  String? get whatsappHandle => getField<String>('whatsapp_handle');
  set whatsappHandle(String? value) =>
      setField<String>('whatsapp_handle', value);

  String? get images => getField<String>('images');
  set images(String? value) => setField<String>('images', value);

  dynamic get openingHours => getField<dynamic>('opening_hours');
  set openingHours(dynamic value) => setField<dynamic>('opening_hours', value);

  String? get customerId => getField<String>('customer_id');
  set customerId(String? value) => setField<String>('customer_id', value);
}
