// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AccountStruct extends BaseStruct {
  AccountStruct({
    int? clientId,
    bool? isBusiness,
    int? businessId,
    List<BusinessDataMiniStruct>? businesses,
    String? name,
    int? phone,
  })  : _clientId = clientId,
        _isBusiness = isBusiness,
        _businessId = businessId,
        _businesses = businesses,
        _name = name,
        _phone = phone;

  // "clientId" field.
  int? _clientId;
  int get clientId => _clientId ?? 0;
  set clientId(int? val) => _clientId = val;

  void incrementClientId(int amount) => clientId = clientId + amount;

  bool hasClientId() => _clientId != null;

  // "isBusiness" field.
  bool? _isBusiness;
  bool get isBusiness => _isBusiness ?? false;
  set isBusiness(bool? val) => _isBusiness = val;

  bool hasIsBusiness() => _isBusiness != null;

  // "businessId" field.
  int? _businessId;
  int get businessId => _businessId ?? 0;
  set businessId(int? val) => _businessId = val;

  void incrementBusinessId(int amount) => businessId = businessId + amount;

  bool hasBusinessId() => _businessId != null;

  // "businesses" field.
  List<BusinessDataMiniStruct>? _businesses;
  List<BusinessDataMiniStruct> get businesses => _businesses ?? const [];
  set businesses(List<BusinessDataMiniStruct>? val) => _businesses = val;

  void updateBusinesses(Function(List<BusinessDataMiniStruct>) updateFn) {
    updateFn(_businesses ??= []);
  }

  bool hasBusinesses() => _businesses != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "phone" field.
  int? _phone;
  int get phone => _phone ?? 0;
  set phone(int? val) => _phone = val;

  void incrementPhone(int amount) => phone = phone + amount;

  bool hasPhone() => _phone != null;

  static AccountStruct fromMap(Map<String, dynamic> data) => AccountStruct(
        clientId: castToType<int>(data['clientId']),
        isBusiness: data['isBusiness'] as bool?,
        businessId: castToType<int>(data['businessId']),
        businesses: getStructList(
          data['businesses'],
          BusinessDataMiniStruct.fromMap,
        ),
        name: data['name'] as String?,
        phone: castToType<int>(data['phone']),
      );

  static AccountStruct? maybeFromMap(dynamic data) =>
      data is Map ? AccountStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'clientId': _clientId,
        'isBusiness': _isBusiness,
        'businessId': _businessId,
        'businesses': _businesses?.map((e) => e.toMap()).toList(),
        'name': _name,
        'phone': _phone,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'clientId': serializeParam(
          _clientId,
          ParamType.int,
        ),
        'isBusiness': serializeParam(
          _isBusiness,
          ParamType.bool,
        ),
        'businessId': serializeParam(
          _businessId,
          ParamType.int,
        ),
        'businesses': serializeParam(
          _businesses,
          ParamType.DataStruct,
          isList: true,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.int,
        ),
      }.withoutNulls;

  static AccountStruct fromSerializableMap(Map<String, dynamic> data) =>
      AccountStruct(
        clientId: deserializeParam(
          data['clientId'],
          ParamType.int,
          false,
        ),
        isBusiness: deserializeParam(
          data['isBusiness'],
          ParamType.bool,
          false,
        ),
        businessId: deserializeParam(
          data['businessId'],
          ParamType.int,
          false,
        ),
        businesses: deserializeStructParam<BusinessDataMiniStruct>(
          data['businesses'],
          ParamType.DataStruct,
          true,
          structBuilder: BusinessDataMiniStruct.fromSerializableMap,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'AccountStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AccountStruct &&
        clientId == other.clientId &&
        isBusiness == other.isBusiness &&
        businessId == other.businessId &&
        listEquality.equals(businesses, other.businesses) &&
        name == other.name &&
        phone == other.phone;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([clientId, isBusiness, businessId, businesses, name, phone]);
}

AccountStruct createAccountStruct({
  int? clientId,
  bool? isBusiness,
  int? businessId,
  String? name,
  int? phone,
}) =>
    AccountStruct(
      clientId: clientId,
      isBusiness: isBusiness,
      businessId: businessId,
      name: name,
      phone: phone,
    );
