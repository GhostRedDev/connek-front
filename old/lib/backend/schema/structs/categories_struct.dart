// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CategoriesStruct extends BaseStruct {
  CategoriesStruct({
    List<String>? categoryname,
  }) : _categoryname = categoryname;

  // "categoryname" field.
  List<String>? _categoryname;
  List<String> get categoryname => _categoryname ?? const [];
  set categoryname(List<String>? val) => _categoryname = val;

  void updateCategoryname(Function(List<String>) updateFn) {
    updateFn(_categoryname ??= []);
  }

  bool hasCategoryname() => _categoryname != null;

  static CategoriesStruct fromMap(Map<String, dynamic> data) =>
      CategoriesStruct(
        categoryname: getDataList(data['categoryname']),
      );

  static CategoriesStruct? maybeFromMap(dynamic data) => data is Map
      ? CategoriesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'categoryname': _categoryname,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'categoryname': serializeParam(
          _categoryname,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static CategoriesStruct fromSerializableMap(Map<String, dynamic> data) =>
      CategoriesStruct(
        categoryname: deserializeParam<String>(
          data['categoryname'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'CategoriesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CategoriesStruct &&
        listEquality.equals(categoryname, other.categoryname);
  }

  @override
  int get hashCode => const ListEquality().hash([categoryname]);
}

CategoriesStruct createCategoriesStruct() => CategoriesStruct();
