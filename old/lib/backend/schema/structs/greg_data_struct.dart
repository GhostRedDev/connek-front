// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GregDataStruct extends BaseStruct {
  GregDataStruct({
    int? businessId,
    bool? active,
    String? conversationTone,
    List<String>? blacklist,
    bool? notifications,
    int? gregId,
    String? cancellations,
    bool? cancellationMotive,
    List<String>? cancellationDocuments,
    int? escalationTimeMinutes,
    bool? allowRescheduling,
    List<String>? acceptedPaymentMethods,
    String? refundPolicy,
    String? refundPolicyDetails,
    String? paymentPolicy,
    List<String>? procedures,
    String? proceduresDetails,
    String? saveInformation,
    bool? askForConsent,
    String? privacyPolicy,
    String? informationNotToShare,
    List<ContactStructStruct>? excludedPhones,
    List<GregPoliciesStruct>? customPolicies,
    List<LibraryFileStruct>? library,
    bool? requirePaymentProof,
    String? postBookingProcedures,
  })  : _businessId = businessId,
        _active = active,
        _conversationTone = conversationTone,
        _blacklist = blacklist,
        _notifications = notifications,
        _gregId = gregId,
        _cancellations = cancellations,
        _cancellationMotive = cancellationMotive,
        _cancellationDocuments = cancellationDocuments,
        _escalationTimeMinutes = escalationTimeMinutes,
        _allowRescheduling = allowRescheduling,
        _acceptedPaymentMethods = acceptedPaymentMethods,
        _refundPolicy = refundPolicy,
        _refundPolicyDetails = refundPolicyDetails,
        _paymentPolicy = paymentPolicy,
        _procedures = procedures,
        _proceduresDetails = proceduresDetails,
        _saveInformation = saveInformation,
        _askForConsent = askForConsent,
        _privacyPolicy = privacyPolicy,
        _informationNotToShare = informationNotToShare,
        _excludedPhones = excludedPhones,
        _customPolicies = customPolicies,
        _library = library,
        _requirePaymentProof = requirePaymentProof,
        _postBookingProcedures = postBookingProcedures;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  set active(bool? val) => _active = val;

  bool hasActive() => _active != null;

  // "conversationTone" field.
  String? _conversationTone;
  String get conversationTone => _conversationTone ?? '';
  set conversationTone(String? val) => _conversationTone = val;

  bool hasConversationTone() => _conversationTone != null;

  // "blacklist" field.
  List<String>? _blacklist;
  List<String> get blacklist => _blacklist ?? const [];
  set blacklist(List<String>? val) => _blacklist = val;

  void updateBlacklist(Function(List<String>) updateFn) {
    updateFn(_blacklist ??= []);
  }

  bool hasBlacklist() => _blacklist != null;

  // "notifications" field.
  bool? _notifications;
  bool get notifications => _notifications ?? false;
  set notifications(bool? val) => _notifications = val;

  bool hasNotifications() => _notifications != null;

  // "gregId" field.
  int? _gregId;
  int get gregId => _gregId ?? 0;
  set gregId(int? val) => _gregId = val;

  void incrementGregId(int amount) => gregId = gregId + amount;

  bool hasGregId() => _gregId != null;

  // "cancellations" field.
  String? _cancellations;
  String get cancellations => _cancellations ?? '';
  set cancellations(String? val) => _cancellations = val;

  bool hasCancellations() => _cancellations != null;

  // "cancellationMotive" field.
  bool? _cancellationMotive;
  bool get cancellationMotive => _cancellationMotive ?? false;
  set cancellationMotive(bool? val) => _cancellationMotive = val;

  bool hasCancellationMotive() => _cancellationMotive != null;

  // "cancellationDocuments" field.
  List<String>? _cancellationDocuments;
  List<String> get cancellationDocuments => _cancellationDocuments ?? const [];
  set cancellationDocuments(List<String>? val) => _cancellationDocuments = val;

  void updateCancellationDocuments(Function(List<String>) updateFn) {
    updateFn(_cancellationDocuments ??= []);
  }

  bool hasCancellationDocuments() => _cancellationDocuments != null;

  // "escalationTimeMinutes" field.
  int? _escalationTimeMinutes;
  int get escalationTimeMinutes => _escalationTimeMinutes ?? 0;
  set escalationTimeMinutes(int? val) => _escalationTimeMinutes = val;

  void incrementEscalationTimeMinutes(int amount) =>
      escalationTimeMinutes = escalationTimeMinutes + amount;

  bool hasEscalationTimeMinutes() => _escalationTimeMinutes != null;

  // "allowRescheduling" field.
  bool? _allowRescheduling;
  bool get allowRescheduling => _allowRescheduling ?? false;
  set allowRescheduling(bool? val) => _allowRescheduling = val;

  bool hasAllowRescheduling() => _allowRescheduling != null;

  // "acceptedPaymentMethods" field.
  List<String>? _acceptedPaymentMethods;
  List<String> get acceptedPaymentMethods =>
      _acceptedPaymentMethods ?? const [];
  set acceptedPaymentMethods(List<String>? val) =>
      _acceptedPaymentMethods = val;

  void updateAcceptedPaymentMethods(Function(List<String>) updateFn) {
    updateFn(_acceptedPaymentMethods ??= []);
  }

  bool hasAcceptedPaymentMethods() => _acceptedPaymentMethods != null;

  // "refundPolicy" field.
  String? _refundPolicy;
  String get refundPolicy => _refundPolicy ?? '';
  set refundPolicy(String? val) => _refundPolicy = val;

  bool hasRefundPolicy() => _refundPolicy != null;

  // "refundPolicyDetails" field.
  String? _refundPolicyDetails;
  String get refundPolicyDetails => _refundPolicyDetails ?? '';
  set refundPolicyDetails(String? val) => _refundPolicyDetails = val;

  bool hasRefundPolicyDetails() => _refundPolicyDetails != null;

  // "paymentPolicy" field.
  String? _paymentPolicy;
  String get paymentPolicy => _paymentPolicy ?? '';
  set paymentPolicy(String? val) => _paymentPolicy = val;

  bool hasPaymentPolicy() => _paymentPolicy != null;

  // "procedures" field.
  List<String>? _procedures;
  List<String> get procedures => _procedures ?? const [];
  set procedures(List<String>? val) => _procedures = val;

  void updateProcedures(Function(List<String>) updateFn) {
    updateFn(_procedures ??= []);
  }

  bool hasProcedures() => _procedures != null;

  // "proceduresDetails" field.
  String? _proceduresDetails;
  String get proceduresDetails => _proceduresDetails ?? '';
  set proceduresDetails(String? val) => _proceduresDetails = val;

  bool hasProceduresDetails() => _proceduresDetails != null;

  // "saveInformation" field.
  String? _saveInformation;
  String get saveInformation => _saveInformation ?? '';
  set saveInformation(String? val) => _saveInformation = val;

  bool hasSaveInformation() => _saveInformation != null;

  // "askForConsent" field.
  bool? _askForConsent;
  bool get askForConsent => _askForConsent ?? false;
  set askForConsent(bool? val) => _askForConsent = val;

  bool hasAskForConsent() => _askForConsent != null;

  // "privacyPolicy" field.
  String? _privacyPolicy;
  String get privacyPolicy => _privacyPolicy ?? '';
  set privacyPolicy(String? val) => _privacyPolicy = val;

  bool hasPrivacyPolicy() => _privacyPolicy != null;

  // "informationNotToShare" field.
  String? _informationNotToShare;
  String get informationNotToShare => _informationNotToShare ?? '';
  set informationNotToShare(String? val) => _informationNotToShare = val;

  bool hasInformationNotToShare() => _informationNotToShare != null;

  // "excludedPhones" field.
  List<ContactStructStruct>? _excludedPhones;
  List<ContactStructStruct> get excludedPhones => _excludedPhones ?? const [];
  set excludedPhones(List<ContactStructStruct>? val) => _excludedPhones = val;

  void updateExcludedPhones(Function(List<ContactStructStruct>) updateFn) {
    updateFn(_excludedPhones ??= []);
  }

  bool hasExcludedPhones() => _excludedPhones != null;

  // "customPolicies" field.
  List<GregPoliciesStruct>? _customPolicies;
  List<GregPoliciesStruct> get customPolicies => _customPolicies ?? const [];
  set customPolicies(List<GregPoliciesStruct>? val) => _customPolicies = val;

  void updateCustomPolicies(Function(List<GregPoliciesStruct>) updateFn) {
    updateFn(_customPolicies ??= []);
  }

  bool hasCustomPolicies() => _customPolicies != null;

  // "library" field.
  List<LibraryFileStruct>? _library;
  List<LibraryFileStruct> get library => _library ?? const [];
  set library(List<LibraryFileStruct>? val) => _library = val;

  void updateLibrary(Function(List<LibraryFileStruct>) updateFn) {
    updateFn(_library ??= []);
  }

  bool hasLibrary() => _library != null;

  // "requirePaymentProof" field.
  bool? _requirePaymentProof;
  bool get requirePaymentProof => _requirePaymentProof ?? false;
  set requirePaymentProof(bool? val) => _requirePaymentProof = val;

  bool hasRequirePaymentProof() => _requirePaymentProof != null;

  // "postBookingProcedures" field.
  String? _postBookingProcedures;
  String get postBookingProcedures => _postBookingProcedures ?? '';
  set postBookingProcedures(String? val) => _postBookingProcedures = val;

  bool hasPostBookingProcedures() => _postBookingProcedures != null;

  static GregDataStruct fromMap(Map<String, dynamic> data) => GregDataStruct(
        businessId: castToType<int>(data['businessId']),
        active: data['active'] as bool?,
        conversationTone: data['conversationTone'] as String?,
        blacklist: getDataList(data['blacklist']),
        notifications: data['notifications'] as bool?,
        gregId: castToType<int>(data['gregId']),
        cancellations: data['cancellations'] as String?,
        cancellationMotive: data['cancellationMotive'] as bool?,
        cancellationDocuments: getDataList(data['cancellationDocuments']),
        escalationTimeMinutes: castToType<int>(data['escalationTimeMinutes']),
        allowRescheduling: data['allowRescheduling'] as bool?,
        acceptedPaymentMethods: getDataList(data['acceptedPaymentMethods']),
        refundPolicy: data['refundPolicy'] as String?,
        refundPolicyDetails: data['refundPolicyDetails'] as String?,
        paymentPolicy: data['paymentPolicy'] as String?,
        procedures: getDataList(data['procedures']),
        proceduresDetails: data['proceduresDetails'] as String?,
        saveInformation: data['saveInformation'] as String?,
        askForConsent: data['askForConsent'] as bool?,
        privacyPolicy: data['privacyPolicy'] as String?,
        informationNotToShare: data['informationNotToShare'] as String?,
        excludedPhones: getStructList(
          data['excludedPhones'],
          ContactStructStruct.fromMap,
        ),
        customPolicies: getStructList(
          data['customPolicies'],
          GregPoliciesStruct.fromMap,
        ),
        library: getStructList(
          data['library'],
          LibraryFileStruct.fromMap,
        ),
        requirePaymentProof: data['requirePaymentProof'] as bool?,
        postBookingProcedures: data['postBookingProcedures'] as String?,
      );

  static GregDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? GregDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'businessId': _businessId,
        'active': _active,
        'conversationTone': _conversationTone,
        'blacklist': _blacklist,
        'notifications': _notifications,
        'gregId': _gregId,
        'cancellations': _cancellations,
        'cancellationMotive': _cancellationMotive,
        'cancellationDocuments': _cancellationDocuments,
        'escalationTimeMinutes': _escalationTimeMinutes,
        'allowRescheduling': _allowRescheduling,
        'acceptedPaymentMethods': _acceptedPaymentMethods,
        'refundPolicy': _refundPolicy,
        'refundPolicyDetails': _refundPolicyDetails,
        'paymentPolicy': _paymentPolicy,
        'procedures': _procedures,
        'proceduresDetails': _proceduresDetails,
        'saveInformation': _saveInformation,
        'askForConsent': _askForConsent,
        'privacyPolicy': _privacyPolicy,
        'informationNotToShare': _informationNotToShare,
        'excludedPhones': _excludedPhones?.map((e) => e.toMap()).toList(),
        'customPolicies': _customPolicies?.map((e) => e.toMap()).toList(),
        'library': _library?.map((e) => e.toMap()).toList(),
        'requirePaymentProof': _requirePaymentProof,
        'postBookingProcedures': _postBookingProcedures,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'active': serializeParam(
          _active,
          ParamType.bool,
        ),
        'conversationTone': serializeParam(
          _conversationTone,
          ParamType.String,
        ),
        'blacklist': serializeParam(
          _blacklist,
          ParamType.String,
          isList: true,
        ),
        'notifications': serializeParam(
          _notifications,
          ParamType.bool,
        ),
        'gregId': serializeParam(
          _gregId,
          ParamType.int,
        ),
        'cancellations': serializeParam(
          _cancellations,
          ParamType.String,
        ),
        'cancellationMotive': serializeParam(
          _cancellationMotive,
          ParamType.bool,
        ),
        'cancellationDocuments': serializeParam(
          _cancellationDocuments,
          ParamType.String,
          isList: true,
        ),
        'escalationTimeMinutes': serializeParam(
          _escalationTimeMinutes,
          ParamType.int,
        ),
        'allowRescheduling': serializeParam(
          _allowRescheduling,
          ParamType.bool,
        ),
        'acceptedPaymentMethods': serializeParam(
          _acceptedPaymentMethods,
          ParamType.String,
          isList: true,
        ),
        'refundPolicy': serializeParam(
          _refundPolicy,
          ParamType.String,
        ),
        'refundPolicyDetails': serializeParam(
          _refundPolicyDetails,
          ParamType.String,
        ),
        'paymentPolicy': serializeParam(
          _paymentPolicy,
          ParamType.String,
        ),
        'procedures': serializeParam(
          _procedures,
          ParamType.String,
          isList: true,
        ),
        'proceduresDetails': serializeParam(
          _proceduresDetails,
          ParamType.String,
        ),
        'saveInformation': serializeParam(
          _saveInformation,
          ParamType.String,
        ),
        'askForConsent': serializeParam(
          _askForConsent,
          ParamType.bool,
        ),
        'privacyPolicy': serializeParam(
          _privacyPolicy,
          ParamType.String,
        ),
        'informationNotToShare': serializeParam(
          _informationNotToShare,
          ParamType.String,
        ),
        'excludedPhones': serializeParam(
          _excludedPhones,
          ParamType.DataStruct,
          isList: true,
        ),
        'customPolicies': serializeParam(
          _customPolicies,
          ParamType.DataStruct,
          isList: true,
        ),
        'library': serializeParam(
          _library,
          ParamType.DataStruct,
          isList: true,
        ),
        'requirePaymentProof': serializeParam(
          _requirePaymentProof,
          ParamType.bool,
        ),
        'postBookingProcedures': serializeParam(
          _postBookingProcedures,
          ParamType.String,
        ),
      }.withoutNulls;

  static GregDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      GregDataStruct(
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        active: deserializeParam(
          data['active'],
          ParamType.bool,
          false,
        ),
        conversationTone: deserializeParam(
          data['conversationTone'],
          ParamType.String,
          false,
        ),
        blacklist: deserializeParam<String>(
          data['blacklist'],
          ParamType.String,
          true,
        ),
        notifications: deserializeParam(
          data['notifications'],
          ParamType.bool,
          false,
        ),
        gregId: deserializeParam(
          data['gregId'],
          ParamType.int,
          false,
        ),
        cancellations: deserializeParam(
          data['cancellations'],
          ParamType.String,
          false,
        ),
        cancellationMotive: deserializeParam(
          data['cancellationMotive'],
          ParamType.bool,
          false,
        ),
        cancellationDocuments: deserializeParam<String>(
          data['cancellationDocuments'],
          ParamType.String,
          true,
        ),
        escalationTimeMinutes: deserializeParam(
          data['escalationTimeMinutes'],
          ParamType.int,
          false,
        ),
        allowRescheduling: deserializeParam(
          data['allowRescheduling'],
          ParamType.bool,
          false,
        ),
        acceptedPaymentMethods: deserializeParam<String>(
          data['acceptedPaymentMethods'],
          ParamType.String,
          true,
        ),
        refundPolicy: deserializeParam(
          data['refundPolicy'],
          ParamType.String,
          false,
        ),
        refundPolicyDetails: deserializeParam(
          data['refundPolicyDetails'],
          ParamType.String,
          false,
        ),
        paymentPolicy: deserializeParam(
          data['paymentPolicy'],
          ParamType.String,
          false,
        ),
        procedures: deserializeParam<String>(
          data['procedures'],
          ParamType.String,
          true,
        ),
        proceduresDetails: deserializeParam(
          data['proceduresDetails'],
          ParamType.String,
          false,
        ),
        saveInformation: deserializeParam(
          data['saveInformation'],
          ParamType.String,
          false,
        ),
        askForConsent: deserializeParam(
          data['askForConsent'],
          ParamType.bool,
          false,
        ),
        privacyPolicy: deserializeParam(
          data['privacyPolicy'],
          ParamType.String,
          false,
        ),
        informationNotToShare: deserializeParam(
          data['informationNotToShare'],
          ParamType.String,
          false,
        ),
        excludedPhones: deserializeStructParam<ContactStructStruct>(
          data['excludedPhones'],
          ParamType.DataStruct,
          true,
          structBuilder: ContactStructStruct.fromSerializableMap,
        ),
        customPolicies: deserializeStructParam<GregPoliciesStruct>(
          data['customPolicies'],
          ParamType.DataStruct,
          true,
          structBuilder: GregPoliciesStruct.fromSerializableMap,
        ),
        library: deserializeStructParam<LibraryFileStruct>(
          data['library'],
          ParamType.DataStruct,
          true,
          structBuilder: LibraryFileStruct.fromSerializableMap,
        ),
        requirePaymentProof: deserializeParam(
          data['requirePaymentProof'],
          ParamType.bool,
          false,
        ),
        postBookingProcedures: deserializeParam(
          data['postBookingProcedures'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GregDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is GregDataStruct &&
        businessId == other.businessId &&
        active == other.active &&
        conversationTone == other.conversationTone &&
        listEquality.equals(blacklist, other.blacklist) &&
        notifications == other.notifications &&
        gregId == other.gregId &&
        cancellations == other.cancellations &&
        cancellationMotive == other.cancellationMotive &&
        listEquality.equals(
            cancellationDocuments, other.cancellationDocuments) &&
        escalationTimeMinutes == other.escalationTimeMinutes &&
        allowRescheduling == other.allowRescheduling &&
        listEquality.equals(
            acceptedPaymentMethods, other.acceptedPaymentMethods) &&
        refundPolicy == other.refundPolicy &&
        refundPolicyDetails == other.refundPolicyDetails &&
        paymentPolicy == other.paymentPolicy &&
        listEquality.equals(procedures, other.procedures) &&
        proceduresDetails == other.proceduresDetails &&
        saveInformation == other.saveInformation &&
        askForConsent == other.askForConsent &&
        privacyPolicy == other.privacyPolicy &&
        informationNotToShare == other.informationNotToShare &&
        listEquality.equals(excludedPhones, other.excludedPhones) &&
        listEquality.equals(customPolicies, other.customPolicies) &&
        listEquality.equals(library, other.library) &&
        requirePaymentProof == other.requirePaymentProof &&
        postBookingProcedures == other.postBookingProcedures;
  }

  @override
  int get hashCode => const ListEquality().hash([
        businessId,
        active,
        conversationTone,
        blacklist,
        notifications,
        gregId,
        cancellations,
        cancellationMotive,
        cancellationDocuments,
        escalationTimeMinutes,
        allowRescheduling,
        acceptedPaymentMethods,
        refundPolicy,
        refundPolicyDetails,
        paymentPolicy,
        procedures,
        proceduresDetails,
        saveInformation,
        askForConsent,
        privacyPolicy,
        informationNotToShare,
        excludedPhones,
        customPolicies,
        library,
        requirePaymentProof,
        postBookingProcedures
      ]);
}

GregDataStruct createGregDataStruct({
  int? businessId,
  bool? active,
  String? conversationTone,
  bool? notifications,
  int? gregId,
  String? cancellations,
  bool? cancellationMotive,
  int? escalationTimeMinutes,
  bool? allowRescheduling,
  String? refundPolicy,
  String? refundPolicyDetails,
  String? paymentPolicy,
  String? proceduresDetails,
  String? saveInformation,
  bool? askForConsent,
  String? privacyPolicy,
  String? informationNotToShare,
  bool? requirePaymentProof,
  String? postBookingProcedures,
}) =>
    GregDataStruct(
      businessId: businessId,
      active: active,
      conversationTone: conversationTone,
      notifications: notifications,
      gregId: gregId,
      cancellations: cancellations,
      cancellationMotive: cancellationMotive,
      escalationTimeMinutes: escalationTimeMinutes,
      allowRescheduling: allowRescheduling,
      refundPolicy: refundPolicy,
      refundPolicyDetails: refundPolicyDetails,
      paymentPolicy: paymentPolicy,
      proceduresDetails: proceduresDetails,
      saveInformation: saveInformation,
      askForConsent: askForConsent,
      privacyPolicy: privacyPolicy,
      informationNotToShare: informationNotToShare,
      requirePaymentProof: requirePaymentProof,
      postBookingProcedures: postBookingProcedures,
    );
