// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServiceDataStruct extends BaseStruct {
  ServiceDataStruct({
    int? id,
    DateTime? createdAt,
    String? name,
    String? description,
    int? priceLowCents,
    int? priceHighCents,
    String? images,
    int? businessId,
    String? businessName,
    String? serviceCategory,
    String? profileImage,
    int? priceCents,
    int? durationMinutes,
    List<int>? resources,
  })  : _id = id,
        _createdAt = createdAt,
        _name = name,
        _description = description,
        _priceLowCents = priceLowCents,
        _priceHighCents = priceHighCents,
        _images = images,
        _businessId = businessId,
        _businessName = businessName,
        _serviceCategory = serviceCategory,
        _profileImage = profileImage,
        _priceCents = priceCents,
        _durationMinutes = durationMinutes,
        _resources = resources;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "priceLowCents" field.
  int? _priceLowCents;
  int get priceLowCents => _priceLowCents ?? 0;
  set priceLowCents(int? val) => _priceLowCents = val;

  void incrementPriceLowCents(int amount) =>
      priceLowCents = priceLowCents + amount;

  bool hasPriceLowCents() => _priceLowCents != null;

  // "priceHighCents" field.
  int? _priceHighCents;
  int get priceHighCents => _priceHighCents ?? 0;
  set priceHighCents(int? val) => _priceHighCents = val;

  void incrementPriceHighCents(int amount) =>
      priceHighCents = priceHighCents + amount;

  bool hasPriceHighCents() => _priceHighCents != null;

  // "images" field.
  String? _images;
  String get images => _images ?? '';
  set images(String? val) => _images = val;

  bool hasImages() => _images != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "businessName" field.
  String? _businessName;
  String get businessName => _businessName ?? '';
  set businessName(String? val) => _businessName = val;

  bool hasBusinessName() => _businessName != null;

  // "serviceCategory" field.
  String? _serviceCategory;
  String get serviceCategory => _serviceCategory ?? '';
  set serviceCategory(String? val) => _serviceCategory = val;

  bool hasServiceCategory() => _serviceCategory != null;

  // "profileImage" field.
  String? _profileImage;
  String get profileImage => _profileImage ?? '';
  set profileImage(String? val) => _profileImage = val;

  bool hasProfileImage() => _profileImage != null;

  // "priceCents" field.
  int? _priceCents;
  int get priceCents => _priceCents ?? 0;
  set priceCents(int? val) => _priceCents = val;

  void incrementPriceCents(int amount) => priceCents = priceCents + amount;

  bool hasPriceCents() => _priceCents != null;

  // "durationMinutes" field.
  int? _durationMinutes;
  int get durationMinutes => _durationMinutes ?? 0;
  set durationMinutes(int? val) => _durationMinutes = val;

  void incrementDurationMinutes(int amount) =>
      durationMinutes = durationMinutes + amount;

  bool hasDurationMinutes() => _durationMinutes != null;

  // "resources" field.
  List<int>? _resources;
  List<int> get resources => _resources ?? const [];
  set resources(List<int>? val) => _resources = val;

  void updateResources(Function(List<int>) updateFn) {
    updateFn(_resources ??= []);
  }

  bool hasResources() => _resources != null;

  static ServiceDataStruct fromMap(Map<String, dynamic> data) =>
      ServiceDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        priceLowCents: castToType<int>(data['priceLowCents']),
        priceHighCents: castToType<int>(data['priceHighCents']),
        images: data['images'] as String?,
        businessId: castToType<int>(data['businessId']),
        businessName: data['businessName'] as String?,
        serviceCategory: data['serviceCategory'] as String?,
        profileImage: data['profileImage'] as String?,
        priceCents: castToType<int>(data['priceCents']),
        durationMinutes: castToType<int>(data['durationMinutes']),
        resources: getDataList(data['resources']),
      );

  static ServiceDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ServiceDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'name': _name,
        'description': _description,
        'priceLowCents': _priceLowCents,
        'priceHighCents': _priceHighCents,
        'images': _images,
        'businessId': _businessId,
        'businessName': _businessName,
        'serviceCategory': _serviceCategory,
        'profileImage': _profileImage,
        'priceCents': _priceCents,
        'durationMinutes': _durationMinutes,
        'resources': _resources,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'priceLowCents': serializeParam(
          _priceLowCents,
          ParamType.int,
        ),
        'priceHighCents': serializeParam(
          _priceHighCents,
          ParamType.int,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'businessName': serializeParam(
          _businessName,
          ParamType.String,
        ),
        'serviceCategory': serializeParam(
          _serviceCategory,
          ParamType.String,
        ),
        'profileImage': serializeParam(
          _profileImage,
          ParamType.String,
        ),
        'priceCents': serializeParam(
          _priceCents,
          ParamType.int,
        ),
        'durationMinutes': serializeParam(
          _durationMinutes,
          ParamType.int,
        ),
        'resources': serializeParam(
          _resources,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static ServiceDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      ServiceDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        priceLowCents: deserializeParam(
          data['priceLowCents'],
          ParamType.int,
          false,
        ),
        priceHighCents: deserializeParam(
          data['priceHighCents'],
          ParamType.int,
          false,
        ),
        images: deserializeParam(
          data['images'],
          ParamType.String,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        businessName: deserializeParam(
          data['businessName'],
          ParamType.String,
          false,
        ),
        serviceCategory: deserializeParam(
          data['serviceCategory'],
          ParamType.String,
          false,
        ),
        profileImage: deserializeParam(
          data['profileImage'],
          ParamType.String,
          false,
        ),
        priceCents: deserializeParam(
          data['priceCents'],
          ParamType.int,
          false,
        ),
        durationMinutes: deserializeParam(
          data['durationMinutes'],
          ParamType.int,
          false,
        ),
        resources: deserializeParam<int>(
          data['resources'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'ServiceDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ServiceDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        name == other.name &&
        description == other.description &&
        priceLowCents == other.priceLowCents &&
        priceHighCents == other.priceHighCents &&
        images == other.images &&
        businessId == other.businessId &&
        businessName == other.businessName &&
        serviceCategory == other.serviceCategory &&
        profileImage == other.profileImage &&
        priceCents == other.priceCents &&
        durationMinutes == other.durationMinutes &&
        listEquality.equals(resources, other.resources);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        name,
        description,
        priceLowCents,
        priceHighCents,
        images,
        businessId,
        businessName,
        serviceCategory,
        profileImage,
        priceCents,
        durationMinutes,
        resources
      ]);
}

ServiceDataStruct createServiceDataStruct({
  int? id,
  DateTime? createdAt,
  String? name,
  String? description,
  int? priceLowCents,
  int? priceHighCents,
  String? images,
  int? businessId,
  String? businessName,
  String? serviceCategory,
  String? profileImage,
  int? priceCents,
  int? durationMinutes,
}) =>
    ServiceDataStruct(
      id: id,
      createdAt: createdAt,
      name: name,
      description: description,
      priceLowCents: priceLowCents,
      priceHighCents: priceHighCents,
      images: images,
      businessId: businessId,
      businessName: businessName,
      serviceCategory: serviceCategory,
      profileImage: profileImage,
      priceCents: priceCents,
      durationMinutes: durationMinutes,
    );
