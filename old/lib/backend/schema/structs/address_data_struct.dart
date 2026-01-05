// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AddressDataStruct extends BaseStruct {
  AddressDataStruct({
    int? id,
    String? createdAt,
    String? line1,
    String? line2,
    String? city,
    String? postalCode,
    String? state,
    String? country,
    bool? location,
    bool? billing,
  })  : _id = id,
        _createdAt = createdAt,
        _line1 = line1,
        _line2 = line2,
        _city = city,
        _postalCode = postalCode,
        _state = state,
        _country = country,
        _location = location,
        _billing = billing;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "line1" field.
  String? _line1;
  String get line1 => _line1 ?? '';
  set line1(String? val) => _line1 = val;

  bool hasLine1() => _line1 != null;

  // "line2" field.
  String? _line2;
  String get line2 => _line2 ?? '';
  set line2(String? val) => _line2 = val;

  bool hasLine2() => _line2 != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "postalCode" field.
  String? _postalCode;
  String get postalCode => _postalCode ?? '';
  set postalCode(String? val) => _postalCode = val;

  bool hasPostalCode() => _postalCode != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;

  bool hasState() => _state != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  set country(String? val) => _country = val;

  bool hasCountry() => _country != null;

  // "location" field.
  bool? _location;
  bool get location => _location ?? false;
  set location(bool? val) => _location = val;

  bool hasLocation() => _location != null;

  // "billing" field.
  bool? _billing;
  bool get billing => _billing ?? false;
  set billing(bool? val) => _billing = val;

  bool hasBilling() => _billing != null;

  static AddressDataStruct fromMap(Map<String, dynamic> data) =>
      AddressDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['created_at'] as String?,
        line1: data['line1'] as String?,
        line2: data['line2'] as String?,
        city: data['city'] as String?,
        postalCode: data['postalCode'] as String?,
        state: data['state'] as String?,
        country: data['country'] as String?,
        location: data['location'] as bool?,
        billing: data['billing'] as bool?,
      );

  static AddressDataStruct? maybeFromMap(dynamic data) => data is Map
      ? AddressDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'created_at': _createdAt,
        'line1': _line1,
        'line2': _line2,
        'city': _city,
        'postalCode': _postalCode,
        'state': _state,
        'country': _country,
        'location': _location,
        'billing': _billing,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'line1': serializeParam(
          _line1,
          ParamType.String,
        ),
        'line2': serializeParam(
          _line2,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'postalCode': serializeParam(
          _postalCode,
          ParamType.String,
        ),
        'state': serializeParam(
          _state,
          ParamType.String,
        ),
        'country': serializeParam(
          _country,
          ParamType.String,
        ),
        'location': serializeParam(
          _location,
          ParamType.bool,
        ),
        'billing': serializeParam(
          _billing,
          ParamType.bool,
        ),
      }.withoutNulls;

  static AddressDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      AddressDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        line1: deserializeParam(
          data['line1'],
          ParamType.String,
          false,
        ),
        line2: deserializeParam(
          data['line2'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        postalCode: deserializeParam(
          data['postalCode'],
          ParamType.String,
          false,
        ),
        state: deserializeParam(
          data['state'],
          ParamType.String,
          false,
        ),
        country: deserializeParam(
          data['country'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.bool,
          false,
        ),
        billing: deserializeParam(
          data['billing'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'AddressDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AddressDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        line1 == other.line1 &&
        line2 == other.line2 &&
        city == other.city &&
        postalCode == other.postalCode &&
        state == other.state &&
        country == other.country &&
        location == other.location &&
        billing == other.billing;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        line1,
        line2,
        city,
        postalCode,
        state,
        country,
        location,
        billing
      ]);
}

AddressDataStruct createAddressDataStruct({
  int? id,
  String? createdAt,
  String? line1,
  String? line2,
  String? city,
  String? postalCode,
  String? state,
  String? country,
  bool? location,
  bool? billing,
}) =>
    AddressDataStruct(
      id: id,
      createdAt: createdAt,
      line1: line1,
      line2: line2,
      city: city,
      postalCode: postalCode,
      state: state,
      country: country,
      location: location,
      billing: billing,
    );
