// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessBookingsFullDataStruct extends BaseStruct {
  BusinessBookingsFullDataStruct({
    int? id,
    DateTime? createdAt,
    int? clientId,
    int? businessId,
    int? addressId,
    String? status,
    int? requestId,
    DateTime? startTimeUtc,
    DateTime? endTimeUtc,
    ClientRequestStruct? requests,
    ClientDataProfileStruct? client,
    QuoteDataStruct? quote,
    int? oboBusinessId,
  })  : _id = id,
        _createdAt = createdAt,
        _clientId = clientId,
        _businessId = businessId,
        _addressId = addressId,
        _status = status,
        _requestId = requestId,
        _startTimeUtc = startTimeUtc,
        _endTimeUtc = endTimeUtc,
        _requests = requests,
        _client = client,
        _quote = quote,
        _oboBusinessId = oboBusinessId;

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

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "addressId" field.
  int? _addressId;
  int get addressId => _addressId ?? 0;
  set addressId(int? val) => _addressId = val;

  void incrementAddressId(int amount) => addressId = addressId + amount;

  bool hasAddressId() => _addressId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "requestId" field.
  int? _requestId;
  int get requestId => _requestId ?? 0;
  set requestId(int? val) => _requestId = val;

  void incrementRequestId(int amount) => requestId = requestId + amount;

  bool hasRequestId() => _requestId != null;

  // "startTimeUtc" field.
  DateTime? _startTimeUtc;
  DateTime? get startTimeUtc => _startTimeUtc;
  set startTimeUtc(DateTime? val) => _startTimeUtc = val;

  bool hasStartTimeUtc() => _startTimeUtc != null;

  // "endTimeUtc" field.
  DateTime? _endTimeUtc;
  DateTime? get endTimeUtc => _endTimeUtc;
  set endTimeUtc(DateTime? val) => _endTimeUtc = val;

  bool hasEndTimeUtc() => _endTimeUtc != null;

  // "requests" field.
  ClientRequestStruct? _requests;
  ClientRequestStruct get requests => _requests ?? ClientRequestStruct();
  set requests(ClientRequestStruct? val) => _requests = val;

  void updateRequests(Function(ClientRequestStruct) updateFn) {
    updateFn(_requests ??= ClientRequestStruct());
  }

  bool hasRequests() => _requests != null;

  // "client" field.
  ClientDataProfileStruct? _client;
  ClientDataProfileStruct get client => _client ?? ClientDataProfileStruct();
  set client(ClientDataProfileStruct? val) => _client = val;

  void updateClient(Function(ClientDataProfileStruct) updateFn) {
    updateFn(_client ??= ClientDataProfileStruct());
  }

  bool hasClient() => _client != null;

  // "quote" field.
  QuoteDataStruct? _quote;
  QuoteDataStruct get quote => _quote ?? QuoteDataStruct();
  set quote(QuoteDataStruct? val) => _quote = val;

  void updateQuote(Function(QuoteDataStruct) updateFn) {
    updateFn(_quote ??= QuoteDataStruct());
  }

  bool hasQuote() => _quote != null;

  // "oboBusinessId" field.
  int? _oboBusinessId;
  int get oboBusinessId => _oboBusinessId ?? 0;
  set oboBusinessId(int? val) => _oboBusinessId = val;

  void incrementOboBusinessId(int amount) =>
      oboBusinessId = oboBusinessId + amount;

  bool hasOboBusinessId() => _oboBusinessId != null;

  static BusinessBookingsFullDataStruct fromMap(Map<String, dynamic> data) =>
      BusinessBookingsFullDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        clientId: castToType<int>(data['clientId']),
        businessId: castToType<int>(data['businessId']),
        addressId: castToType<int>(data['addressId']),
        status: data['status'] as String?,
        requestId: castToType<int>(data['requestId']),
        startTimeUtc: data['startTimeUtc'] as DateTime?,
        endTimeUtc: data['endTimeUtc'] as DateTime?,
        requests: data['requests'] is ClientRequestStruct
            ? data['requests']
            : ClientRequestStruct.maybeFromMap(data['requests']),
        client: data['client'] is ClientDataProfileStruct
            ? data['client']
            : ClientDataProfileStruct.maybeFromMap(data['client']),
        quote: data['quote'] is QuoteDataStruct
            ? data['quote']
            : QuoteDataStruct.maybeFromMap(data['quote']),
        oboBusinessId: castToType<int>(data['oboBusinessId']),
      );

  static BusinessBookingsFullDataStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? BusinessBookingsFullDataStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'clientId': _clientId,
        'businessId': _businessId,
        'addressId': _addressId,
        'status': _status,
        'requestId': _requestId,
        'startTimeUtc': _startTimeUtc,
        'endTimeUtc': _endTimeUtc,
        'requests': _requests?.toMap(),
        'client': _client?.toMap(),
        'quote': _quote?.toMap(),
        'oboBusinessId': _oboBusinessId,
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
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'addressId': serializeParam(
          _addressId,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'requestId': serializeParam(
          _requestId,
          ParamType.int,
        ),
        'startTimeUtc': serializeParam(
          _startTimeUtc,
          ParamType.DateTime,
        ),
        'endTimeUtc': serializeParam(
          _endTimeUtc,
          ParamType.DateTime,
        ),
        'requests': serializeParam(
          _requests,
          ParamType.DataStruct,
        ),
        'client': serializeParam(
          _client,
          ParamType.DataStruct,
        ),
        'quote': serializeParam(
          _quote,
          ParamType.DataStruct,
        ),
        'oboBusinessId': serializeParam(
          _oboBusinessId,
          ParamType.int,
        ),
      }.withoutNulls;

  static BusinessBookingsFullDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessBookingsFullDataStruct(
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
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        addressId: deserializeParam(
          data['addressId'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        requestId: deserializeParam(
          data['requestId'],
          ParamType.int,
          false,
        ),
        startTimeUtc: deserializeParam(
          data['startTimeUtc'],
          ParamType.DateTime,
          false,
        ),
        endTimeUtc: deserializeParam(
          data['endTimeUtc'],
          ParamType.DateTime,
          false,
        ),
        requests: deserializeStructParam(
          data['requests'],
          ParamType.DataStruct,
          false,
          structBuilder: ClientRequestStruct.fromSerializableMap,
        ),
        client: deserializeStructParam(
          data['client'],
          ParamType.DataStruct,
          false,
          structBuilder: ClientDataProfileStruct.fromSerializableMap,
        ),
        quote: deserializeStructParam(
          data['quote'],
          ParamType.DataStruct,
          false,
          structBuilder: QuoteDataStruct.fromSerializableMap,
        ),
        oboBusinessId: deserializeParam(
          data['oboBusinessId'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'BusinessBookingsFullDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessBookingsFullDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        clientId == other.clientId &&
        businessId == other.businessId &&
        addressId == other.addressId &&
        status == other.status &&
        requestId == other.requestId &&
        startTimeUtc == other.startTimeUtc &&
        endTimeUtc == other.endTimeUtc &&
        requests == other.requests &&
        client == other.client &&
        quote == other.quote &&
        oboBusinessId == other.oboBusinessId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        clientId,
        businessId,
        addressId,
        status,
        requestId,
        startTimeUtc,
        endTimeUtc,
        requests,
        client,
        quote,
        oboBusinessId
      ]);
}

BusinessBookingsFullDataStruct createBusinessBookingsFullDataStruct({
  int? id,
  DateTime? createdAt,
  int? clientId,
  int? businessId,
  int? addressId,
  String? status,
  int? requestId,
  DateTime? startTimeUtc,
  DateTime? endTimeUtc,
  ClientRequestStruct? requests,
  ClientDataProfileStruct? client,
  QuoteDataStruct? quote,
  int? oboBusinessId,
}) =>
    BusinessBookingsFullDataStruct(
      id: id,
      createdAt: createdAt,
      clientId: clientId,
      businessId: businessId,
      addressId: addressId,
      status: status,
      requestId: requestId,
      startTimeUtc: startTimeUtc,
      endTimeUtc: endTimeUtc,
      requests: requests ?? ClientRequestStruct(),
      client: client ?? ClientDataProfileStruct(),
      quote: quote ?? QuoteDataStruct(),
      oboBusinessId: oboBusinessId,
    );
