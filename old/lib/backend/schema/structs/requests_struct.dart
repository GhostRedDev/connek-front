// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RequestsStruct extends BaseStruct {
  RequestsStruct({
    int? id,
    String? createdAt,
    int? clientId,
    String? description,
    bool? isDirect,
    int? budgetMax,
    int? budgetMin,
    bool? clientContacted,
    bool? proposalSent,
    bool? proposalAccepted,
    String? status,
    bool? paymentMade,
    bool? bookingMade,
    ClientStruct? client,
  })  : _id = id,
        _createdAt = createdAt,
        _clientId = clientId,
        _description = description,
        _isDirect = isDirect,
        _budgetMax = budgetMax,
        _budgetMin = budgetMin,
        _clientContacted = clientContacted,
        _proposalSent = proposalSent,
        _proposalAccepted = proposalAccepted,
        _status = status,
        _paymentMade = paymentMade,
        _bookingMade = bookingMade,
        _client = client;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "client_id" field.
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

  // "is_direct" field.
  bool? _isDirect;
  bool get isDirect => _isDirect ?? false;
  set isDirect(bool? val) => _isDirect = val;

  bool hasIsDirect() => _isDirect != null;

  // "budget_max" field.
  int? _budgetMax;
  int get budgetMax => _budgetMax ?? 0;
  set budgetMax(int? val) => _budgetMax = val;

  void incrementBudgetMax(int amount) => budgetMax = budgetMax + amount;

  bool hasBudgetMax() => _budgetMax != null;

  // "budget_min" field.
  int? _budgetMin;
  int get budgetMin => _budgetMin ?? 0;
  set budgetMin(int? val) => _budgetMin = val;

  void incrementBudgetMin(int amount) => budgetMin = budgetMin + amount;

  bool hasBudgetMin() => _budgetMin != null;

  // "client_contacted" field.
  bool? _clientContacted;
  bool get clientContacted => _clientContacted ?? false;
  set clientContacted(bool? val) => _clientContacted = val;

  bool hasClientContacted() => _clientContacted != null;

  // "proposal_sent" field.
  bool? _proposalSent;
  bool get proposalSent => _proposalSent ?? false;
  set proposalSent(bool? val) => _proposalSent = val;

  bool hasProposalSent() => _proposalSent != null;

  // "proposal_accepted" field.
  bool? _proposalAccepted;
  bool get proposalAccepted => _proposalAccepted ?? false;
  set proposalAccepted(bool? val) => _proposalAccepted = val;

  bool hasProposalAccepted() => _proposalAccepted != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "payment_made" field.
  bool? _paymentMade;
  bool get paymentMade => _paymentMade ?? false;
  set paymentMade(bool? val) => _paymentMade = val;

  bool hasPaymentMade() => _paymentMade != null;

  // "booking_made" field.
  bool? _bookingMade;
  bool get bookingMade => _bookingMade ?? false;
  set bookingMade(bool? val) => _bookingMade = val;

  bool hasBookingMade() => _bookingMade != null;

  // "client" field.
  ClientStruct? _client;
  ClientStruct get client => _client ?? ClientStruct();
  set client(ClientStruct? val) => _client = val;

  void updateClient(Function(ClientStruct) updateFn) {
    updateFn(_client ??= ClientStruct());
  }

  bool hasClient() => _client != null;

  static RequestsStruct fromMap(Map<String, dynamic> data) => RequestsStruct(
        id: castToType<int>(data['id']),
        createdAt: data['created_at'] as String?,
        clientId: castToType<int>(data['client_id']),
        description: data['description'] as String?,
        isDirect: data['is_direct'] as bool?,
        budgetMax: castToType<int>(data['budget_max']),
        budgetMin: castToType<int>(data['budget_min']),
        clientContacted: data['client_contacted'] as bool?,
        proposalSent: data['proposal_sent'] as bool?,
        proposalAccepted: data['proposal_accepted'] as bool?,
        status: data['status'] as String?,
        paymentMade: data['payment_made'] as bool?,
        bookingMade: data['booking_made'] as bool?,
        client: data['client'] is ClientStruct
            ? data['client']
            : ClientStruct.maybeFromMap(data['client']),
      );

  static RequestsStruct? maybeFromMap(dynamic data) =>
      data is Map ? RequestsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'created_at': _createdAt,
        'client_id': _clientId,
        'description': _description,
        'is_direct': _isDirect,
        'budget_max': _budgetMax,
        'budget_min': _budgetMin,
        'client_contacted': _clientContacted,
        'proposal_sent': _proposalSent,
        'proposal_accepted': _proposalAccepted,
        'status': _status,
        'payment_made': _paymentMade,
        'booking_made': _bookingMade,
        'client': _client?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'client_id': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'is_direct': serializeParam(
          _isDirect,
          ParamType.bool,
        ),
        'budget_max': serializeParam(
          _budgetMax,
          ParamType.int,
        ),
        'budget_min': serializeParam(
          _budgetMin,
          ParamType.int,
        ),
        'client_contacted': serializeParam(
          _clientContacted,
          ParamType.bool,
        ),
        'proposal_sent': serializeParam(
          _proposalSent,
          ParamType.bool,
        ),
        'proposal_accepted': serializeParam(
          _proposalAccepted,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'payment_made': serializeParam(
          _paymentMade,
          ParamType.bool,
        ),
        'booking_made': serializeParam(
          _bookingMade,
          ParamType.bool,
        ),
        'client': serializeParam(
          _client,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static RequestsStruct fromSerializableMap(Map<String, dynamic> data) =>
      RequestsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        clientId: deserializeParam(
          data['client_id'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        isDirect: deserializeParam(
          data['is_direct'],
          ParamType.bool,
          false,
        ),
        budgetMax: deserializeParam(
          data['budget_max'],
          ParamType.int,
          false,
        ),
        budgetMin: deserializeParam(
          data['budget_min'],
          ParamType.int,
          false,
        ),
        clientContacted: deserializeParam(
          data['client_contacted'],
          ParamType.bool,
          false,
        ),
        proposalSent: deserializeParam(
          data['proposal_sent'],
          ParamType.bool,
          false,
        ),
        proposalAccepted: deserializeParam(
          data['proposal_accepted'],
          ParamType.bool,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        paymentMade: deserializeParam(
          data['payment_made'],
          ParamType.bool,
          false,
        ),
        bookingMade: deserializeParam(
          data['booking_made'],
          ParamType.bool,
          false,
        ),
        client: deserializeStructParam(
          data['client'],
          ParamType.DataStruct,
          false,
          structBuilder: ClientStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RequestsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RequestsStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        clientId == other.clientId &&
        description == other.description &&
        isDirect == other.isDirect &&
        budgetMax == other.budgetMax &&
        budgetMin == other.budgetMin &&
        clientContacted == other.clientContacted &&
        proposalSent == other.proposalSent &&
        proposalAccepted == other.proposalAccepted &&
        status == other.status &&
        paymentMade == other.paymentMade &&
        bookingMade == other.bookingMade &&
        client == other.client;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        clientId,
        description,
        isDirect,
        budgetMax,
        budgetMin,
        clientContacted,
        proposalSent,
        proposalAccepted,
        status,
        paymentMade,
        bookingMade,
        client
      ]);
}

RequestsStruct createRequestsStruct({
  int? id,
  String? createdAt,
  int? clientId,
  String? description,
  bool? isDirect,
  int? budgetMax,
  int? budgetMin,
  bool? clientContacted,
  bool? proposalSent,
  bool? proposalAccepted,
  String? status,
  bool? paymentMade,
  bool? bookingMade,
  ClientStruct? client,
}) =>
    RequestsStruct(
      id: id,
      createdAt: createdAt,
      clientId: clientId,
      description: description,
      isDirect: isDirect,
      budgetMax: budgetMax,
      budgetMin: budgetMin,
      clientContacted: clientContacted,
      proposalSent: proposalSent,
      proposalAccepted: proposalAccepted,
      status: status,
      paymentMade: paymentMade,
      bookingMade: bookingMade,
      client: client ?? ClientStruct(),
    );
