// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SmartSearchResponsesDataStruct extends BaseStruct {
  SmartSearchResponsesDataStruct({
    String? question,
    String? response,
  })  : _question = question,
        _response = response;

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  set question(String? val) => _question = val;

  bool hasQuestion() => _question != null;

  // "response" field.
  String? _response;
  String get response => _response ?? '';
  set response(String? val) => _response = val;

  bool hasResponse() => _response != null;

  static SmartSearchResponsesDataStruct fromMap(Map<String, dynamic> data) =>
      SmartSearchResponsesDataStruct(
        question: data['question'] as String?,
        response: data['response'] as String?,
      );

  static SmartSearchResponsesDataStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? SmartSearchResponsesDataStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'question': _question,
        'response': _response,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'question': serializeParam(
          _question,
          ParamType.String,
        ),
        'response': serializeParam(
          _response,
          ParamType.String,
        ),
      }.withoutNulls;

  static SmartSearchResponsesDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SmartSearchResponsesDataStruct(
        question: deserializeParam(
          data['question'],
          ParamType.String,
          false,
        ),
        response: deserializeParam(
          data['response'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SmartSearchResponsesDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SmartSearchResponsesDataStruct &&
        question == other.question &&
        response == other.response;
  }

  @override
  int get hashCode => const ListEquality().hash([question, response]);
}

SmartSearchResponsesDataStruct createSmartSearchResponsesDataStruct({
  String? question,
  String? response,
}) =>
    SmartSearchResponsesDataStruct(
      question: question,
      response: response,
    );
