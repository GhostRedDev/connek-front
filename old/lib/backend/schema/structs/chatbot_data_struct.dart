// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatbotDataStruct extends BaseStruct {
  ChatbotDataStruct({
    int? id,
    String? createdAt,
    String? instructions,
    int? businessId,
    String? name,
    int? employeeId,
    bool? status,
    String? assistantId,
  })  : _id = id,
        _createdAt = createdAt,
        _instructions = instructions,
        _businessId = businessId,
        _name = name,
        _employeeId = employeeId,
        _status = status,
        _assistantId = assistantId;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "createdAt" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "instructions" field.
  String? _instructions;
  String get instructions => _instructions ?? '';
  set instructions(String? val) => _instructions = val;

  bool hasInstructions() => _instructions != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "employeeId" field.
  int? _employeeId;
  int get employeeId => _employeeId ?? 0;
  set employeeId(int? val) => _employeeId = val;

  void incrementEmployeeId(int amount) => employeeId = employeeId + amount;

  bool hasEmployeeId() => _employeeId != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  set status(bool? val) => _status = val;

  bool hasStatus() => _status != null;

  // "assistantId" field.
  String? _assistantId;
  String get assistantId => _assistantId ?? '';
  set assistantId(String? val) => _assistantId = val;

  bool hasAssistantId() => _assistantId != null;

  static ChatbotDataStruct fromMap(Map<String, dynamic> data) =>
      ChatbotDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as String?,
        instructions: data['instructions'] as String?,
        businessId: castToType<int>(data['businessId']),
        name: data['name'] as String?,
        employeeId: castToType<int>(data['employeeId']),
        status: data['status'] as bool?,
        assistantId: data['assistantId'] as String?,
      );

  static ChatbotDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatbotDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'instructions': _instructions,
        'businessId': _businessId,
        'name': _name,
        'employeeId': _employeeId,
        'status': _status,
        'assistantId': _assistantId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'instructions': serializeParam(
          _instructions,
          ParamType.String,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'employeeId': serializeParam(
          _employeeId,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.bool,
        ),
        'assistantId': serializeParam(
          _assistantId,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChatbotDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChatbotDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.String,
          false,
        ),
        instructions: deserializeParam(
          data['instructions'],
          ParamType.String,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        employeeId: deserializeParam(
          data['employeeId'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.bool,
          false,
        ),
        assistantId: deserializeParam(
          data['assistantId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ChatbotDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatbotDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        instructions == other.instructions &&
        businessId == other.businessId &&
        name == other.name &&
        employeeId == other.employeeId &&
        status == other.status &&
        assistantId == other.assistantId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        instructions,
        businessId,
        name,
        employeeId,
        status,
        assistantId
      ]);
}

ChatbotDataStruct createChatbotDataStruct({
  int? id,
  String? createdAt,
  String? instructions,
  int? businessId,
  String? name,
  int? employeeId,
  bool? status,
  String? assistantId,
}) =>
    ChatbotDataStruct(
      id: id,
      createdAt: createdAt,
      instructions: instructions,
      businessId: businessId,
      name: name,
      employeeId: employeeId,
      status: status,
      assistantId: assistantId,
    );
