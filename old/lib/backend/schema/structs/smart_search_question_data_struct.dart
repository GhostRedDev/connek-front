// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SmartSearchQuestionDataStruct extends BaseStruct {
  SmartSearchQuestionDataStruct({
    String? question,
    String? type,
    List<String>? options,
  })  : _question = question,
        _type = type,
        _options = options;

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  set question(String? val) => _question = val;

  bool hasQuestion() => _question != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "options" field.
  List<String>? _options;
  List<String> get options => _options ?? const [];
  set options(List<String>? val) => _options = val;

  void updateOptions(Function(List<String>) updateFn) {
    updateFn(_options ??= []);
  }

  bool hasOptions() => _options != null;

  static SmartSearchQuestionDataStruct fromMap(Map<String, dynamic> data) =>
      SmartSearchQuestionDataStruct(
        question: data['question'] as String?,
        type: data['type'] as String?,
        options: getDataList(data['options']),
      );

  static SmartSearchQuestionDataStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? SmartSearchQuestionDataStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'question': _question,
        'type': _type,
        'options': _options,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'question': serializeParam(
          _question,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'options': serializeParam(
          _options,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static SmartSearchQuestionDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SmartSearchQuestionDataStruct(
        question: deserializeParam(
          data['question'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        options: deserializeParam<String>(
          data['options'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'SmartSearchQuestionDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SmartSearchQuestionDataStruct &&
        question == other.question &&
        type == other.type &&
        listEquality.equals(options, other.options);
  }

  @override
  int get hashCode => const ListEquality().hash([question, type, options]);
}

SmartSearchQuestionDataStruct createSmartSearchQuestionDataStruct({
  String? question,
  String? type,
}) =>
    SmartSearchQuestionDataStruct(
      question: question,
      type: type,
    );
