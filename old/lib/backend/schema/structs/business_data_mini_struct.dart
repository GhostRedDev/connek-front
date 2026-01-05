// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessDataMiniStruct extends BaseStruct {
  BusinessDataMiniStruct({
    int? id,
    String? name,
    String? profileImage,
  })  : _id = id,
        _name = name,
        _profileImage = profileImage;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "profileImage" field.
  String? _profileImage;
  String get profileImage => _profileImage ?? '';
  set profileImage(String? val) => _profileImage = val;

  bool hasProfileImage() => _profileImage != null;

  static BusinessDataMiniStruct fromMap(Map<String, dynamic> data) =>
      BusinessDataMiniStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        profileImage: data['profileImage'] as String?,
      );

  static BusinessDataMiniStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessDataMiniStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'profileImage': _profileImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'profileImage': serializeParam(
          _profileImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static BusinessDataMiniStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessDataMiniStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        profileImage: deserializeParam(
          data['profileImage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BusinessDataMiniStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessDataMiniStruct &&
        id == other.id &&
        name == other.name &&
        profileImage == other.profileImage;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, profileImage]);
}

BusinessDataMiniStruct createBusinessDataMiniStruct({
  int? id,
  String? name,
  String? profileImage,
}) =>
    BusinessDataMiniStruct(
      id: id,
      name: name,
      profileImage: profileImage,
    );
