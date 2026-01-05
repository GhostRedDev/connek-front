// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SmartSearchCategoriesDataStruct extends BaseStruct {
  SmartSearchCategoriesDataStruct({
    List<String>? categories,
  }) : _categories = categories;

  // "categories" field.
  List<String>? _categories;
  List<String> get categories => _categories ?? const [];
  set categories(List<String>? val) => _categories = val;

  void updateCategories(Function(List<String>) updateFn) {
    updateFn(_categories ??= []);
  }

  bool hasCategories() => _categories != null;

  static SmartSearchCategoriesDataStruct fromMap(Map<String, dynamic> data) =>
      SmartSearchCategoriesDataStruct(
        categories: getDataList(data['categories']),
      );

  static SmartSearchCategoriesDataStruct? maybeFromMap(dynamic data) => data
          is Map
      ? SmartSearchCategoriesDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'categories': _categories,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'categories': serializeParam(
          _categories,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static SmartSearchCategoriesDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SmartSearchCategoriesDataStruct(
        categories: deserializeParam<String>(
          data['categories'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'SmartSearchCategoriesDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SmartSearchCategoriesDataStruct &&
        listEquality.equals(categories, other.categories);
  }

  @override
  int get hashCode => const ListEquality().hash([categories]);
}

SmartSearchCategoriesDataStruct createSmartSearchCategoriesDataStruct() =>
    SmartSearchCategoriesDataStruct();
