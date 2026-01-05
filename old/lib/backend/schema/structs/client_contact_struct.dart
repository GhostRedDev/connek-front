// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientContactStruct extends BaseStruct {
  ClientContactStruct({
    int? conversationId,
    int? clientId,
    String? firstName,
    String? lastName,
    String? photoId,
    String? businessName,
    int? businessId,
    String? businessPhoto,
    bool? youIsBusiness,
    bool? isBusiness,
    String? lastMessage,
  })  : _conversationId = conversationId,
        _clientId = clientId,
        _firstName = firstName,
        _lastName = lastName,
        _photoId = photoId,
        _businessName = businessName,
        _businessId = businessId,
        _businessPhoto = businessPhoto,
        _youIsBusiness = youIsBusiness,
        _isBusiness = isBusiness,
        _lastMessage = lastMessage;

  // "conversationId" field.
  int? _conversationId;
  int get conversationId => _conversationId ?? 0;
  set conversationId(int? val) => _conversationId = val;

  void incrementConversationId(int amount) =>
      conversationId = conversationId + amount;

  bool hasConversationId() => _conversationId != null;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "firstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) => _firstName = val;

  bool hasFirstName() => _firstName != null;

  // "lastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  // "photoId" field.
  String? _photoId;
  String get photoId => _photoId ?? '';
  set photoId(String? val) => _photoId = val;

  bool hasPhotoId() => _photoId != null;

  // "businessName" field.
  String? _businessName;
  String get businessName => _businessName ?? '';
  set businessName(String? val) => _businessName = val;

  bool hasBusinessName() => _businessName != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "businessPhoto" field.
  String? _businessPhoto;
  String get businessPhoto => _businessPhoto ?? '';
  set businessPhoto(String? val) => _businessPhoto = val;

  bool hasBusinessPhoto() => _businessPhoto != null;

  // "youIsBusiness" field.
  bool? _youIsBusiness;
  bool get youIsBusiness => _youIsBusiness ?? false;
  set youIsBusiness(bool? val) => _youIsBusiness = val;

  bool hasYouIsBusiness() => _youIsBusiness != null;

  // "isBusiness" field.
  bool? _isBusiness;
  bool get isBusiness => _isBusiness ?? false;
  set isBusiness(bool? val) => _isBusiness = val;

  bool hasIsBusiness() => _isBusiness != null;

  // "lastMessage" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  set lastMessage(String? val) => _lastMessage = val;

  bool hasLastMessage() => _lastMessage != null;

  static ClientContactStruct fromMap(Map<String, dynamic> data) =>
      ClientContactStruct(
        conversationId: castToType<int>(data['conversationId']),
        clientId: castToType<int>(data['clientId']),
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        photoId: data['photoId'] as String?,
        businessName: data['businessName'] as String?,
        businessId: castToType<int>(data['businessId']),
        businessPhoto: data['businessPhoto'] as String?,
        youIsBusiness: data['youIsBusiness'] as bool?,
        isBusiness: data['isBusiness'] as bool?,
        lastMessage: data['lastMessage'] as String?,
      );

  static ClientContactStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientContactStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'conversationId': _conversationId,
        'clientId': _clientId,
        'firstName': _firstName,
        'lastName': _lastName,
        'photoId': _photoId,
        'businessName': _businessName,
        'businessId': _businessId,
        'businessPhoto': _businessPhoto,
        'youIsBusiness': _youIsBusiness,
        'isBusiness': _isBusiness,
        'lastMessage': _lastMessage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'conversationId': serializeParam(
          _conversationId,
          ParamType.int,
        ),
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'firstName': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'lastName': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'photoId': serializeParam(
          _photoId,
          ParamType.String,
        ),
        'businessName': serializeParam(
          _businessName,
          ParamType.String,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'businessPhoto': serializeParam(
          _businessPhoto,
          ParamType.String,
        ),
        'youIsBusiness': serializeParam(
          _youIsBusiness,
          ParamType.bool,
        ),
        'isBusiness': serializeParam(
          _isBusiness,
          ParamType.bool,
        ),
        'lastMessage': serializeParam(
          _lastMessage,
          ParamType.String,
        ),
      }.withoutNulls;

  static ClientContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClientContactStruct(
        conversationId: deserializeParam(
          data['conversationId'],
          ParamType.int,
          false,
        ),
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        firstName: deserializeParam(
          data['firstName'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['lastName'],
          ParamType.String,
          false,
        ),
        photoId: deserializeParam(
          data['photoId'],
          ParamType.String,
          false,
        ),
        businessName: deserializeParam(
          data['businessName'],
          ParamType.String,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        businessPhoto: deserializeParam(
          data['businessPhoto'],
          ParamType.String,
          false,
        ),
        youIsBusiness: deserializeParam(
          data['youIsBusiness'],
          ParamType.bool,
          false,
        ),
        isBusiness: deserializeParam(
          data['isBusiness'],
          ParamType.bool,
          false,
        ),
        lastMessage: deserializeParam(
          data['lastMessage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ClientContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientContactStruct &&
        conversationId == other.conversationId &&
        clientId == other.clientId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        photoId == other.photoId &&
        businessName == other.businessName &&
        businessId == other.businessId &&
        businessPhoto == other.businessPhoto &&
        youIsBusiness == other.youIsBusiness &&
        isBusiness == other.isBusiness &&
        lastMessage == other.lastMessage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        conversationId,
        clientId,
        firstName,
        lastName,
        photoId,
        businessName,
        businessId,
        businessPhoto,
        youIsBusiness,
        isBusiness,
        lastMessage
      ]);
}

ClientContactStruct createClientContactStruct({
  int? conversationId,
  int? clientId,
  String? firstName,
  String? lastName,
  String? photoId,
  String? businessName,
  int? businessId,
  String? businessPhoto,
  bool? youIsBusiness,
  bool? isBusiness,
  String? lastMessage,
}) =>
    ClientContactStruct(
      conversationId: conversationId,
      clientId: clientId,
      firstName: firstName,
      lastName: lastName,
      photoId: photoId,
      businessName: businessName,
      businessId: businessId,
      businessPhoto: businessPhoto,
      youIsBusiness: youIsBusiness,
      isBusiness: isBusiness,
      lastMessage: lastMessage,
    );
