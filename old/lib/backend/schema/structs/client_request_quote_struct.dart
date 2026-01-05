// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientRequestQuoteStruct extends BaseStruct {
  ClientRequestQuoteStruct({
    int? quoteId,
    DateTime? createdAt,
    int? leadId,
    int? serviceId,
    int? amountCents,
    String? description,
    DateTime? expiring,
    bool? paid,
    String? status,
    String? businessName,
  })  : _quoteId = quoteId,
        _createdAt = createdAt,
        _leadId = leadId,
        _serviceId = serviceId,
        _amountCents = amountCents,
        _description = description,
        _expiring = expiring,
        _paid = paid,
        _status = status,
        _businessName = businessName;

  // "quoteId" field.
  int? _quoteId;
  int get quoteId => _quoteId ?? 0;
  set quoteId(int? val) => _quoteId = val;

  void incrementQuoteId(int amount) => quoteId = quoteId + amount;

  bool hasQuoteId() => _quoteId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

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

  // "amountCents" field.
  int? _amountCents;
  int get amountCents => _amountCents ?? 0;
  set amountCents(int? val) => _amountCents = val;

  void incrementAmountCents(int amount) => amountCents = amountCents + amount;

  bool hasAmountCents() => _amountCents != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "expiring" field.
  DateTime? _expiring;
  DateTime? get expiring => _expiring;
  set expiring(DateTime? val) => _expiring = val;

  bool hasExpiring() => _expiring != null;

  // "paid" field.
  bool? _paid;
  bool get paid => _paid ?? false;
  set paid(bool? val) => _paid = val;

  bool hasPaid() => _paid != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "businessName" field.
  String? _businessName;
  String get businessName => _businessName ?? '';
  set businessName(String? val) => _businessName = val;

  bool hasBusinessName() => _businessName != null;

  static ClientRequestQuoteStruct fromMap(Map<String, dynamic> data) =>
      ClientRequestQuoteStruct(
        quoteId: castToType<int>(data['quoteId']),
        createdAt: data['createdAt'] as DateTime?,
        leadId: castToType<int>(data['leadId']),
        serviceId: castToType<int>(data['serviceId']),
        amountCents: castToType<int>(data['amountCents']),
        description: data['description'] as String?,
        expiring: data['expiring'] as DateTime?,
        paid: data['paid'] as bool?,
        status: data['status'] as String?,
        businessName: data['businessName'] as String?,
      );

  static ClientRequestQuoteStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientRequestQuoteStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'quoteId': _quoteId,
        'createdAt': _createdAt,
        'leadId': _leadId,
        'serviceId': _serviceId,
        'amountCents': _amountCents,
        'description': _description,
        'expiring': _expiring,
        'paid': _paid,
        'status': _status,
        'businessName': _businessName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'quoteId': serializeParam(
          _quoteId,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'leadId': serializeParam(
          _leadId,
          ParamType.int,
        ),
        'serviceId': serializeParam(
          _serviceId,
          ParamType.int,
        ),
        'amountCents': serializeParam(
          _amountCents,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'expiring': serializeParam(
          _expiring,
          ParamType.DateTime,
        ),
        'paid': serializeParam(
          _paid,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'businessName': serializeParam(
          _businessName,
          ParamType.String,
        ),
      }.withoutNulls;

  static ClientRequestQuoteStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClientRequestQuoteStruct(
        quoteId: deserializeParam(
          data['quoteId'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
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
        amountCents: deserializeParam(
          data['amountCents'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        expiring: deserializeParam(
          data['expiring'],
          ParamType.DateTime,
          false,
        ),
        paid: deserializeParam(
          data['paid'],
          ParamType.bool,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        businessName: deserializeParam(
          data['businessName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ClientRequestQuoteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientRequestQuoteStruct &&
        quoteId == other.quoteId &&
        createdAt == other.createdAt &&
        leadId == other.leadId &&
        serviceId == other.serviceId &&
        amountCents == other.amountCents &&
        description == other.description &&
        expiring == other.expiring &&
        paid == other.paid &&
        status == other.status &&
        businessName == other.businessName;
  }

  @override
  int get hashCode => const ListEquality().hash([
        quoteId,
        createdAt,
        leadId,
        serviceId,
        amountCents,
        description,
        expiring,
        paid,
        status,
        businessName
      ]);
}

ClientRequestQuoteStruct createClientRequestQuoteStruct({
  int? quoteId,
  DateTime? createdAt,
  int? leadId,
  int? serviceId,
  int? amountCents,
  String? description,
  DateTime? expiring,
  bool? paid,
  String? status,
  String? businessName,
}) =>
    ClientRequestQuoteStruct(
      quoteId: quoteId,
      createdAt: createdAt,
      leadId: leadId,
      serviceId: serviceId,
      amountCents: amountCents,
      description: description,
      expiring: expiring,
      paid: paid,
      status: status,
      businessName: businessName,
    );
