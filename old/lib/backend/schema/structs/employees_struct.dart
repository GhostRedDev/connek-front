// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EmployeesStruct extends BaseStruct {
  EmployeesStruct({
    int? id,
    String? name,
    String? purpose,
    String? description,
    String? skills,
    String? frequency,
    int? price,
    String? currency,
    String? stripePriceId,
  })  : _id = id,
        _name = name,
        _purpose = purpose,
        _description = description,
        _skills = skills,
        _frequency = frequency,
        _price = price,
        _currency = currency,
        _stripePriceId = stripePriceId;

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

  // "purpose" field.
  String? _purpose;
  String get purpose => _purpose ?? '';
  set purpose(String? val) => _purpose = val;

  bool hasPurpose() => _purpose != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "skills" field.
  String? _skills;
  String get skills => _skills ?? '';
  set skills(String? val) => _skills = val;

  bool hasSkills() => _skills != null;

  // "frequency" field.
  String? _frequency;
  String get frequency => _frequency ?? '';
  set frequency(String? val) => _frequency = val;

  bool hasFrequency() => _frequency != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;

  void incrementPrice(int amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  set currency(String? val) => _currency = val;

  bool hasCurrency() => _currency != null;

  // "stripePriceId" field.
  String? _stripePriceId;
  String get stripePriceId => _stripePriceId ?? '';
  set stripePriceId(String? val) => _stripePriceId = val;

  bool hasStripePriceId() => _stripePriceId != null;

  static EmployeesStruct fromMap(Map<String, dynamic> data) => EmployeesStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        purpose: data['purpose'] as String?,
        description: data['description'] as String?,
        skills: data['skills'] as String?,
        frequency: data['frequency'] as String?,
        price: castToType<int>(data['price']),
        currency: data['currency'] as String?,
        stripePriceId: data['stripePriceId'] as String?,
      );

  static EmployeesStruct? maybeFromMap(dynamic data) => data is Map
      ? EmployeesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'purpose': _purpose,
        'description': _description,
        'skills': _skills,
        'frequency': _frequency,
        'price': _price,
        'currency': _currency,
        'stripePriceId': _stripePriceId,
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
        'purpose': serializeParam(
          _purpose,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'skills': serializeParam(
          _skills,
          ParamType.String,
        ),
        'frequency': serializeParam(
          _frequency,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'currency': serializeParam(
          _currency,
          ParamType.String,
        ),
        'stripePriceId': serializeParam(
          _stripePriceId,
          ParamType.String,
        ),
      }.withoutNulls;

  static EmployeesStruct fromSerializableMap(Map<String, dynamic> data) =>
      EmployeesStruct(
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
        purpose: deserializeParam(
          data['purpose'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        skills: deserializeParam(
          data['skills'],
          ParamType.String,
          false,
        ),
        frequency: deserializeParam(
          data['frequency'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        currency: deserializeParam(
          data['currency'],
          ParamType.String,
          false,
        ),
        stripePriceId: deserializeParam(
          data['stripePriceId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'EmployeesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EmployeesStruct &&
        id == other.id &&
        name == other.name &&
        purpose == other.purpose &&
        description == other.description &&
        skills == other.skills &&
        frequency == other.frequency &&
        price == other.price &&
        currency == other.currency &&
        stripePriceId == other.stripePriceId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        purpose,
        description,
        skills,
        frequency,
        price,
        currency,
        stripePriceId
      ]);
}

EmployeesStruct createEmployeesStruct({
  int? id,
  String? name,
  String? purpose,
  String? description,
  String? skills,
  String? frequency,
  int? price,
  String? currency,
  String? stripePriceId,
}) =>
    EmployeesStruct(
      id: id,
      name: name,
      purpose: purpose,
      description: description,
      skills: skills,
      frequency: frequency,
      price: price,
      currency: currency,
      stripePriceId: stripePriceId,
    );
