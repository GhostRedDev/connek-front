// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResourceDataStruct extends BaseStruct {
  ResourceDataStruct({
    int? resourceId,
    DateTime? createdAt,
    int? businessId,
    String? name,
    bool? active,
    BusinessOpeningHoursStruct? serviceTime,
    String? resourceType,
    String? profileImage,
  })  : _resourceId = resourceId,
        _createdAt = createdAt,
        _businessId = businessId,
        _name = name,
        _active = active,
        _serviceTime = serviceTime,
        _resourceType = resourceType,
        _profileImage = profileImage;

  // "resourceId" field.
  int? _resourceId;
  int get resourceId => _resourceId ?? 0;
  set resourceId(int? val) => _resourceId = val;

  void incrementResourceId(int amount) => resourceId = resourceId + amount;

  bool hasResourceId() => _resourceId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

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

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  set active(bool? val) => _active = val;

  bool hasActive() => _active != null;

  // "serviceTime" field.
  BusinessOpeningHoursStruct? _serviceTime;
  BusinessOpeningHoursStruct get serviceTime =>
      _serviceTime ?? BusinessOpeningHoursStruct();
  set serviceTime(BusinessOpeningHoursStruct? val) => _serviceTime = val;

  void updateServiceTime(Function(BusinessOpeningHoursStruct) updateFn) {
    updateFn(_serviceTime ??= BusinessOpeningHoursStruct());
  }

  bool hasServiceTime() => _serviceTime != null;

  // "resourceType" field.
  String? _resourceType;
  String get resourceType => _resourceType ?? '';
  set resourceType(String? val) => _resourceType = val;

  bool hasResourceType() => _resourceType != null;

  // "profileImage" field.
  String? _profileImage;
  String get profileImage => _profileImage ?? '';
  set profileImage(String? val) => _profileImage = val;

  bool hasProfileImage() => _profileImage != null;

  static ResourceDataStruct fromMap(Map<String, dynamic> data) =>
      ResourceDataStruct(
        resourceId: castToType<int>(data['resourceId']),
        createdAt: data['createdAt'] as DateTime?,
        businessId: castToType<int>(data['businessId']),
        name: data['name'] as String?,
        active: data['active'] as bool?,
        serviceTime: data['serviceTime'] is BusinessOpeningHoursStruct
            ? data['serviceTime']
            : BusinessOpeningHoursStruct.maybeFromMap(data['serviceTime']),
        resourceType: data['resourceType'] as String?,
        profileImage: data['profileImage'] as String?,
      );

  static ResourceDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ResourceDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'resourceId': _resourceId,
        'createdAt': _createdAt,
        'businessId': _businessId,
        'name': _name,
        'active': _active,
        'serviceTime': _serviceTime?.toMap(),
        'resourceType': _resourceType,
        'profileImage': _profileImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'resourceId': serializeParam(
          _resourceId,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'active': serializeParam(
          _active,
          ParamType.bool,
        ),
        'serviceTime': serializeParam(
          _serviceTime,
          ParamType.DataStruct,
        ),
        'resourceType': serializeParam(
          _resourceType,
          ParamType.String,
        ),
        'profileImage': serializeParam(
          _profileImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static ResourceDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ResourceDataStruct(
        resourceId: deserializeParam(
          data['resourceId'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
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
        active: deserializeParam(
          data['active'],
          ParamType.bool,
          false,
        ),
        serviceTime: deserializeStructParam(
          data['serviceTime'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessOpeningHoursStruct.fromSerializableMap,
        ),
        resourceType: deserializeParam(
          data['resourceType'],
          ParamType.String,
          false,
        ),
        profileImage: deserializeParam(
          data['profileImage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ResourceDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ResourceDataStruct &&
        resourceId == other.resourceId &&
        createdAt == other.createdAt &&
        businessId == other.businessId &&
        name == other.name &&
        active == other.active &&
        serviceTime == other.serviceTime &&
        resourceType == other.resourceType &&
        profileImage == other.profileImage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        resourceId,
        createdAt,
        businessId,
        name,
        active,
        serviceTime,
        resourceType,
        profileImage
      ]);
}

ResourceDataStruct createResourceDataStruct({
  int? resourceId,
  DateTime? createdAt,
  int? businessId,
  String? name,
  bool? active,
  BusinessOpeningHoursStruct? serviceTime,
  String? resourceType,
  String? profileImage,
}) =>
    ResourceDataStruct(
      resourceId: resourceId,
      createdAt: createdAt,
      businessId: businessId,
      name: name,
      active: active,
      serviceTime: serviceTime ?? BusinessOpeningHoursStruct(),
      resourceType: resourceType,
      profileImage: profileImage,
    );
