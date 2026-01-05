// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyBotsStruct extends BaseStruct {
  MyBotsStruct({
    GregDataStruct? greg,
  }) : _greg = greg;

  // "greg" field.
  GregDataStruct? _greg;
  GregDataStruct get greg => _greg ?? GregDataStruct();
  set greg(GregDataStruct? val) => _greg = val;

  void updateGreg(Function(GregDataStruct) updateFn) {
    updateFn(_greg ??= GregDataStruct());
  }

  bool hasGreg() => _greg != null;

  static MyBotsStruct fromMap(Map<String, dynamic> data) => MyBotsStruct(
        greg: data['greg'] is GregDataStruct
            ? data['greg']
            : GregDataStruct.maybeFromMap(data['greg']),
      );

  static MyBotsStruct? maybeFromMap(dynamic data) =>
      data is Map ? MyBotsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'greg': _greg?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'greg': serializeParam(
          _greg,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static MyBotsStruct fromSerializableMap(Map<String, dynamic> data) =>
      MyBotsStruct(
        greg: deserializeStructParam(
          data['greg'],
          ParamType.DataStruct,
          false,
          structBuilder: GregDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'MyBotsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MyBotsStruct && greg == other.greg;
  }

  @override
  int get hashCode => const ListEquality().hash([greg]);
}

MyBotsStruct createMyBotsStruct({
  GregDataStruct? greg,
}) =>
    MyBotsStruct(
      greg: greg ?? GregDataStruct(),
    );
