class GregModel {
  final int id;
  final String cancellationPolicy;
  final bool allowRescheduling;
  final bool cancellationMotive;
  final List<String> procedures;
  final String privacyPolicy;
  final String paymentPolicy;
  final List<String> acceptedPaymentMethods;
  final bool requirePaymentProof;
  final String refundPolicy;
  final String? refundPolicyDetails;
  final int escalationTimeMinutes;

  GregModel({
    required this.id,
    this.cancellationPolicy = '',
    this.allowRescheduling = false,
    this.cancellationMotive = false,
    this.procedures = const [],
    this.privacyPolicy = '',
    this.paymentPolicy = '',
    this.acceptedPaymentMethods = const [],
    this.requirePaymentProof = false,
    this.refundPolicy = '',
    this.refundPolicyDetails,
    this.escalationTimeMinutes = 0,
  });

  factory GregModel.fromJson(Map<String, dynamic> json) {
    return GregModel(
      id: json['id'] as int? ?? 0,
      cancellationPolicy: json['cancellation_policy'] as String? ?? '',
      allowRescheduling: json['allow_rescheduling'] as bool? ?? false,
      cancellationMotive: json['cancellation_motive'] as bool? ?? false,
      procedures:
          (json['procedures'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cancellation_policy': cancellationPolicy,
      'allow_rescheduling': allowRescheduling,
      'cancellation_motive': cancellationMotive,
      'procedures': procedures,
      'privacy_policy': privacyPolicy,
      'payment_policy': paymentPolicy,
      'accepted_payment_methods': acceptedPaymentMethods,
      'require_payment_proof': requirePaymentProof,
      'refund_policy': refundPolicy,
      'refund_policy_details': refundPolicyDetails,
      'escalation_time_minutes': escalationTimeMinutes,
    };
  }

  GregModel copyWith({
    String? cancellationPolicy,
    bool? allowRescheduling,
    bool? cancellationMotive,
    List<String>? procedures,
    String? privacyPolicy,
    String? paymentPolicy,
    List<String>? acceptedPaymentMethods,
    bool? requirePaymentProof,
    String? refundPolicy,
    String? refundPolicyDetails,
    int? escalationTimeMinutes,
  }) {
    return GregModel(
      id: this.id,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      allowRescheduling: allowRescheduling ?? this.allowRescheduling,
      cancellationMotive: cancellationMotive ?? this.cancellationMotive,
      procedures: procedures ?? this.procedures,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      paymentPolicy: paymentPolicy ?? this.paymentPolicy,
      acceptedPaymentMethods:
          acceptedPaymentMethods ?? this.acceptedPaymentMethods,
      requirePaymentProof: requirePaymentProof ?? this.requirePaymentProof,
      refundPolicy: refundPolicy ?? this.refundPolicy,
      refundPolicyDetails: refundPolicyDetails ?? this.refundPolicyDetails,
      escalationTimeMinutes:
          escalationTimeMinutes ?? this.escalationTimeMinutes,
    );
  }
}
