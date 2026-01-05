// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AddedServiceStruct extends BaseStruct {
  AddedServiceStruct({
    String? name,
    String? description,
    int? priceLowCents,
    int? priceHighCents,
    String? category,
    String? profileImage,
    List<String>? images,
    int? priceCents,
  })  : _name = name,
        _description = description,
        _priceLowCents = priceLowCents,
        _priceHighCents = priceHighCents,
        _category = category,
        _profileImage = profileImage,
        _images = images,
        _priceCents = priceCents;

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

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "profileImage" field.
  String? _profileImage;
  String get profileImage => _profileImage ?? '';
  set profileImage(String? val) => _profileImage = val;

  bool hasProfileImage() => _profileImage != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  set images(List<String>? val) => _images = val;

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  // "priceCents" field.
  int? _priceCents;
  int get priceCents => _priceCents ?? 0;
  set priceCents(int? val) => _priceCents = val;

  void incrementPriceCents(int amount) => priceCents = priceCents + amount;

  bool hasPriceCents() => _priceCents != null;

  static AddedServiceStruct fromMap(Map<String, dynamic> data) =>
      AddedServiceStruct(
        name: data['name'] as String?,
        description: data['description'] as String?,
        priceLowCents: castToType<int>(data['priceLowCents']),
        priceHighCents: castToType<int>(data['priceHighCents']),
        category: data['category'] as String?,
        profileImage: data['profileImage'] as String?,
        images: getDataList(data['images']),
        priceCents: castToType<int>(data['priceCents']),
      );

  static AddedServiceStruct? maybeFromMap(dynamic data) => data is Map
      ? AddedServiceStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'description': _description,
        'priceLowCents': _priceLowCents,
        'priceHighCents': _priceHighCents,
        'category': _category,
        'profileImage': _profileImage,
        'images': _images,
        'priceCents': _priceCents,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
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
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'profileImage': serializeParam(
          _profileImage,
          ParamType.String,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
        'priceCents': serializeParam(
          _priceCents,
          ParamType.int,
        ),
      }.withoutNulls;

  static AddedServiceStruct fromSerializableMap(Map<String, dynamic> data) =>
      AddedServiceStruct(
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
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        profileImage: deserializeParam(
          data['profileImage'],
          ParamType.String,
          false,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
        ),
        priceCents: deserializeParam(
          data['priceCents'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'AddedServiceStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AddedServiceStruct &&
        name == other.name &&
        description == other.description &&
        priceLowCents == other.priceLowCents &&
        priceHighCents == other.priceHighCents &&
        category == other.category &&
        profileImage == other.profileImage &&
        listEquality.equals(images, other.images) &&
        priceCents == other.priceCents;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        description,
        priceLowCents,
        priceHighCents,
        category,
        profileImage,
        images,
        priceCents
      ]);
}

AddedServiceStruct createAddedServiceStruct({
  String? name,
  String? description,
  int? priceLowCents,
  int? priceHighCents,
  String? category,
  String? profileImage,
  int? priceCents,
}) =>
    AddedServiceStruct(
      name: name,
      description: description,
      priceLowCents: priceLowCents,
      priceHighCents: priceHighCents,
      category: category,
      profileImage: profileImage,
      priceCents: priceCents,
    );
