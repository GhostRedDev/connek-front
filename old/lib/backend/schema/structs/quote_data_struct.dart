// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuoteDataStruct extends BaseStruct {
  QuoteDataStruct({
    int? id,
    String? createdAt,
    int? leadId,
    int? serviceId,
    String? description,
    String? status,
    int? amountCents,
    bool? paid,
    String? expiring,
  })  : _id = id,
        _createdAt = createdAt,
        _leadId = leadId,
        _serviceId = serviceId,
        _description = description,
        _status = status,
        _amountCents = amountCents,
        _paid = paid,
        _expiring = expiring;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "createdAt" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "leadId" field.
  int? _leadId;
  int get leadId => _leadId ?? 0;
  set leadId(int? val) => _leadId = val;

  void incrementLeadId(int amount) => leadId = leadId + amount;

  bool hasLeadId() => _leadId != null;

  // "serviceId" field.
  int? _serviceId;
  int get serviceId => _serviceId ?? 0;
  set serviceId(int? val) => _serviceId = val;

  void incrementServiceId(int amount) => serviceId = serviceId + amount;

  bool hasServiceId() => _serviceId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "amountCents" field.
  int? _amountCents;
  int get amountCents => _amountCents ?? 0;
  set amountCents(int? val) => _amountCents = val;

  void incrementAmountCents(int amount) => amountCents = amountCents + amount;

  bool hasAmountCents() => _amountCents != null;

  // "paid" field.
  bool? _paid;
  bool get paid => _paid ?? false;
  set paid(bool? val) => _paid = val;

  bool hasPaid() => _paid != null;

  // "expiring" field.
  String? _expiring;
  String get expiring => _expiring ?? '';
  set expiring(String? val) => _expiring = val;

  bool hasExpiring() => _expiring != null;

  static QuoteDataStruct fromMap(Map<String, dynamic> data) => QuoteDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as String?,
        leadId: castToType<int>(data['leadId']),
        serviceId: castToType<int>(data['serviceId']),
        description: data['description'] as String?,
        status: data['status'] as String?,
        amountCents: castToType<int>(data['amountCents']),
        paid: data['paid'] as bool?,
        expiring: data['expiring'] as String?,
      );

  static QuoteDataStruct? maybeFromMap(dynamic data) => data is Map
      ? QuoteDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'leadId': _leadId,
        'serviceId': _serviceId,
        'description': _description,
        'status': _status,
        'amountCents': _amountCents,
        'paid': _paid,
        'expiring': _expiring,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'leadId': serializeParam(
          _leadId,
          ParamType.int,
        ),
        'serviceId': serializeParam(
          _serviceId,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'amountCents': serializeParam(
          _amountCents,
          ParamType.int,
        ),
        'paid': serializeParam(
          _paid,
          ParamType.bool,
        ),
        'expiring': serializeParam(
          _expiring,
          ParamType.String,
        ),
      }.withoutNulls;

  static QuoteDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuoteDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.String,
          false,
        ),
        leadId: deserializeParam(
          data['leadId'],
          ParamType.int,
          false,
        ),
        serviceId: deserializeParam(
          data['serviceId'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        amountCents: deserializeParam(
          data['amountCents'],
          ParamType.int,
          false,
        ),
        paid: deserializeParam(
          data['paid'],
          ParamType.bool,
          false,
        ),
        expiring: deserializeParam(
          data['expiring'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'QuoteDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is QuoteDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        leadId == other.leadId &&
        serviceId == other.serviceId &&
        description == other.description &&
        status == other.status &&
        amountCents == other.amountCents &&
        paid == other.paid &&
        expiring == other.expiring;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        leadId,
        serviceId,
        description,
        status,
        amountCents,
        paid,
        expiring
      ]);
}

QuoteDataStruct createQuoteDataStruct({
  int? id,
  String? createdAt,
  int? leadId,
  int? serviceId,
  String? description,
  String? status,
  int? amountCents,
  bool? paid,
  String? expiring,
}) =>
    QuoteDataStruct(
      id: id,
      createdAt: createdAt,
      leadId: leadId,
      serviceId: serviceId,
      description: description,
      status: status,
      amountCents: amountCents,
      paid: paid,
      expiring: expiring,
    );
