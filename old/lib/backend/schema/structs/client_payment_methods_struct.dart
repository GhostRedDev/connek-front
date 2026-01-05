// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientPaymentMethodsStruct extends BaseStruct {
  ClientPaymentMethodsStruct({
    int? clientId,
    String? paymentMethodId,
    String? brand,
    String? expMonth,
    String? expYear,
    String? last4,
    int? id,
    int? businessId,
    bool? defaultMethod,
  })  : _clientId = clientId,
        _paymentMethodId = paymentMethodId,
        _brand = brand,
        _expMonth = expMonth,
        _expYear = expYear,
        _last4 = last4,
        _id = id,
        _businessId = businessId,
        _defaultMethod = defaultMethod;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "paymentMethodId" field.
  String? _paymentMethodId;
  String get paymentMethodId => _paymentMethodId ?? '';
  set paymentMethodId(String? val) => _paymentMethodId = val;

  bool hasPaymentMethodId() => _paymentMethodId != null;

  // "brand" field.
  String? _brand;
  String get brand => _brand ?? '';
  set brand(String? val) => _brand = val;

  bool hasBrand() => _brand != null;

  // "expMonth" field.
  String? _expMonth;
  String get expMonth => _expMonth ?? '';
  set expMonth(String? val) => _expMonth = val;

  bool hasExpMonth() => _expMonth != null;

  // "expYear" field.
  String? _expYear;
  String get expYear => _expYear ?? '';
  set expYear(String? val) => _expYear = val;

  bool hasExpYear() => _expYear != null;

  // "last4" field.
  String? _last4;
  String get last4 => _last4 ?? '';
  set last4(String? val) => _last4 = val;

  bool hasLast4() => _last4 != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "defaultMethod" field.
  bool? _defaultMethod;
  bool get defaultMethod => _defaultMethod ?? false;
  set defaultMethod(bool? val) => _defaultMethod = val;

  bool hasDefaultMethod() => _defaultMethod != null;

  static ClientPaymentMethodsStruct fromMap(Map<String, dynamic> data) =>
      ClientPaymentMethodsStruct(
        clientId: castToType<int>(data['clientId']),
        paymentMethodId: data['paymentMethodId'] as String?,
        brand: data['brand'] as String?,
        expMonth: data['expMonth'] as String?,
        expYear: data['expYear'] as String?,
        last4: data['last4'] as String?,
        id: castToType<int>(data['id']),
        businessId: castToType<int>(data['businessId']),
        defaultMethod: data['defaultMethod'] as bool?,
      );

  static ClientPaymentMethodsStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientPaymentMethodsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'clientId': _clientId,
        'paymentMethodId': _paymentMethodId,
        'brand': _brand,
        'expMonth': _expMonth,
        'expYear': _expYear,
        'last4': _last4,
        'id': _id,
        'businessId': _businessId,
        'defaultMethod': _defaultMethod,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'paymentMethodId': serializeParam(
          _paymentMethodId,
          ParamType.String,
        ),
        'brand': serializeParam(
          _brand,
          ParamType.String,
        ),
        'expMonth': serializeParam(
          _expMonth,
          ParamType.String,
        ),
        'expYear': serializeParam(
          _expYear,
          ParamType.String,
        ),
        'last4': serializeParam(
          _last4,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'defaultMethod': serializeParam(
          _defaultMethod,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ClientPaymentMethodsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClientPaymentMethodsStruct(
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        paymentMethodId: deserializeParam(
          data['paymentMethodId'],
          ParamType.String,
          false,
        ),
        brand: deserializeParam(
          data['brand'],
          ParamType.String,
          false,
        ),
        expMonth: deserializeParam(
          data['expMonth'],
          ParamType.String,
          false,
        ),
        expYear: deserializeParam(
          data['expYear'],
          ParamType.String,
          false,
        ),
        last4: deserializeParam(
          data['last4'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        defaultMethod: deserializeParam(
          data['defaultMethod'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ClientPaymentMethodsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientPaymentMethodsStruct &&
        clientId == other.clientId &&
        paymentMethodId == other.paymentMethodId &&
        brand == other.brand &&
        expMonth == other.expMonth &&
        expYear == other.expYear &&
        last4 == other.last4 &&
        id == other.id &&
        businessId == other.businessId &&
        defaultMethod == other.defaultMethod;
  }

  @override
  int get hashCode => const ListEquality().hash([
        clientId,
        paymentMethodId,
        brand,
        expMonth,
        expYear,
        last4,
        id,
        businessId,
        defaultMethod
      ]);
}

ClientPaymentMethodsStruct createClientPaymentMethodsStruct({
  int? clientId,
  String? paymentMethodId,
  String? brand,
  String? expMonth,
  String? expYear,
  String? last4,
  int? id,
  int? businessId,
  bool? defaultMethod,
}) =>
    ClientPaymentMethodsStruct(
      clientId: clientId,
      paymentMethodId: paymentMethodId,
      brand: brand,
      expMonth: expMonth,
      expYear: expYear,
      last4: last4,
      id: id,
      businessId: businessId,
      defaultMethod: defaultMethod,
    );
