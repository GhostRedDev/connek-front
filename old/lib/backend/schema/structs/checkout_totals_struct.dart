// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckoutTotalsStruct extends BaseStruct {
  CheckoutTotalsStruct({
    double? subtotal,
    double? tps,
    double? tvq,
    double? connekFee,
    double? total,
  })  : _subtotal = subtotal,
        _tps = tps,
        _tvq = tvq,
        _connekFee = connekFee,
        _total = total;

  // "subtotal" field.
  double? _subtotal;
  double get subtotal => _subtotal ?? 0.0;
  set subtotal(double? val) => _subtotal = val;

  void incrementSubtotal(double amount) => subtotal = subtotal + amount;

  bool hasSubtotal() => _subtotal != null;

  // "tps" field.
  double? _tps;
  double get tps => _tps ?? 0.0;
  set tps(double? val) => _tps = val;

  void incrementTps(double amount) => tps = tps + amount;

  bool hasTps() => _tps != null;

  // "tvq" field.
  double? _tvq;
  double get tvq => _tvq ?? 0.0;
  set tvq(double? val) => _tvq = val;

  void incrementTvq(double amount) => tvq = tvq + amount;

  bool hasTvq() => _tvq != null;

  // "connekFee" field.
  double? _connekFee;
  double get connekFee => _connekFee ?? 3.00;
  set connekFee(double? val) => _connekFee = val;

  void incrementConnekFee(double amount) => connekFee = connekFee + amount;

  bool hasConnekFee() => _connekFee != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  set total(double? val) => _total = val;

  void incrementTotal(double amount) => total = total + amount;

  bool hasTotal() => _total != null;

  static CheckoutTotalsStruct fromMap(Map<String, dynamic> data) =>
      CheckoutTotalsStruct(
        subtotal: castToType<double>(data['subtotal']),
        tps: castToType<double>(data['tps']),
        tvq: castToType<double>(data['tvq']),
        connekFee: castToType<double>(data['connekFee']),
        total: castToType<double>(data['total']),
      );

  static CheckoutTotalsStruct? maybeFromMap(dynamic data) => data is Map
      ? CheckoutTotalsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'subtotal': _subtotal,
        'tps': _tps,
        'tvq': _tvq,
        'connekFee': _connekFee,
        'total': _total,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'subtotal': serializeParam(
          _subtotal,
          ParamType.double,
        ),
        'tps': serializeParam(
          _tps,
          ParamType.double,
        ),
        'tvq': serializeParam(
          _tvq,
          ParamType.double,
        ),
        'connekFee': serializeParam(
          _connekFee,
          ParamType.double,
        ),
        'total': serializeParam(
          _total,
          ParamType.double,
        ),
      }.withoutNulls;

  static CheckoutTotalsStruct fromSerializableMap(Map<String, dynamic> data) =>
      CheckoutTotalsStruct(
        subtotal: deserializeParam(
          data['subtotal'],
          ParamType.double,
          false,
        ),
        tps: deserializeParam(
          data['tps'],
          ParamType.double,
          false,
        ),
        tvq: deserializeParam(
          data['tvq'],
          ParamType.double,
          false,
        ),
        connekFee: deserializeParam(
          data['connekFee'],
          ParamType.double,
          false,
        ),
        total: deserializeParam(
          data['total'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'CheckoutTotalsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CheckoutTotalsStruct &&
        subtotal == other.subtotal &&
        tps == other.tps &&
        tvq == other.tvq &&
        connekFee == other.connekFee &&
        total == other.total;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([subtotal, tps, tvq, connekFee, total]);
}

CheckoutTotalsStruct createCheckoutTotalsStruct({
  double? subtotal,
  double? tps,
  double? tvq,
  double? connekFee,
  double? total,
}) =>
    CheckoutTotalsStruct(
      subtotal: subtotal,
      tps: tps,
      tvq: tvq,
      connekFee: connekFee,
      total: total,
    );
