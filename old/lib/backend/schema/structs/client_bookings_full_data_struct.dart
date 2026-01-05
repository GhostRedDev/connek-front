// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientBookingsFullDataStruct extends BaseStruct {
  ClientBookingsFullDataStruct({
    int? id,
    DateTime? createdAt,
    int? clientId,
    int? businessId,
    int? addressId,
    String? status,
    int? requestId,
    DateTime? startTimeUtc,
    DateTime? endTimeUtc,
    QuoteDataStruct? quote,
    BusinessDataStruct? business,
    RequestWithServiceDataStruct? requests,
    AddressDataStruct? address,
    int? oboBusinessId,
    int? resourceId,
    ResourceDataStruct? resources,
  })  : _id = id,
        _createdAt = createdAt,
        _clientId = clientId,
        _businessId = businessId,
        _addressId = addressId,
        _status = status,
        _requestId = requestId,
        _startTimeUtc = startTimeUtc,
        _endTimeUtc = endTimeUtc,
        _quote = quote,
        _business = business,
        _requests = requests,
        _address = address,
        _oboBusinessId = oboBusinessId,
        _resourceId = resourceId,
        _resources = resources;

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

  // "quote" field.
  QuoteDataStruct? _quote;
  QuoteDataStruct get quote => _quote ?? QuoteDataStruct();
  set quote(QuoteDataStruct? val) => _quote = val;

  void updateQuote(Function(QuoteDataStruct) updateFn) {
    updateFn(_quote ??= QuoteDataStruct());
  }

  bool hasQuote() => _quote != null;

  // "business" field.
  BusinessDataStruct? _business;
  BusinessDataStruct get business => _business ?? BusinessDataStruct();
  set business(BusinessDataStruct? val) => _business = val;

  void updateBusiness(Function(BusinessDataStruct) updateFn) {
    updateFn(_business ??= BusinessDataStruct());
  }

  bool hasBusiness() => _business != null;

  // "requests" field.
  RequestWithServiceDataStruct? _requests;
  RequestWithServiceDataStruct get requests =>
      _requests ?? RequestWithServiceDataStruct();
  set requests(RequestWithServiceDataStruct? val) => _requests = val;

  void updateRequests(Function(RequestWithServiceDataStruct) updateFn) {
    updateFn(_requests ??= RequestWithServiceDataStruct());
  }

  bool hasRequests() => _requests != null;

  // "address" field.
  AddressDataStruct? _address;
  AddressDataStruct get address => _address ?? AddressDataStruct();
  set address(AddressDataStruct? val) => _address = val;

  void updateAddress(Function(AddressDataStruct) updateFn) {
    updateFn(_address ??= AddressDataStruct());
  }

  bool hasAddress() => _address != null;

  // "oboBusinessId" field.
  int? _oboBusinessId;
  int get oboBusinessId => _oboBusinessId ?? 0;
  set oboBusinessId(int? val) => _oboBusinessId = val;

  void incrementOboBusinessId(int amount) =>
      oboBusinessId = oboBusinessId + amount;

  bool hasOboBusinessId() => _oboBusinessId != null;

  // "resourceId" field.
  int? _resourceId;
  int get resourceId => _resourceId ?? 0;
  set resourceId(int? val) => _resourceId = val;

  void incrementResourceId(int amount) => resourceId = resourceId + amount;

  bool hasResourceId() => _resourceId != null;

  // "resources" field.
  ResourceDataStruct? _resources;
  ResourceDataStruct get resources => _resources ?? ResourceDataStruct();
  set resources(ResourceDataStruct? val) => _resources = val;

  void updateResources(Function(ResourceDataStruct) updateFn) {
    updateFn(_resources ??= ResourceDataStruct());
  }

  bool hasResources() => _resources != null;

  static ClientBookingsFullDataStruct fromMap(Map<String, dynamic> data) =>
      ClientBookingsFullDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        clientId: castToType<int>(data['clientId']),
        businessId: castToType<int>(data['businessId']),
        addressId: castToType<int>(data['addressId']),
        status: data['status'] as String?,
        requestId: castToType<int>(data['requestId']),
        startTimeUtc: data['startTimeUtc'] as DateTime?,
        endTimeUtc: data['endTimeUtc'] as DateTime?,
        quote: data['quote'] is QuoteDataStruct
            ? data['quote']
            : QuoteDataStruct.maybeFromMap(data['quote']),
        business: data['business'] is BusinessDataStruct
            ? data['business']
            : BusinessDataStruct.maybeFromMap(data['business']),
        requests: data['requests'] is RequestWithServiceDataStruct
            ? data['requests']
            : RequestWithServiceDataStruct.maybeFromMap(data['requests']),
        address: data['address'] is AddressDataStruct
            ? data['address']
            : AddressDataStruct.maybeFromMap(data['address']),
        oboBusinessId: castToType<int>(data['oboBusinessId']),
        resourceId: castToType<int>(data['resourceId']),
        resources: data['resources'] is ResourceDataStruct
            ? data['resources']
            : ResourceDataStruct.maybeFromMap(data['resources']),
      );

  static ClientBookingsFullDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientBookingsFullDataStruct.fromMap(data.cast<String, dynamic>())
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
        'quote': _quote?.toMap(),
        'business': _business?.toMap(),
        'requests': _requests?.toMap(),
        'address': _address?.toMap(),
        'oboBusinessId': _oboBusinessId,
        'resourceId': _resourceId,
        'resources': _resources?.toMap(),
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
        'quote': serializeParam(
          _quote,
          ParamType.DataStruct,
        ),
        'business': serializeParam(
          _business,
          ParamType.DataStruct,
        ),
        'requests': serializeParam(
          _requests,
          ParamType.DataStruct,
        ),
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
        ),
        'oboBusinessId': serializeParam(
          _oboBusinessId,
          ParamType.int,
        ),
        'resourceId': serializeParam(
          _resourceId,
          ParamType.int,
        ),
        'resources': serializeParam(
          _resources,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ClientBookingsFullDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClientBookingsFullDataStruct(
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
        quote: deserializeStructParam(
          data['quote'],
          ParamType.DataStruct,
          false,
          structBuilder: QuoteDataStruct.fromSerializableMap,
        ),
        business: deserializeStructParam(
          data['business'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessDataStruct.fromSerializableMap,
        ),
        requests: deserializeStructParam(
          data['requests'],
          ParamType.DataStruct,
          false,
          structBuilder: RequestWithServiceDataStruct.fromSerializableMap,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: AddressDataStruct.fromSerializableMap,
        ),
        oboBusinessId: deserializeParam(
          data['oboBusinessId'],
          ParamType.int,
          false,
        ),
        resourceId: deserializeParam(
          data['resourceId'],
          ParamType.int,
          false,
        ),
        resources: deserializeStructParam(
          data['resources'],
          ParamType.DataStruct,
          false,
          structBuilder: ResourceDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ClientBookingsFullDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientBookingsFullDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        clientId == other.clientId &&
        businessId == other.businessId &&
        addressId == other.addressId &&
        status == other.status &&
        requestId == other.requestId &&
        startTimeUtc == other.startTimeUtc &&
        endTimeUtc == other.endTimeUtc &&
        quote == other.quote &&
        business == other.business &&
        requests == other.requests &&
        address == other.address &&
        oboBusinessId == other.oboBusinessId &&
        resourceId == other.resourceId &&
        resources == other.resources;
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
        quote,
        business,
        requests,
        address,
        oboBusinessId,
        resourceId,
        resources
      ]);
}

ClientBookingsFullDataStruct createClientBookingsFullDataStruct({
  int? id,
  DateTime? createdAt,
  int? clientId,
  int? businessId,
  int? addressId,
  String? status,
  int? requestId,
  DateTime? startTimeUtc,
  DateTime? endTimeUtc,
  QuoteDataStruct? quote,
  BusinessDataStruct? business,
  RequestWithServiceDataStruct? requests,
  AddressDataStruct? address,
  int? oboBusinessId,
  int? resourceId,
  ResourceDataStruct? resources,
}) =>
    ClientBookingsFullDataStruct(
      id: id,
      createdAt: createdAt,
      clientId: clientId,
      businessId: businessId,
      addressId: addressId,
      status: status,
      requestId: requestId,
      startTimeUtc: startTimeUtc,
      endTimeUtc: endTimeUtc,
      quote: quote ?? QuoteDataStruct(),
      business: business ?? BusinessDataStruct(),
      requests: requests ?? RequestWithServiceDataStruct(),
      address: address ?? AddressDataStruct(),
      oboBusinessId: oboBusinessId,
      resourceId: resourceId,
      resources: resources ?? ResourceDataStruct(),
    );
