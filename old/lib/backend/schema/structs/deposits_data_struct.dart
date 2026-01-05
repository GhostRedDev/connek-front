// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DepositsDataStruct extends BaseStruct {
  DepositsDataStruct({
    int? id,
    DateTime? createdAt,
    int? amountCents,
    String? currency,
    String? category,
    int? paymentMethodId,
    int? clientId,
    int? businessId,
    String? stripePaymentId,
  })  : _id = id,
        _createdAt = createdAt,
        _amountCents = amountCents,
        _currency = currency,
        _category = category,
        _paymentMethodId = paymentMethodId,
        _clientId = clientId,
        _businessId = businessId,
        _stripePaymentId = stripePaymentId;

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

  // "amountCents" field.
  int? _amountCents;
  int get amountCents => _amountCents ?? 0;
  set amountCents(int? val) => _amountCents = val;

  void incrementAmountCents(int amount) => amountCents = amountCents + amount;

  bool hasAmountCents() => _amountCents != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  set currency(String? val) => _currency = val;

  bool hasCurrency() => _currency != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "paymentMethodId" field.
  int? _paymentMethodId;
  int get paymentMethodId => _paymentMethodId ?? 0;
  set paymentMethodId(int? val) => _paymentMethodId = val;

  void incrementPaymentMethodId(int amount) =>
      paymentMethodId = paymentMethodId + amount;

  bool hasPaymentMethodId() => _paymentMethodId != null;

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

  // "stripePaymentId" field.
  String? _stripePaymentId;
  String get stripePaymentId => _stripePaymentId ?? '';
  set stripePaymentId(String? val) => _stripePaymentId = val;

  bool hasStripePaymentId() => _stripePaymentId != null;

  static DepositsDataStruct fromMap(Map<String, dynamic> data) =>
      DepositsDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        amountCents: castToType<int>(data['amountCents']),
        currency: data['currency'] as String?,
        category: data['category'] as String?,
        paymentMethodId: castToType<int>(data['paymentMethodId']),
        clientId: castToType<int>(data['clientId']),
        businessId: castToType<int>(data['businessId']),
        stripePaymentId: data['stripePaymentId'] as String?,
      );

  static DepositsDataStruct? maybeFromMap(dynamic data) => data is Map
      ? DepositsDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'amountCents': _amountCents,
        'currency': _currency,
        'category': _category,
        'paymentMethodId': _paymentMethodId,
        'clientId': _clientId,
        'businessId': _businessId,
        'stripePaymentId': _stripePaymentId,
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
        'amountCents': serializeParam(
          _amountCents,
          ParamType.int,
        ),
        'currency': serializeParam(
          _currency,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'paymentMethodId': serializeParam(
          _paymentMethodId,
          ParamType.int,
        ),
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'stripePaymentId': serializeParam(
          _stripePaymentId,
          ParamType.String,
        ),
      }.withoutNulls;

  static DepositsDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      DepositsDataStruct(
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
        amountCents: deserializeParam(
          data['amountCents'],
          ParamType.int,
          false,
        ),
        currency: deserializeParam(
          data['currency'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        paymentMethodId: deserializeParam(
          data['paymentMethodId'],
          ParamType.int,
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
        stripePaymentId: deserializeParam(
          data['stripePaymentId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DepositsDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DepositsDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        amountCents == other.amountCents &&
        currency == other.currency &&
        category == other.category &&
        paymentMethodId == other.paymentMethodId &&
        clientId == other.clientId &&
        businessId == other.businessId &&
        stripePaymentId == other.stripePaymentId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        amountCents,
        currency,
        category,
        paymentMethodId,
        clientId,
        businessId,
        stripePaymentId
      ]);
}

DepositsDataStruct createDepositsDataStruct({
  int? id,
  DateTime? createdAt,
  int? amountCents,
  String? currency,
  String? category,
  int? paymentMethodId,
  int? clientId,
  int? businessId,
  String? stripePaymentId,
}) =>
    DepositsDataStruct(
      id: id,
      createdAt: createdAt,
      amountCents: amountCents,
      currency: currency,
      category: category,
      paymentMethodId: paymentMethodId,
      clientId: clientId,
      businessId: businessId,
      stripePaymentId: stripePaymentId,
    );
