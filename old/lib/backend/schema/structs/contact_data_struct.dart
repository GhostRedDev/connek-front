// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactDataStruct extends BaseStruct {
  ContactDataStruct({
    int? id,
    YouContactStruct? you,
    ContactStruct? contact,
    MessageDataStruct? lastMessage,
  })  : _id = id,
        _you = you,
        _contact = contact,
        _lastMessage = lastMessage;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "you" field.
  YouContactStruct? _you;
  YouContactStruct get you => _you ?? YouContactStruct();
  set you(YouContactStruct? val) => _you = val;

  void updateYou(Function(YouContactStruct) updateFn) {
    updateFn(_you ??= YouContactStruct());
  }

  bool hasYou() => _you != null;

  // "contact" field.
  ContactStruct? _contact;
  ContactStruct get contact => _contact ?? ContactStruct();
  set contact(ContactStruct? val) => _contact = val;

  void updateContact(Function(ContactStruct) updateFn) {
    updateFn(_contact ??= ContactStruct());
  }

  bool hasContact() => _contact != null;

  // "lastMessage" field.
  MessageDataStruct? _lastMessage;
  MessageDataStruct get lastMessage => _lastMessage ?? MessageDataStruct();
  set lastMessage(MessageDataStruct? val) => _lastMessage = val;

  void updateLastMessage(Function(MessageDataStruct) updateFn) {
    updateFn(_lastMessage ??= MessageDataStruct());
  }

  bool hasLastMessage() => _lastMessage != null;

  static ContactDataStruct fromMap(Map<String, dynamic> data) =>
      ContactDataStruct(
        id: castToType<int>(data['id']),
        you: data['you'] is YouContactStruct
            ? data['you']
            : YouContactStruct.maybeFromMap(data['you']),
        contact: data['contact'] is ContactStruct
            ? data['contact']
            : ContactStruct.maybeFromMap(data['contact']),
        lastMessage: data['lastMessage'] is MessageDataStruct
            ? data['lastMessage']
            : MessageDataStruct.maybeFromMap(data['lastMessage']),
      );

  static ContactDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ContactDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'you': _you?.toMap(),
        'contact': _contact?.toMap(),
        'lastMessage': _lastMessage?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'you': serializeParam(
          _you,
          ParamType.DataStruct,
        ),
        'contact': serializeParam(
          _contact,
          ParamType.DataStruct,
        ),
        'lastMessage': serializeParam(
          _lastMessage,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ContactDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContactDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        you: deserializeStructParam(
          data['you'],
          ParamType.DataStruct,
          false,
          structBuilder: YouContactStruct.fromSerializableMap,
        ),
        contact: deserializeStructParam(
          data['contact'],
          ParamType.DataStruct,
          false,
          structBuilder: ContactStruct.fromSerializableMap,
        ),
        lastMessage: deserializeStructParam(
          data['lastMessage'],
          ParamType.DataStruct,
          false,
          structBuilder: MessageDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ContactDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContactDataStruct &&
        id == other.id &&
        you == other.you &&
        contact == other.contact &&
        lastMessage == other.lastMessage;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, you, contact, lastMessage]);
}

ContactDataStruct createContactDataStruct({
  int? id,
  YouContactStruct? you,
  ContactStruct? contact,
  MessageDataStruct? lastMessage,
}) =>
    ContactDataStruct(
      id: id,
      you: you ?? YouContactStruct(),
      contact: contact ?? ContactStruct(),
      lastMessage: lastMessage ?? MessageDataStruct(),
    );
