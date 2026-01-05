// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LeadTimelineStepStruct extends BaseStruct {
  LeadTimelineStepStruct({
    String? createdAt,
  }) : _createdAt = createdAt;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static LeadTimelineStepStruct fromMap(Map<String, dynamic> data) =>
      LeadTimelineStepStruct(
        createdAt: data['created_at'] as String?,
      );

  static LeadTimelineStepStruct? maybeFromMap(dynamic data) => data is Map
      ? LeadTimelineStepStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static LeadTimelineStepStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      LeadTimelineStepStruct(
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LeadTimelineStepStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LeadTimelineStepStruct && createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([createdAt]);
}

LeadTimelineStepStruct createLeadTimelineStepStruct({
  String? createdAt,
}) =>
    LeadTimelineStepStruct(
      createdAt: createdAt,
    );
