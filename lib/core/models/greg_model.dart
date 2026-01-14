import 'dart:convert';

class GregModel {
  final int id;
  final int businessId;
  final String cancellations; // Renamed from cancellationPolicy
  final bool allowRescheduling;
  final bool cancellationMotive;
  final List<String> procedures;
  final String? proceduresDetails;
  final String? postBookingProcedures;
  final String privacyPolicy;
  final String paymentPolicy;
  final List<String> acceptedPaymentMethods;
  final bool requirePaymentProof;
  final String refundPolicy;
  final String? refundPolicyDetails;
  final int escalationTimeMinutes;
  final List<String> cancellationDocuments;
  final List<String> blacklist;
  final List<Map<String, String>> excludedPhones;
  final List<Map<String, String>> library;
  final String conversationTone;
  final bool notifications;
  final bool active;

  // Added missing fields from backend
  final String saveInformation;
  final bool askForConsent;
  final String? informationNotToShare;
  final List<Map<String, String>>? customPolicies;

  GregModel({
    required this.id,
    required this.businessId,
    this.cancellations = '',
    this.allowRescheduling = false,
    this.cancellationMotive = false,
    this.procedures = const [],
    this.proceduresDetails,
    this.postBookingProcedures,
    this.privacyPolicy = '',
    this.paymentPolicy = '',
    this.acceptedPaymentMethods = const [],
    this.requirePaymentProof = false,
    this.refundPolicy = '',
    this.refundPolicyDetails,
    this.escalationTimeMinutes = 0,
    this.cancellationDocuments = const [],
    this.blacklist = const [],
    this.excludedPhones = const [],
    this.library = const [],
    this.conversationTone = 'friendly',
    this.notifications = true,
    this.active = true,
    this.saveInformation = 'nothing',
    this.askForConsent = false,
    this.informationNotToShare,
    this.customPolicies,
  });

  static List<T> _parseList<T>(
    dynamic jsonValue, [
    T Function(dynamic)? mapper,
  ]) {
    if (jsonValue == null) return [];
    List<dynamic> list;
    if (jsonValue is String) {
      try {
        final decoded = json.decode(jsonValue);
        if (decoded is List) {
          list = decoded;
        } else {
          return [];
        }
      } catch (e) {
        return [];
      }
    } else if (jsonValue is List) {
      list = jsonValue;
    } else {
      return [];
    }

    if (mapper != null) {
      return list.map((e) => mapper(e)).toList();
    }
    return list.cast<T>();
  }

