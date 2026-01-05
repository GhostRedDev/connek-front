// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BusinessOpeningHoursStruct extends BaseStruct {
  BusinessOpeningHoursStruct({
    String? monday,
    String? tuesday,
    String? wednesday,
    String? thursday,
    String? friday,
    String? saturday,
    String? sunday,
  })  : _monday = monday,
        _tuesday = tuesday,
        _wednesday = wednesday,
        _thursday = thursday,
        _friday = friday,
        _saturday = saturday,
        _sunday = sunday;

  // "monday" field.
  String? _monday;
  String get monday => _monday ?? '';
  set monday(String? val) => _monday = val;

  bool hasMonday() => _monday != null;

  // "tuesday" field.
  String? _tuesday;
  String get tuesday => _tuesday ?? '';
  set tuesday(String? val) => _tuesday = val;

  bool hasTuesday() => _tuesday != null;

  // "wednesday" field.
  String? _wednesday;
  String get wednesday => _wednesday ?? '';
  set wednesday(String? val) => _wednesday = val;

  bool hasWednesday() => _wednesday != null;

  // "thursday" field.
  String? _thursday;
  String get thursday => _thursday ?? '';
  set thursday(String? val) => _thursday = val;

  bool hasThursday() => _thursday != null;

  // "friday" field.
  String? _friday;
  String get friday => _friday ?? '';
  set friday(String? val) => _friday = val;

  bool hasFriday() => _friday != null;

  // "saturday" field.
  String? _saturday;
  String get saturday => _saturday ?? '';
  set saturday(String? val) => _saturday = val;

  bool hasSaturday() => _saturday != null;

  // "sunday" field.
  String? _sunday;
  String get sunday => _sunday ?? '';
  set sunday(String? val) => _sunday = val;

  bool hasSunday() => _sunday != null;

  static BusinessOpeningHoursStruct fromMap(Map<String, dynamic> data) =>
      BusinessOpeningHoursStruct(
        monday: data['monday'] as String?,
        tuesday: data['tuesday'] as String?,
        wednesday: data['wednesday'] as String?,
        thursday: data['thursday'] as String?,
        friday: data['friday'] as String?,
        saturday: data['saturday'] as String?,
        sunday: data['sunday'] as String?,
      );

  static BusinessOpeningHoursStruct? maybeFromMap(dynamic data) => data is Map
      ? BusinessOpeningHoursStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'monday': _monday,
        'tuesday': _tuesday,
        'wednesday': _wednesday,
        'thursday': _thursday,
        'friday': _friday,
        'saturday': _saturday,
        'sunday': _sunday,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'monday': serializeParam(
          _monday,
          ParamType.String,
        ),
        'tuesday': serializeParam(
          _tuesday,
          ParamType.String,
        ),
        'wednesday': serializeParam(
          _wednesday,
          ParamType.String,
        ),
        'thursday': serializeParam(
          _thursday,
          ParamType.String,
        ),
        'friday': serializeParam(
          _friday,
          ParamType.String,
        ),
        'saturday': serializeParam(
          _saturday,
          ParamType.String,
        ),
        'sunday': serializeParam(
          _sunday,
          ParamType.String,
        ),
      }.withoutNulls;

  static BusinessOpeningHoursStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BusinessOpeningHoursStruct(
        monday: deserializeParam(
          data['monday'],
          ParamType.String,
          false,
        ),
        tuesday: deserializeParam(
          data['tuesday'],
          ParamType.String,
          false,
        ),
        wednesday: deserializeParam(
          data['wednesday'],
          ParamType.String,
          false,
        ),
        thursday: deserializeParam(
          data['thursday'],
          ParamType.String,
          false,
        ),
        friday: deserializeParam(
          data['friday'],
          ParamType.String,
          false,
        ),
        saturday: deserializeParam(
          data['saturday'],
          ParamType.String,
          false,
        ),
        sunday: deserializeParam(
          data['sunday'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BusinessOpeningHoursStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BusinessOpeningHoursStruct &&
        monday == other.monday &&
        tuesday == other.tuesday &&
        wednesday == other.wednesday &&
        thursday == other.thursday &&
        friday == other.friday &&
        saturday == other.saturday &&
        sunday == other.sunday;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([monday, tuesday, wednesday, thursday, friday, saturday, sunday]);
}

BusinessOpeningHoursStruct createBusinessOpeningHoursStruct({
  String? monday,
  String? tuesday,
  String? wednesday,
  String? thursday,
  String? friday,
  String? saturday,
  String? sunday,
}) =>
    BusinessOpeningHoursStruct(
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
      sunday: sunday,
    );
