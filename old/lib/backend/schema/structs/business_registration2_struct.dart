// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessRegistration2Struct extends BaseStruct {
  BusinessRegistration2Struct({
    String? name,
    String? description,
    String? category,
    AddressDataStruct? address,
    String? googleId,
  })  : _name = name,
        _description = description,
        _category = category,
        _address = address,
        _googleId = googleId;

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

  // "category" field.
  String? _category;
  String get category => _category ?? 'Florists';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "address" field.
  AddressDataStruct? _address;
  AddressDataStruct get address => _address ?? AddressDataStruct();
  set address(AddressDataStruct? val) => _address = val;

  void updateAddress(Function(AddressDataStruct) updateFn) {
    updateFn(_address ??= AddressDataStruct());
  }

  bool hasAddress() => _address != null;

  // "googleId" field.
  String? _googleId;
  String get googleId => _googleId ?? '';
  set googleId(String? val) => _googleId = val;

  bool hasGoogleId() => _googleId != null;

  static BusinessRegistration2Struct fromMap(Map<String, dynamic> data) =>
      BusinessRegistration2Struct(
        name: data['name'] as String?,
        description: data['description'] as String?,
        category: data['category'] as String?,
        address: data['address'] is AddressDataStruct
            ? data['address']
            : AddressDataStruct.maybeFromMap(data['address']),
        googleId: data['googleId'] as String?,
      );

  static BusinessRegistration2Struct? maybeFromMap(dynamic data) => data is Map
      ? BusinessRegistration2Struct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'description': _description,
        'category': _category,
        'address': _address?.toMap(),
        'googleId': _googleId,
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
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.DataStruct,
        ),
        'googleId': serializeParam(
          _googleId,
          ParamType.String,
        ),
      }.withoutNulls;

  static BusinessRegistration2Struct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessRegistration2Struct(
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
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        address: deserializeStructParam(
          data['address'],
          ParamType.DataStruct,
          false,
          structBuilder: AddressDataStruct.fromSerializableMap,
        ),
        googleId: deserializeParam(
          data['googleId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BusinessRegistration2Struct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessRegistration2Struct &&
        name == other.name &&
        description == other.description &&
        category == other.category &&
        address == other.address &&
        googleId == other.googleId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([name, description, category, address, googleId]);
}

BusinessRegistration2Struct createBusinessRegistration2Struct({
  String? name,
  String? description,
  String? category,
  AddressDataStruct? address,
  String? googleId,
}) =>
    BusinessRegistration2Struct(
      name: name,
      description: description,
      category: category,
      address: address ?? AddressDataStruct(),
      googleId: googleId,
    );