  factory GregModel.fromJson(Map<String, dynamic> map) {
    return GregModel(
      id: map['id'] as int? ?? 0,
      businessId: map['business_id'] as int? ?? 0,
      cancellations:
          map['cancellations'] as String? ??
          map['cancellation_policy'] as String? ??
          '',
      allowRescheduling: map['allow_rescheduling'] as bool? ?? false,
      cancellationMotive: map['cancellation_motive'] as bool? ?? false,
      procedures: _parseList<String>(map['procedures'], (e) => e.toString()),
      proceduresDetails: map['procedures_details'] as String?,
      postBookingProcedures: map['post_booking_procedures'] as String?,
      privacyPolicy: map['privacy_policy'] as String? ?? '',
      paymentPolicy: map['payment_policy'] as String? ?? '',
      acceptedPaymentMethods: _parseList<String>(
        map['accepted_payment_methods'],
        (e) => e.toString(),
      ),
      requirePaymentProof: map['require_payment_proof'] as bool? ?? false,
      refundPolicy: map['refund_policy'] as String? ?? '',
      refundPolicyDetails: map['refund_policy_details'] as String?,
      escalationTimeMinutes: map['escalation_time_minutes'] as int? ?? 0,
      cancellationDocuments: _parseList<String>(
        map['cancellation_documents'],
        (e) => e.toString(),
      ),
      blacklist: _parseList<String>(
        map['blacklist'] ?? map['black_list'],
        (e) => e.toString(),
      ),
      excludedPhones: _parseList<Map<String, String>>(map['excluded_phones'], (
        e,
      ) {
        if (e is Map) {
          return e.map((k, v) => MapEntry(k.toString(), v.toString()));
        }
        return {};
      }),
      library: _parseList<Map<String, String>>(map['library'], (e) {
        if (e is Map) {
          return e.map((k, v) => MapEntry(k.toString(), v.toString()));
        }
        return {};
      }),
      conversationTone: map['conversation_tone'] as String? ?? 'friendly',
      notifications: map['notifications'] as bool? ?? true,
      active: map['active'] as bool? ?? true,
      saveInformation: map['save_information'] as String? ?? 'nothing',
      askForConsent: map['ask_for_consent'] as bool? ?? false,
      informationNotToShare: map['information_not_to_share'] as String?,
      customPolicies: _parseList<Map<String, String>>(map['custom_policies'], (
        e,
      ) {
        if (e is Map) {
          return e.map((k, v) => MapEntry(k.toString(), v.toString()));
        }
        return {};
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'cancellations': cancellations,
      'allow_rescheduling': allowRescheduling,
      'cancellation_motive': cancellationMotive,
      'procedures': procedures,
      'procedures_details': proceduresDetails,
      'post_booking_procedures': postBookingProcedures,
      'privacy_policy': privacyPolicy,
      'payment_policy': paymentPolicy,
      'accepted_payment_methods': acceptedPaymentMethods,
      'require_payment_proof': requirePaymentProof,
      'refund_policy': refundPolicy,
      'refund_policy_details': refundPolicyDetails,
      'escalation_time_minutes': escalationTimeMinutes,
      'cancellation_documents': cancellationDocuments,
      'blacklist': blacklist,
      'excluded_phones': excludedPhones,
      'library': library,
      'conversation_tone': conversationTone,
      'notifications': notifications,
      'active': active,
      'save_information': saveInformation,
      'ask_for_consent': askForConsent,
      'information_not_to_share': informationNotToShare,
      'custom_policies': customPolicies,
    };
  }

  GregModel copyWith({
    int? id,
    int? businessId,
    String? cancellations,
    bool? allowRescheduling,
    bool? cancellationMotive,
    List<String>? procedures,
    String? proceduresDetails,
    String? postBookingProcedures,
    String? privacyPolicy,
    String? paymentPolicy,
    List<String>? acceptedPaymentMethods,
    bool? requirePaymentProof,
    String? refundPolicy,
    String? refundPolicyDetails,
    int? escalationTimeMinutes,
    List<String>? cancellationDocuments,
    List<String>? blacklist,
    List<Map<String, String>>? excludedPhones,
    List<Map<String, String>>? library,
    String? conversationTone,
    bool? notifications,
    bool? active,
    String? saveInformation,
    bool? askForConsent,
    String? informationNotToShare,
    List<Map<String, String>>? customPolicies,
  }) {
    return GregModel(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      cancellations: cancellations ?? this.cancellations,
      allowRescheduling: allowRescheduling ?? this.allowRescheduling,
      cancellationMotive: cancellationMotive ?? this.cancellationMotive,
      procedures: procedures ?? this.procedures,
      proceduresDetails: proceduresDetails ?? this.proceduresDetails,
      postBookingProcedures:
          postBookingProcedures ?? this.postBookingProcedures,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      paymentPolicy: paymentPolicy ?? this.paymentPolicy,
      acceptedPaymentMethods:
          acceptedPaymentMethods ?? this.acceptedPaymentMethods,
      requirePaymentProof: requirePaymentProof ?? this.requirePaymentProof,
      refundPolicy: refundPolicy ?? this.refundPolicy,
      refundPolicyDetails: refundPolicyDetails ?? this.refundPolicyDetails,
      escalationTimeMinutes:
          escalationTimeMinutes ?? this.escalationTimeMinutes,
      cancellationDocuments:
          cancellationDocuments ?? this.cancellationDocuments,
      blacklist: blacklist ?? this.blacklist,
      excludedPhones: excludedPhones ?? this.excludedPhones,
      library: library ?? this.library,
      conversationTone: conversationTone ?? this.conversationTone,
      notifications: notifications ?? this.notifications,
      active: active ?? this.active,
      saveInformation: saveInformation ?? this.saveInformation,
      askForConsent: askForConsent ?? this.askForConsent,
      informationNotToShare:
          informationNotToShare ?? this.informationNotToShare,
      customPolicies: customPolicies ?? this.customPolicies,
    );
  }
}
