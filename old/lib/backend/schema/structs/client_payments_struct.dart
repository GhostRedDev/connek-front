// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientPaymentsStruct extends BaseStruct {
  ClientPaymentsStruct({
    int? amountCents,
    DateTime? createdAt,
  })  : _amountCents = amountCents,
        _createdAt = createdAt;

  // "amountCents" field.
  int? _amountCents;
  int get amountCents => _amountCents ?? 0;
  set amountCents(int? val) => _amountCents = val;

  void incrementAmountCents(int amount) => amountCents = amountCents + amount;

  bool hasAmountCents() => _amountCents != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static ClientPaymentsStruct fromMap(Map<String, dynamic> data) =>
      ClientPaymentsStruct(
        amountCents: castToType<int>(data['amountCents']),
        createdAt: data['createdAt'] as DateTime?,
      );

  static ClientPaymentsStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientPaymentsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'amountCents': _amountCents,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'amountCents': serializeParam(
          _amountCents,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ClientPaymentsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClientPaymentsStruct(
        amountCents: deserializeParam(
          data['amountCents'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'ClientPaymentsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientPaymentsStruct &&
        amountCents == other.amountCents &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([amountCents, createdAt]);
}

ClientPaymentsStruct createClientPaymentsStruct({
  int? amountCents,
  DateTime? createdAt,
}) =>
    ClientPaymentsStruct(
      amountCents: amountCents,
      createdAt: createdAt,
    );
