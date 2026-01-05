// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RequestWithServiceDataStruct extends BaseStruct {
  RequestWithServiceDataStruct({
    int? id,
    DateTime? createdAt,
    int? clientId,
    String? description,
    bool? isDirect,
    int? budgetMaxCents,
    int? budgetMinCents,
    bool? clientContacted,
    bool? proposalSent,
    bool? proposalAccepted,
    String? status,
    bool? paymentMade,
    bool? bookingMade,
    int? serviceId,
    int? oboBusinessId,
    ServiceDataStruct? services,
  })  : _id = id,
        _createdAt = createdAt,
        _clientId = clientId,
        _description = description,
        _isDirect = isDirect,
        _budgetMaxCents = budgetMaxCents,
        _budgetMinCents = budgetMinCents,
        _clientContacted = clientContacted,
        _proposalSent = proposalSent,
        _proposalAccepted = proposalAccepted,
        _status = status,
        _paymentMade = paymentMade,
        _bookingMade = bookingMade,
        _serviceId = serviceId,
        _oboBusinessId = oboBusinessId,
        _services = services;

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

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "isDirect" field.
  bool? _isDirect;
  bool get isDirect => _isDirect ?? false;
  set isDirect(bool? val) => _isDirect = val;

  bool hasIsDirect() => _isDirect != null;

  // "budgetMaxCents" field.
  int? _budgetMaxCents;
  int get budgetMaxCents => _budgetMaxCents ?? 0;
  set budgetMaxCents(int? val) => _budgetMaxCents = val;

  void incrementBudgetMaxCents(int amount) =>
      budgetMaxCents = budgetMaxCents + amount;

  bool hasBudgetMaxCents() => _budgetMaxCents != null;

  // "budgetMinCents" field.
  int? _budgetMinCents;
  int get budgetMinCents => _budgetMinCents ?? 0;
  set budgetMinCents(int? val) => _budgetMinCents = val;

  void incrementBudgetMinCents(int amount) =>
      budgetMinCents = budgetMinCents + amount;

  bool hasBudgetMinCents() => _budgetMinCents != null;

  // "clientContacted" field.
  bool? _clientContacted;
  bool get clientContacted => _clientContacted ?? false;
  set clientContacted(bool? val) => _clientContacted = val;

  bool hasClientContacted() => _clientContacted != null;

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

  // "paymentMade" field.
  bool? _paymentMade;
  bool get paymentMade => _paymentMade ?? false;
  set paymentMade(bool? val) => _paymentMade = val;

  bool hasPaymentMade() => _paymentMade != null;

  // "bookingMade" field.
  bool? _bookingMade;
  bool get bookingMade => _bookingMade ?? false;
  set bookingMade(bool? val) => _bookingMade = val;

  bool hasBookingMade() => _bookingMade != null;

  // "serviceId" field.
  int? _serviceId;
  int get serviceId => _serviceId ?? 0;
  set serviceId(int? val) => _serviceId = val;

  void incrementServiceId(int amount) => serviceId = serviceId + amount;

  bool hasServiceId() => _serviceId != null;

  // "oboBusinessId" field.
  int? _oboBusinessId;
  int get oboBusinessId => _oboBusinessId ?? 0;
  set oboBusinessId(int? val) => _oboBusinessId = val;

  void incrementOboBusinessId(int amount) =>
      oboBusinessId = oboBusinessId + amount;

  bool hasOboBusinessId() => _oboBusinessId != null;

  // "services" field.
  ServiceDataStruct? _services;
  ServiceDataStruct get services => _services ?? ServiceDataStruct();
  set services(ServiceDataStruct? val) => _services = val;

  void updateServices(Function(ServiceDataStruct) updateFn) {
    updateFn(_services ??= ServiceDataStruct());
  }

  bool hasServices() => _services != null;

  static RequestWithServiceDataStruct fromMap(Map<String, dynamic> data) =>
      RequestWithServiceDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        clientId: castToType<int>(data['clientId']),
        description: data['description'] as String?,
        isDirect: data['isDirect'] as bool?,
        budgetMaxCents: castToType<int>(data['budgetMaxCents']),
        budgetMinCents: castToType<int>(data['budgetMinCents']),
        clientContacted: data['clientContacted'] as bool?,
        proposalSent: data['proposalSent'] as bool?,
        proposalAccepted: data['proposalAccepted'] as bool?,
        status: data['status'] as String?,
        paymentMade: data['paymentMade'] as bool?,
        bookingMade: data['bookingMade'] as bool?,
        serviceId: castToType<int>(data['serviceId']),
        oboBusinessId: castToType<int>(data['oboBusinessId']),
        services: data['services'] is ServiceDataStruct
            ? data['services']
            : ServiceDataStruct.maybeFromMap(data['services']),
      );

  static RequestWithServiceDataStruct? maybeFromMap(dynamic data) => data is Map
      ? RequestWithServiceDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'clientId': _clientId,
        'description': _description,
        'isDirect': _isDirect,
        'budgetMaxCents': _budgetMaxCents,
        'budgetMinCents': _budgetMinCents,
        'clientContacted': _clientContacted,
        'proposalSent': _proposalSent,
        'proposalAccepted': _proposalAccepted,
        'status': _status,
        'paymentMade': _paymentMade,
        'bookingMade': _bookingMade,
        'serviceId': _serviceId,
        'oboBusinessId': _oboBusinessId,
        'services': _services?.toMap(),
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
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'isDirect': serializeParam(
          _isDirect,
          ParamType.bool,
        ),
        'budgetMaxCents': serializeParam(
          _budgetMaxCents,
          ParamType.int,
        ),
        'budgetMinCents': serializeParam(
          _budgetMinCents,
          ParamType.int,
        ),
        'clientContacted': serializeParam(
          _clientContacted,
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
        'paymentMade': serializeParam(
          _paymentMade,
          ParamType.bool,
        ),
        'bookingMade': serializeParam(
          _bookingMade,
          ParamType.bool,
        ),
        'serviceId': serializeParam(
          _serviceId,
          ParamType.int,
        ),
        'oboBusinessId': serializeParam(
          _oboBusinessId,
          ParamType.int,
        ),
        'services': serializeParam(
          _services,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static RequestWithServiceDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RequestWithServiceDataStruct(
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
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        isDirect: deserializeParam(
          data['isDirect'],
          ParamType.bool,
          false,
        ),
        budgetMaxCents: deserializeParam(
          data['budgetMaxCents'],
          ParamType.int,
          false,
        ),
        budgetMinCents: deserializeParam(
          data['budgetMinCents'],
          ParamType.int,
          false,
        ),
        clientContacted: deserializeParam(
          data['clientContacted'],
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
        paymentMade: deserializeParam(
          data['paymentMade'],
          ParamType.bool,
          false,
        ),
        bookingMade: deserializeParam(
          data['bookingMade'],
          ParamType.bool,
          false,
        ),
        serviceId: deserializeParam(
          data['serviceId'],
          ParamType.int,
          false,
        ),
        oboBusinessId: deserializeParam(
          data['oboBusinessId'],
          ParamType.int,
          false,
        ),
        services: deserializeStructParam(
          data['services'],
          ParamType.DataStruct,
          false,
          structBuilder: ServiceDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RequestWithServiceDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RequestWithServiceDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        clientId == other.clientId &&
        description == other.description &&
        isDirect == other.isDirect &&
        budgetMaxCents == other.budgetMaxCents &&
        budgetMinCents == other.budgetMinCents &&
        clientContacted == other.clientContacted &&
        proposalSent == other.proposalSent &&
        proposalAccepted == other.proposalAccepted &&
        status == other.status &&
        paymentMade == other.paymentMade &&
        bookingMade == other.bookingMade &&
        serviceId == other.serviceId &&
        oboBusinessId == other.oboBusinessId &&
        services == other.services;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        clientId,
        description,
        isDirect,
        budgetMaxCents,
        budgetMinCents,
        clientContacted,
        proposalSent,
        proposalAccepted,
        status,
        paymentMade,
        bookingMade,
        serviceId,
        oboBusinessId,
        services
      ]);
}

RequestWithServiceDataStruct createRequestWithServiceDataStruct({
  int? id,
  DateTime? createdAt,
  int? clientId,
  String? description,
  bool? isDirect,
  int? budgetMaxCents,
  int? budgetMinCents,
  bool? clientContacted,
  bool? proposalSent,
  bool? proposalAccepted,
  String? status,
  bool? paymentMade,
  bool? bookingMade,
  int? serviceId,
  int? oboBusinessId,
  ServiceDataStruct? services,
}) =>
    RequestWithServiceDataStruct(
      id: id,
      createdAt: createdAt,
      clientId: clientId,
      description: description,
      isDirect: isDirect,
      budgetMaxCents: budgetMaxCents,
      budgetMinCents: budgetMinCents,
      clientContacted: clientContacted,
      proposalSent: proposalSent,
      proposalAccepted: proposalAccepted,
      status: status,
      paymentMade: paymentMade,
      bookingMade: bookingMade,
      serviceId: serviceId,
      oboBusinessId: oboBusinessId,
      services: services ?? ServiceDataStruct(),
    );
