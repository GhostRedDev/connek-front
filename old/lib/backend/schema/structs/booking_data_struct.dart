// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookingDataStruct extends BaseStruct {
  BookingDataStruct({
    int? id,
    DateTime? createdAt,
    int? clientId,
    int? businessId,
    int? addressId,
    String? status,
    int? requestId,
    DateTime? startTimeUtc,
    DateTime? endTimeUtc,
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

  // "oboBusinessId" field.
  int? _oboBusinessId;
  int get oboBusinessId => _oboBusinessId ?? 0;
  set oboBusinessId(int? val) => _oboBusinessId = val;

  void incrementOboBusinessId(int amount) =>
      oboBusinessId = oboBusinessId + amount;

  bool hasOboBusinessId() => _oboBusinessId != null;

  static BookingDataStruct fromMap(Map<String, dynamic> data) =>
      BookingDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        clientId: castToType<int>(data['clientId']),
        businessId: castToType<int>(data['businessId']),
        addressId: castToType<int>(data['addressId']),
        status: data['status'] as String?,
        requestId: castToType<int>(data['requestId']),
        startTimeUtc: data['startTimeUtc'] as DateTime?,
        endTimeUtc: data['endTimeUtc'] as DateTime?,
        oboBusinessId: castToType<int>(data['oboBusinessId']),
      );

  static BookingDataStruct? maybeFromMap(dynamic data) => data is Map
      ? BookingDataStruct.fromMap(data.cast<String, dynamic>())
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
        'oboBusinessId': serializeParam(
          _oboBusinessId,
          ParamType.int,
        ),
      }.withoutNulls;

  static BookingDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      BookingDataStruct(
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
        oboBusinessId: deserializeParam(
          data['oboBusinessId'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'BookingDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BookingDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        clientId == other.clientId &&
        businessId == other.businessId &&
        addressId == other.addressId &&
        status == other.status &&
        requestId == other.requestId &&
        startTimeUtc == other.startTimeUtc &&
        endTimeUtc == other.endTimeUtc &&
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
        oboBusinessId
      ]);
}

BookingDataStruct createBookingDataStruct({
  int? id,
  DateTime? createdAt,
  int? clientId,
  int? businessId,
  int? addressId,
  String? status,
  int? requestId,
  DateTime? startTimeUtc,
  DateTime? endTimeUtc,
  int? oboBusinessId,
}) =>
    BookingDataStruct(
      id: id,
      createdAt: createdAt,
      clientId: clientId,
      businessId: businessId,
      addressId: addressId,
      status: status,
      requestId: requestId,
      startTimeUtc: startTimeUtc,
      endTimeUtc: endTimeUtc,
      oboBusinessId: oboBusinessId,
    );
