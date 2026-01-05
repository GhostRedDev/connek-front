// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessLeadsStruct extends BaseStruct {
  BusinessLeadsStruct({
    int? id,
    DateTime? createdAt,
    int? requestId,
    bool? seen,
    bool? clientContacted,
    bool? bookingMade,
    bool? paymentMade,
    bool? proposalSent,
    bool? proposalAccepted,
    String? status,
    int? clientId,
    int? serviceId,
    String? clientFirstName,
    String? clientLastName,
    String? requestDescription,
    bool? requestIsDirect,
    int? requestBudgetMax,
    int? requestBudgetMin,
    String? clientImageUrl,
  })  : _id = id,
        _createdAt = createdAt,
        _requestId = requestId,
        _seen = seen,
        _clientContacted = clientContacted,
        _bookingMade = bookingMade,
        _paymentMade = paymentMade,
        _proposalSent = proposalSent,
        _proposalAccepted = proposalAccepted,
        _status = status,
        _clientId = clientId,
        _serviceId = serviceId,
        _clientFirstName = clientFirstName,
        _clientLastName = clientLastName,
        _requestDescription = requestDescription,
        _requestIsDirect = requestIsDirect,
        _requestBudgetMax = requestBudgetMax,
        _requestBudgetMin = requestBudgetMin,
        _clientImageUrl = clientImageUrl;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "requestId" field.
  int? _requestId;
  int get requestId => _requestId ?? 0;
  set requestId(int? val) => _requestId = val;

  void incrementRequestId(int amount) => requestId = requestId + amount;

  bool hasRequestId() => _requestId != null;

  // "seen" field.
  bool? _seen;
  bool get seen => _seen ?? false;
  set seen(bool? val) => _seen = val;

  bool hasSeen() => _seen != null;

  // "clientContacted" field.
  bool? _clientContacted;
  bool get clientContacted => _clientContacted ?? false;
  set clientContacted(bool? val) => _clientContacted = val;

  bool hasClientContacted() => _clientContacted != null;

  // "bookingMade" field.
  bool? _bookingMade;
  bool get bookingMade => _bookingMade ?? false;
  set bookingMade(bool? val) => _bookingMade = val;

  bool hasBookingMade() => _bookingMade != null;

  // "paymentMade" field.
  bool? _paymentMade;
  bool get paymentMade => _paymentMade ?? false;
  set paymentMade(bool? val) => _paymentMade = val;

  bool hasPaymentMade() => _paymentMade != null;

  // "proposalSent" field.
  bool? _proposalSent;
  bool get proposalSent => _proposalSent ?? false;
  set proposalSent(bool? val) => _proposalSent = val;

  bool hasProposalSent() => _proposalSent != null;

  // "proposalAccepted" field.
  bool? _proposalAccepted;
  bool get proposalAccepted => _proposalAccepted ?? false;
  set proposalAccepted(bool? val) => _proposalAccepted = val;

  bool hasProposalAccepted() => _proposalAccepted != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "serviceId" field.
  int? _serviceId;
  int get serviceId => _serviceId ?? 0;
  set serviceId(int? val) => _serviceId = val;

  void incrementServiceId(int amount) => serviceId = serviceId + amount;

  bool hasServiceId() => _serviceId != null;

  // "clientFirstName" field.
  String? _clientFirstName;
  String get clientFirstName => _clientFirstName ?? '';
  set clientFirstName(String? val) => _clientFirstName = val;

  bool hasClientFirstName() => _clientFirstName != null;

  // "clientLastName" field.
  String? _clientLastName;
  String get clientLastName => _clientLastName ?? '';
  set clientLastName(String? val) => _clientLastName = val;

  bool hasClientLastName() => _clientLastName != null;

  // "requestDescription" field.
  String? _requestDescription;
  String get requestDescription => _requestDescription ?? '';
  set requestDescription(String? val) => _requestDescription = val;

  bool hasRequestDescription() => _requestDescription != null;

  // "requestIsDirect" field.
  bool? _requestIsDirect;
  bool get requestIsDirect => _requestIsDirect ?? false;
  set requestIsDirect(bool? val) => _requestIsDirect = val;

  bool hasRequestIsDirect() => _requestIsDirect != null;

  // "requestBudgetMax" field.
  int? _requestBudgetMax;
  int get requestBudgetMax => _requestBudgetMax ?? 0;
  set requestBudgetMax(int? val) => _requestBudgetMax = val;

  void incrementRequestBudgetMax(int amount) =>
      requestBudgetMax = requestBudgetMax + amount;

  bool hasRequestBudgetMax() => _requestBudgetMax != null;

  // "requestBudgetMin" field.
  int? _requestBudgetMin;
  int get requestBudgetMin => _requestBudgetMin ?? 0;
  set requestBudgetMin(int? val) => _requestBudgetMin = val;

  void incrementRequestBudgetMin(int amount) =>
      requestBudgetMin = requestBudgetMin + amount;

  bool hasRequestBudgetMin() => _requestBudgetMin != null;

  // "clientImageUrl" field.
  String? _clientImageUrl;
  String get clientImageUrl => _clientImageUrl ?? '';
  set clientImageUrl(String? val) => _clientImageUrl = val;

  bool hasClientImageUrl() => _clientImageUrl != null;

  static BusinessLeadsStruct fromMap(Map<String, dynamic> data) =>
      BusinessLeadsStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        requestId: castToType<int>(data['requestId']),
        seen: data['seen'] as bool?,
        clientContacted: data['clientContacted'] as bool?,
        bookingMade: data['bookingMade'] as bool?,
        paymentMade: data['paymentMade'] as bool?,
        proposalSent: data['proposalSent'] as bool?,
        proposalAccepted: data['proposalAccepted'] as bool?,
        status: data['status'] as String?,
        clientId: castToType<int>(data['clientId']),
        serviceId: castToType<int>(data['serviceId']),
        clientFirstName: data['clientFirstName'] as String?,
        clientLastName: data['clientLastName'] as String?,
        requestDescription: data['requestDescription'] as String?,
        requestIsDirect: data['requestIsDirect'] as bool?,
        requestBudgetMax: castToType<int>(data['requestBudgetMax']),
        requestBudgetMin: castToType<int>(data['requestBudgetMin']),
        clientImageUrl: data['clientImageUrl'] as String?,
      );

  static BusinessLeadsStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessLeadsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'requestId': _requestId,
        'seen': _seen,
        'clientContacted': _clientContacted,
        'bookingMade': _bookingMade,
        'paymentMade': _paymentMade,
        'proposalSent': _proposalSent,
        'proposalAccepted': _proposalAccepted,
        'status': _status,
        'clientId': _clientId,
        'serviceId': _serviceId,
        'clientFirstName': _clientFirstName,
        'clientLastName': _clientLastName,
        'requestDescription': _requestDescription,
        'requestIsDirect': _requestIsDirect,
        'requestBudgetMax': _requestBudgetMax,
        'requestBudgetMin': _requestBudgetMin,
        'clientImageUrl': _clientImageUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'requestId': serializeParam(
          _requestId,
          ParamType.int,
        ),
        'seen': serializeParam(
          _seen,
          ParamType.bool,
        ),
        'clientContacted': serializeParam(
          _clientContacted,
          ParamType.bool,
        ),
        'bookingMade': serializeParam(
          _bookingMade,
          ParamType.bool,
        ),
        'paymentMade': serializeParam(
          _paymentMade,
          ParamType.bool,
        ),
        'proposalSent': serializeParam(
          _proposalSent,
          ParamType.bool,
        ),
        'proposalAccepted': serializeParam(
          _proposalAccepted,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'serviceId': serializeParam(
          _serviceId,
          ParamType.int,
        ),
        'clientFirstName': serializeParam(
          _clientFirstName,
          ParamType.String,
        ),
        'clientLastName': serializeParam(
          _clientLastName,
          ParamType.String,
        ),
        'requestDescription': serializeParam(
          _requestDescription,
          ParamType.String,
        ),
        'requestIsDirect': serializeParam(
          _requestIsDirect,
          ParamType.bool,
        ),
        'requestBudgetMax': serializeParam(
          _requestBudgetMax,
          ParamType.int,
        ),
        'requestBudgetMin': serializeParam(
          _requestBudgetMin,
          ParamType.int,
        ),
        'clientImageUrl': serializeParam(
          _clientImageUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static BusinessLeadsStruct fromSerializableMap(Map<String, dynamic> data) =>
      BusinessLeadsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        requestId: deserializeParam(
          data['requestId'],
          ParamType.int,
          false,
        ),
        seen: deserializeParam(
          data['seen'],
          ParamType.bool,
          false,
        ),
        clientContacted: deserializeParam(
          data['clientContacted'],
          ParamType.bool,
          false,
        ),
        bookingMade: deserializeParam(
          data['bookingMade'],
          ParamType.bool,
          false,
        ),
        paymentMade: deserializeParam(
          data['paymentMade'],
          ParamType.bool,
          false,
        ),
        proposalSent: deserializeParam(
          data['proposalSent'],
          ParamType.bool,
          false,
        ),
        proposalAccepted: deserializeParam(
          data['proposalAccepted'],
          ParamType.bool,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        serviceId: deserializeParam(
          data['serviceId'],
          ParamType.int,
          false,
        ),
        clientFirstName: deserializeParam(
          data['clientFirstName'],
          ParamType.String,
          false,
        ),
        clientLastName: deserializeParam(
          data['clientLastName'],
          ParamType.String,
          false,
        ),
        requestDescription: deserializeParam(
          data['requestDescription'],
          ParamType.String,
          false,
        ),
        requestIsDirect: deserializeParam(
          data['requestIsDirect'],
          ParamType.bool,
          false,
        ),
        requestBudgetMax: deserializeParam(
          data['requestBudgetMax'],
          ParamType.int,
          false,
        ),
        requestBudgetMin: deserializeParam(
          data['requestBudgetMin'],
          ParamType.int,
          false,
        ),
        clientImageUrl: deserializeParam(
          data['clientImageUrl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BusinessLeadsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessLeadsStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        requestId == other.requestId &&
        seen == other.seen &&
        clientContacted == other.clientContacted &&
        bookingMade == other.bookingMade &&
        paymentMade == other.paymentMade &&
        proposalSent == other.proposalSent &&
        proposalAccepted == other.proposalAccepted &&
        status == other.status &&
        clientId == other.clientId &&
        serviceId == other.serviceId &&
        clientFirstName == other.clientFirstName &&
        clientLastName == other.clientLastName &&
        requestDescription == other.requestDescription &&
        requestIsDirect == other.requestIsDirect &&
        requestBudgetMax == other.requestBudgetMax &&
        requestBudgetMin == other.requestBudgetMin &&
        clientImageUrl == other.clientImageUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        requestId,
        seen,
        clientContacted,
        bookingMade,
        paymentMade,
        proposalSent,
        proposalAccepted,
        status,
        clientId,
        serviceId,
        clientFirstName,
        clientLastName,
        requestDescription,
        requestIsDirect,
        requestBudgetMax,
        requestBudgetMin,
        clientImageUrl
      ]);
}

BusinessLeadsStruct createBusinessLeadsStruct({
  int? id,
  DateTime? createdAt,
  int? requestId,
  bool? seen,
  bool? clientContacted,
  bool? bookingMade,
  bool? paymentMade,
  bool? proposalSent,
  bool? proposalAccepted,
  String? status,
  int? clientId,
  int? serviceId,
  String? clientFirstName,
  String? clientLastName,
  String? requestDescription,
  bool? requestIsDirect,
  int? requestBudgetMax,
  int? requestBudgetMin,
  String? clientImageUrl,
}) =>
    BusinessLeadsStruct(
      id: id,
      createdAt: createdAt,
      requestId: requestId,
      seen: seen,
      clientContacted: clientContacted,
      bookingMade: bookingMade,
      paymentMade: paymentMade,
      proposalSent: proposalSent,
      proposalAccepted: proposalAccepted,
      status: status,
      clientId: clientId,
      serviceId: serviceId,
      clientFirstName: clientFirstName,
      clientLastName: clientLastName,
      requestDescription: requestDescription,
      requestIsDirect: requestIsDirect,
      requestBudgetMax: requestBudgetMax,
      requestBudgetMin: requestBudgetMin,
      clientImageUrl: clientImageUrl,
    );
