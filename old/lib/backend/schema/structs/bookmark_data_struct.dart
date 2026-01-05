// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookmarkDataStruct extends BaseStruct {
  BookmarkDataStruct({
    int? bookmarkId,
    int? clientId,
    int? businessId,
    int? bookBusinessId,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : _bookmarkId = bookmarkId,
        _clientId = clientId,
        _businessId = businessId,
        _bookBusinessId = bookBusinessId,
        _notes = notes,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  // "bookmarkId" field.
  int? _bookmarkId;
  int get bookmarkId => _bookmarkId ?? 0;
  set bookmarkId(int? val) => _bookmarkId = val;

  void incrementBookmarkId(int amount) => bookmarkId = bookmarkId + amount;

  bool hasBookmarkId() => _bookmarkId != null;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "bookBusinessId" field.
  int? _bookBusinessId;
  int get bookBusinessId => _bookBusinessId ?? 0;
  set bookBusinessId(int? val) => _bookBusinessId = val;

  void incrementBookBusinessId(int amount) =>
      bookBusinessId = bookBusinessId + amount;

  bool hasBookBusinessId() => _bookBusinessId != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? val) => _notes = val;

  bool hasNotes() => _notes != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  static BookmarkDataStruct fromMap(Map<String, dynamic> data) =>
      BookmarkDataStruct(
        bookmarkId: castToType<int>(data['bookmarkId']),
        clientId: castToType<int>(data['clientId']),
        businessId: castToType<int>(data['businessId']),
        bookBusinessId: castToType<int>(data['bookBusinessId']),
        notes: data['notes'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
      );

  static BookmarkDataStruct? maybeFromMap(dynamic data) => data is Map
      ? BookmarkDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'bookmarkId': _bookmarkId,
        'clientId': _clientId,
        'businessId': _businessId,
        'bookBusinessId': _bookBusinessId,
        'notes': _notes,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'bookmarkId': serializeParam(
          _bookmarkId,
          ParamType.int,
        ),
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'bookBusinessId': serializeParam(
          _bookBusinessId,
          ParamType.int,
        ),
        'notes': serializeParam(
          _notes,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'updatedAt': serializeParam(
          _updatedAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static BookmarkDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      BookmarkDataStruct(
        bookmarkId: deserializeParam(
          data['bookmarkId'],
          ParamType.int,
          false,
        ),
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        bookBusinessId: deserializeParam(
          data['bookBusinessId'],
          ParamType.int,
          false,
        ),
        notes: deserializeParam(
          data['notes'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        updatedAt: deserializeParam(
          data['updatedAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'BookmarkDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BookmarkDataStruct &&
        bookmarkId == other.bookmarkId &&
        clientId == other.clientId &&
        businessId == other.businessId &&
        bookBusinessId == other.bookBusinessId &&
        notes == other.notes &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        bookmarkId,
        clientId,
        businessId,
        bookBusinessId,
        notes,
        createdAt,
        updatedAt
      ]);
}

BookmarkDataStruct createBookmarkDataStruct({
  int? bookmarkId,
  int? clientId,
  int? businessId,
  int? bookBusinessId,
  String? notes,
  DateTime? createdAt,
  DateTime? updatedAt,
}) =>
    BookmarkDataStruct(
      bookmarkId: bookmarkId,
      clientId: clientId,
      businessId: businessId,
      bookBusinessId: bookBusinessId,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
