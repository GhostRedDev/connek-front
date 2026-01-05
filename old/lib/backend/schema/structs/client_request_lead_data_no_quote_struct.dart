// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientRequestLeadDataNoQuoteStruct extends BaseStruct {
  ClientRequestLeadDataNoQuoteStruct({
    int? leadId,
    BusinessDataStruct? business,
  })  : _leadId = leadId,
        _business = business;

  // "leadId" field.
  int? _leadId;
  int get leadId => _leadId ?? 0;
  set leadId(int? val) => _leadId = val;

  void incrementLeadId(int amount) => leadId = leadId + amount;

  bool hasLeadId() => _leadId != null;

  // "business" field.
  BusinessDataStruct? _business;
  BusinessDataStruct get business => _business ?? BusinessDataStruct();
  set business(BusinessDataStruct? val) => _business = val;

  void updateBusiness(Function(BusinessDataStruct) updateFn) {
    updateFn(_business ??= BusinessDataStruct());
  }

  bool hasBusiness() => _business != null;

  static ClientRequestLeadDataNoQuoteStruct fromMap(
          Map<String, dynamic> data) =>
      ClientRequestLeadDataNoQuoteStruct(
        leadId: castToType<int>(data['leadId']),
        business: data['business'] is BusinessDataStruct
            ? data['business']
            : BusinessDataStruct.maybeFromMap(data['business']),
      );

  static ClientRequestLeadDataNoQuoteStruct? maybeFromMap(dynamic data) => data
          is Map
      ? ClientRequestLeadDataNoQuoteStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'leadId': _leadId,
        'business': _business?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'leadId': serializeParam(
          _leadId,
          ParamType.int,
        ),
        'business': serializeParam(
          _business,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ClientRequestLeadDataNoQuoteStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClientRequestLeadDataNoQuoteStruct(
        leadId: deserializeParam(
          data['leadId'],
          ParamType.int,
          false,
        ),
        business: deserializeStructParam(
          data['business'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ClientRequestLeadDataNoQuoteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientRequestLeadDataNoQuoteStruct &&
        leadId == other.leadId &&
        business == other.business;
  }

  @override
  int get hashCode => const ListEquality().hash([leadId, business]);
}

ClientRequestLeadDataNoQuoteStruct createClientRequestLeadDataNoQuoteStruct({
  int? leadId,
  BusinessDataStruct? business,
}) =>
    ClientRequestLeadDataNoQuoteStruct(
      leadId: leadId,
      business: business ?? BusinessDataStruct(),
    );
