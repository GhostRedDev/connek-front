// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageDataStruct extends BaseStruct {
  MessageDataStruct({
    String? content,
    String? contentType,
    int? sender,
    int? receiver,
    bool? senderClient,
    bool? senderBot,
    DateTime? createdAt,
  })  : _content = content,
        _contentType = contentType,
        _sender = sender,
        _receiver = receiver,
        _senderClient = senderClient,
        _senderBot = senderBot,
        _createdAt = createdAt;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  // "contentType" field.
  String? _contentType;
  String get contentType => _contentType ?? '';
  set contentType(String? val) => _contentType = val;

  bool hasContentType() => _contentType != null;

  // "sender" field.
  int? _sender;
  int get sender => _sender ?? 0;
  set sender(int? val) => _sender = val;

  void incrementSender(int amount) => sender = sender + amount;

  bool hasSender() => _sender != null;

  // "receiver" field.
  int? _receiver;
  int get receiver => _receiver ?? 0;
  set receiver(int? val) => _receiver = val;

  void incrementReceiver(int amount) => receiver = receiver + amount;

  bool hasReceiver() => _receiver != null;

  // "senderClient" field.
  bool? _senderClient;
  bool get senderClient => _senderClient ?? false;
  set senderClient(bool? val) => _senderClient = val;

  bool hasSenderClient() => _senderClient != null;

  // "senderBot" field.
  bool? _senderBot;
  bool get senderBot => _senderBot ?? false;
  set senderBot(bool? val) => _senderBot = val;

  bool hasSenderBot() => _senderBot != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static MessageDataStruct fromMap(Map<String, dynamic> data) =>
      MessageDataStruct(
        content: data['content'] as String?,
        contentType: data['contentType'] as String?,
        sender: castToType<int>(data['sender']),
        receiver: castToType<int>(data['receiver']),
        senderClient: data['senderClient'] as bool?,
        senderBot: data['senderBot'] as bool?,
        createdAt: data['createdAt'] as DateTime?,
      );

  static MessageDataStruct? maybeFromMap(dynamic data) => data is Map
      ? MessageDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'content': _content,
        'contentType': _contentType,
        'sender': _sender,
        'receiver': _receiver,
        'senderClient': _senderClient,
        'senderBot': _senderBot,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
        'contentType': serializeParam(
          _contentType,
          ParamType.String,
        ),
        'sender': serializeParam(
          _sender,
          ParamType.int,
        ),
        'receiver': serializeParam(
          _receiver,
          ParamType.int,
        ),
        'senderClient': serializeParam(
          _senderClient,
          ParamType.bool,
        ),
        'senderBot': serializeParam(
          _senderBot,
          ParamType.bool,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static MessageDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessageDataStruct(
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
        contentType: deserializeParam(
          data['contentType'],
          ParamType.String,
          false,
        ),
        sender: deserializeParam(
          data['sender'],
          ParamType.int,
          false,
        ),
        receiver: deserializeParam(
          data['receiver'],
          ParamType.int,
          false,
        ),
        senderClient: deserializeParam(
          data['senderClient'],
          ParamType.bool,
          false,
        ),
        senderBot: deserializeParam(
          data['senderBot'],
          ParamType.bool,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'MessageDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MessageDataStruct &&
        content == other.content &&
        contentType == other.contentType &&
        sender == other.sender &&
        receiver == other.receiver &&
        senderClient == other.senderClient &&
        senderBot == other.senderBot &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        content,
        contentType,
        sender,
        receiver,
        senderClient,
        senderBot,
        createdAt
      ]);
}

MessageDataStruct createMessageDataStruct({
  String? content,
  String? contentType,
  int? sender,
  int? receiver,
  bool? senderClient,
  bool? senderBot,
  DateTime? createdAt,
}) =>
    MessageDataStruct(
      content: content,
      contentType: contentType,
      sender: sender,
      receiver: receiver,
      senderClient: senderClient,
      senderBot: senderBot,
      createdAt: createdAt,
    );
