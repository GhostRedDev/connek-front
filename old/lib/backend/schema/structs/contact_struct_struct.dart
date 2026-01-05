// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactStructStruct extends BaseStruct {
  ContactStructStruct({
    String? name,
    String? phone,
  })  : _name = name,
        _phone = phone;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  static ContactStructStruct fromMap(Map<String, dynamic> data) =>
      ContactStructStruct(
        name: data['name'] as String?,
        phone: data['phone'] as String?,
      );

  static ContactStructStruct? maybeFromMap(dynamic data) => data is Map
      ? ContactStructStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'phone': _phone,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
      }.withoutNulls;

  static ContactStructStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContactStructStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ContactStructStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContactStructStruct &&
        name == other.name &&
        phone == other.phone;
  }

  @override
  int get hashCode => const ListEquality().hash([name, phone]);
}

ContactStructStruct createContactStructStruct({
  String? name,
  String? phone,
}) =>
    ContactStructStruct(
      name: name,
      phone: phone,
    );
