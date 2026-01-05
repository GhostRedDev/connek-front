// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BalancesStruct extends BaseStruct {
  BalancesStruct({
    int? client,
    int? business,
  })  : _client = client,
        _business = business;

  // "client" field.
  int? _client;
  int get client => _client ?? 0;
  set client(int? val) => _client = val;

  void incrementClient(int amount) => client = client + amount;

  bool hasClient() => _client != null;

  // "business" field.
  int? _business;
  int get business => _business ?? 0;
  set business(int? val) => _business = val;

  void incrementBusiness(int amount) => business = business + amount;

  bool hasBusiness() => _business != null;

  static BalancesStruct fromMap(Map<String, dynamic> data) => BalancesStruct(
        client: castToType<int>(data['client']),
        business: castToType<int>(data['business']),
      );

  static BalancesStruct? maybeFromMap(dynamic data) =>
      data is Map ? BalancesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'client': _client,
        'business': _business,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'client': serializeParam(
          _client,
          ParamType.int,
        ),
        'business': serializeParam(
          _business,
          ParamType.int,
        ),
      }.withoutNulls;

  static BalancesStruct fromSerializableMap(Map<String, dynamic> data) =>
      BalancesStruct(
        client: deserializeParam(
          data['client'],
          ParamType.int,
          false,
        ),
        business: deserializeParam(
          data['business'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'BalancesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BalancesStruct &&
        client == other.client &&
        business == other.business;
  }

  @override
  int get hashCode => const ListEquality().hash([client, business]);
}

BalancesStruct createBalancesStruct({
  int? client,
  int? business,
}) =>
    BalancesStruct(
      client: client,
      business: business,
    );
