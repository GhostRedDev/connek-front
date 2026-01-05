// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatSessionStruct extends BaseStruct {
  ChatSessionStruct({
    int? clientId,
  }) : _clientId = clientId;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  static ChatSessionStruct fromMap(Map<String, dynamic> data) =>
      ChatSessionStruct(
        clientId: castToType<int>(data['clientId']),
      );

  static ChatSessionStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatSessionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'clientId': _clientId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
      }.withoutNulls;

  static ChatSessionStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChatSessionStruct(
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ChatSessionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatSessionStruct && clientId == other.clientId;
  }

  @override
  int get hashCode => const ListEquality().hash([clientId]);
}

ChatSessionStruct createChatSessionStruct({
  int? clientId,
}) =>
    ChatSessionStruct(
      clientId: clientId,
    );
