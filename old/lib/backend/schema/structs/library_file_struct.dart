// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LibraryFileStruct extends BaseStruct {
  LibraryFileStruct({
    String? name,
    String? filename,
  })  : _name = name,
        _filename = filename;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "filename" field.
  String? _filename;
  String get filename => _filename ?? '';
  set filename(String? val) => _filename = val;

  bool hasFilename() => _filename != null;

  static LibraryFileStruct fromMap(Map<String, dynamic> data) =>
      LibraryFileStruct(
        name: data['name'] as String?,
        filename: data['filename'] as String?,
      );

  static LibraryFileStruct? maybeFromMap(dynamic data) => data is Map
      ? LibraryFileStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'filename': _filename,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'filename': serializeParam(
          _filename,
          ParamType.String,
        ),
      }.withoutNulls;

  static LibraryFileStruct fromSerializableMap(Map<String, dynamic> data) =>
      LibraryFileStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        filename: deserializeParam(
          data['filename'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LibraryFileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LibraryFileStruct &&
        name == other.name &&
        filename == other.filename;
  }

  @override
  int get hashCode => const ListEquality().hash([name, filename]);
}

LibraryFileStruct createLibraryFileStruct({
  String? name,
  String? filename,
}) =>
    LibraryFileStruct(
      name: name,
      filename: filename,
    );
