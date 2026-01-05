// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookingSlotStruct extends BaseStruct {
  BookingSlotStruct({
    String? startTime,
    String? endTime,
    String? day,
  })  : _startTime = startTime,
        _endTime = endTime,
        _day = day;

  // "startTime" field.
  String? _startTime;
  String get startTime => _startTime ?? '';
  set startTime(String? val) => _startTime = val;

  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  String? _endTime;
  String get endTime => _endTime ?? '';
  set endTime(String? val) => _endTime = val;

  bool hasEndTime() => _endTime != null;

  // "day" field.
  String? _day;
  String get day => _day ?? '';
  set day(String? val) => _day = val;

  bool hasDay() => _day != null;

  static BookingSlotStruct fromMap(Map<String, dynamic> data) =>
      BookingSlotStruct(
        startTime: data['startTime'] as String?,
        endTime: data['endTime'] as String?,
        day: data['day'] as String?,
      );

  static BookingSlotStruct? maybeFromMap(dynamic data) => data is Map
      ? BookingSlotStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'startTime': _startTime,
        'endTime': _endTime,
        'day': _day,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'startTime': serializeParam(
          _startTime,
          ParamType.String,
        ),
        'endTime': serializeParam(
          _endTime,
          ParamType.String,
        ),
        'day': serializeParam(
          _day,
          ParamType.String,
        ),
      }.withoutNulls;

  static BookingSlotStruct fromSerializableMap(Map<String, dynamic> data) =>
      BookingSlotStruct(
        startTime: deserializeParam(
          data['startTime'],
          ParamType.String,
          false,
        ),
        endTime: deserializeParam(
          data['endTime'],
          ParamType.String,
          false,
        ),
        day: deserializeParam(
          data['day'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BookingSlotStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BookingSlotStruct &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        day == other.day;
  }

  @override
  int get hashCode => const ListEquality().hash([startTime, endTime, day]);
}

BookingSlotStruct createBookingSlotStruct({
  String? startTime,
  String? endTime,
  String? day,
}) =>
    BookingSlotStruct(
      startTime: startTime,
      endTime: endTime,
      day: day,
    );
