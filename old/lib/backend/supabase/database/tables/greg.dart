import '../database.dart';

class GregTable extends SupabaseTable<GregRow> {
  @override
  String get tableName => 'greg';

  @override
  GregRow createRow(Map<String, dynamic> data) => GregRow(data);
}

class GregRow extends SupabaseDataRow {
  GregRow(super.data);

  @override
  SupabaseTable get table => GregTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get businessId => getField<int>('business_id')!;
  set businessId(int value) => setField<int>('business_id', value);

  bool get active => getField<bool>('active')!;
  set active(bool value) => setField<bool>('active', value);

  String get conversationTone => getField<String>('conversation_tone')!;
  set conversationTone(String value) =>
      setField<String>('conversation_tone', value);

  dynamic get blacklist => getField<dynamic>('blacklist')!;
  set blacklist(dynamic value) => setField<dynamic>('blacklist', value);

  bool get notifications => getField<bool>('notifications')!;
  set notifications(bool value) => setField<bool>('notifications', value);

  String? get cancellations => getField<String>('cancellations');
  set cancellations(String? value) => setField<String>('cancellations', value);

  bool get allowRescheduling => getField<bool>('allow_rescheduling')!;
  set allowRescheduling(bool value) =>
      setField<bool>('allow_rescheduling', value);

  bool? get cancellationMotive => getField<bool>('cancellation_motive');
  set cancellationMotive(bool? value) =>
      setField<bool>('cancellation_motive', value);

  List<String> get acceptedPaymentMethods =>
      getListField<String>('accepted_payment_methods');
  set acceptedPaymentMethods(List<String> value) =>
      setListField<String>('accepted_payment_methods', value);

  String? get paymentPolicy => getField<String>('payment_policy');
  set paymentPolicy(String? value) => setField<String>('payment_policy', value);

  String? get refundPolicy => getField<String>('refund_policy');
  set refundPolicy(String? value) => setField<String>('refund_policy', value);

  List<String> get procedures => getListField<String>('procedures');
  set procedures(List<String>? value) =>
      setListField<String>('procedures', value);

  String? get proceduresDetails => getField<String>('procedures_details');
  set proceduresDetails(String? value) =>
      setField<String>('procedures_details', value);

  String? get saveInformation => getField<String>('save_information');
  set saveInformation(String? value) =>
      setField<String>('save_information', value);

  bool get askForConsent => getField<bool>('ask_for_consent')!;
  set askForConsent(bool value) => setField<bool>('ask_for_consent', value);

  String? get privacyPolicy => getField<String>('privacy_policy');
  set privacyPolicy(String? value) => setField<String>('privacy_policy', value);

  String? get informationNotToShare =>
      getField<String>('information_not_to_share');
  set informationNotToShare(String? value) =>
      setField<String>('information_not_to_share', value);

  List<dynamic> get excludedPhones => getListField<dynamic>('excluded_phones');
  set excludedPhones(List<dynamic>? value) =>
      setListField<dynamic>('excluded_phones', value);

  dynamic get customPolicies => getField<dynamic>('custom_policies');
  set customPolicies(dynamic value) =>
      setField<dynamic>('custom_policies', value);

  dynamic get library => getField<dynamic>('library');
  set library(dynamic value) => setField<dynamic>('library', value);

  int? get escalationTimeMinutes => getField<int>('escalation_time_minutes');
  set escalationTimeMinutes(int? value) =>
      setField<int>('escalation_time_minutes', value);

  String? get refundPolicyDetails => getField<String>('refund_policy_details');
  set refundPolicyDetails(String? value) =>
      setField<String>('refund_policy_details', value);

  List<String> get cancellationDocuments =>
      getListField<String>('cancellation_documents');
  set cancellationDocuments(List<String>? value) =>
      setListField<String>('cancellation_documents', value);

  bool? get requirePaymentProof => getField<bool>('require_payment_proof');
  set requirePaymentProof(bool? value) =>
      setField<bool>('require_payment_proof', value);

  String? get postBookingProcedures =>
      getField<String>('post_booking_procedures');
  set postBookingProcedures(String? value) =>
      setField<String>('post_booking_procedures', value);
}
