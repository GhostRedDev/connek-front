// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GregPoliciesStruct extends BaseStruct {
  GregPoliciesStruct({
    String? name,
    String? description,
  })  : _name = name,
        _description = description;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  static GregPoliciesStruct fromMap(Map<String, dynamic> data) =>
      GregPoliciesStruct(
        name: data['name'] as String?,
        description: data['description'] as String?,
      );

  static GregPoliciesStruct? maybeFromMap(dynamic data) => data is Map
      ? GregPoliciesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'description': _description,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
      }.withoutNulls;

  static GregPoliciesStruct fromSerializableMap(Map<String, dynamic> data) =>
      GregPoliciesStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GregPoliciesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GregPoliciesStruct &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode => const ListEquality().hash([name, description]);
}

GregPoliciesStruct createGregPoliciesStruct({
  String? name,
  String? description,
}) =>
    GregPoliciesStruct(
      name: name,
      description: description,
    );
