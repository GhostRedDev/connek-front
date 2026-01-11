class GregModel {
  final int id;
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
  final List<Map<String, String>> excludedPhones;
  final List<Map<String, String>> library;
  final String conversationTone;
  final bool notifications;
  final bool active;

  // Added missing fields from backend
  final String saveInformation;
  final bool askForConsent;
  final String? informationNotToShare;
  final String? customPolicies;

  GregModel({
    required this.id,
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

  factory GregModel.fromJson(Map<String, dynamic> json) {
    return GregModel(
      id: json['id'] as int? ?? 0,
      cancellations:
          json['cancellations'] as String? ??
          json['cancellation_policy'] as String? ??
          '',
      allowRescheduling: json['allow_rescheduling'] as bool? ?? false,
      cancellationMotive: json['cancellation_motive'] as bool? ?? false,
      procedures:
          (json['procedures'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      proceduresDetails: json['procedures_details'] as String?,
      postBookingProcedures: json['post_booking_procedures'] as String?,
      privacyPolicy: json['privacy_policy'] as String? ?? '',
      paymentPolicy: json['payment_policy'] as String? ?? '',
      acceptedPaymentMethods:
          (json['accepted_payment_methods'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      requirePaymentProof: json['require_payment_proof'] as bool? ?? false,
      refundPolicy: json['refund_policy'] as String? ?? '',
      refundPolicyDetails: json['refund_policy_details'] as String?,
      escalationTimeMinutes: json['escalation_time_minutes'] as int? ?? 0,
      cancellationDocuments:
          (json['cancellation_documents'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      excludedPhones: (json['blacklist'] is List)
          ? (json['blacklist'] as List)
                .map((e) => Map<String, String>.from(e as Map))
                .toList()
          : (json['excluded_phones'] is List)
          ? (json['excluded_phones'] as List)
                .map((e) => Map<String, String>.from(e as Map))
                .toList()
          : [],
      library: (json['library'] is List)
          ? (json['library'] as List)
                .map((e) => Map<String, String>.from(e as Map))
                .toList()
          : [],
      conversationTone: json['conversation_tone'] as String? ?? 'friendly',
      notifications: json['notifications'] as bool? ?? true,
      active: json['active'] as bool? ?? true,
      saveInformation: json['save_information'] as String? ?? 'nothing',
      askForConsent:
          json['ask_for_consent'] as bool? ??
          json['ask_for_consent'] as bool? ??
          false,
      informationNotToShare: json['information_not_to_share'] as String?,
      customPolicies: json['custom_policies'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'blacklist': excludedPhones,
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
    List<Map<String, String>>? excludedPhones,
    List<Map<String, String>>? library,
    String? conversationTone,
    bool? notifications,
    bool? active,
    String? saveInformation,
    bool? askForConsent,
    String? informationNotToShare,
    String? customPolicies,
  }) {
    return GregModel(
      id: id,
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
