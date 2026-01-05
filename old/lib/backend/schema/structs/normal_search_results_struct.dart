// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NormalSearchResultsStruct extends BaseStruct {
  NormalSearchResultsStruct({
    List<ServiceDataStruct>? services,
    List<BusinessDataStruct>? businesses,
  })  : _services = services,
        _businesses = businesses;

  // "services" field.
  List<ServiceDataStruct>? _services;
  List<ServiceDataStruct> get services => _services ?? const [];
  set services(List<ServiceDataStruct>? val) => _services = val;

  void updateServices(Function(List<ServiceDataStruct>) updateFn) {
    updateFn(_services ??= []);
  }

  bool hasServices() => _services != null;

  // "businesses" field.
  List<BusinessDataStruct>? _businesses;
  List<BusinessDataStruct> get businesses => _businesses ?? const [];
  set businesses(List<BusinessDataStruct>? val) => _businesses = val;

  void updateBusinesses(Function(List<BusinessDataStruct>) updateFn) {
    updateFn(_businesses ??= []);
  }

  bool hasBusinesses() => _businesses != null;

  static NormalSearchResultsStruct fromMap(Map<String, dynamic> data) =>
      NormalSearchResultsStruct(
        services: getStructList(
          data['services'],
          ServiceDataStruct.fromMap,
        ),
        businesses: getStructList(
          data['businesses'],
          BusinessDataStruct.fromMap,
        ),
      );

  static NormalSearchResultsStruct? maybeFromMap(dynamic data) => data is Map
      ? NormalSearchResultsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'services': _services?.map((e) => e.toMap()).toList(),
        'businesses': _businesses?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'services': serializeParam(
          _services,
          ParamType.DataStruct,
          isList: true,
        ),
        'businesses': serializeParam(
          _businesses,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static NormalSearchResultsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NormalSearchResultsStruct(
        services: deserializeStructParam<ServiceDataStruct>(
          data['services'],
          ParamType.DataStruct,
          true,
          structBuilder: ServiceDataStruct.fromSerializableMap,
        ),
        businesses: deserializeStructParam<BusinessDataStruct>(
          data['businesses'],
          ParamType.DataStruct,
          true,
          structBuilder: BusinessDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'NormalSearchResultsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NormalSearchResultsStruct &&
        listEquality.equals(services, other.services) &&
        listEquality.equals(businesses, other.businesses);
  }

  @override
  int get hashCode => const ListEquality().hash([services, businesses]);
}

NormalSearchResultsStruct createNormalSearchResultsStruct() =>
    NormalSearchResultsStruct();
