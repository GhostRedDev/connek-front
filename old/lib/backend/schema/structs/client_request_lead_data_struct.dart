// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientRequestLeadDataStruct extends BaseStruct {
  ClientRequestLeadDataStruct({
    int? id,
    BusinessDataStruct? business,
    List<QuoteDataStruct>? quote,
  })  : _id = id,
        _business = business,
        _quote = quote;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "business" field.
  BusinessDataStruct? _business;
  BusinessDataStruct get business => _business ?? BusinessDataStruct();
  set business(BusinessDataStruct? val) => _business = val;

  void updateBusiness(Function(BusinessDataStruct) updateFn) {
    updateFn(_business ??= BusinessDataStruct());
  }

  bool hasBusiness() => _business != null;

  // "quote" field.
  List<QuoteDataStruct>? _quote;
  List<QuoteDataStruct> get quote => _quote ?? const [];
  set quote(List<QuoteDataStruct>? val) => _quote = val;

  void updateQuote(Function(List<QuoteDataStruct>) updateFn) {
    updateFn(_quote ??= []);
  }

  bool hasQuote() => _quote != null;

  static ClientRequestLeadDataStruct fromMap(Map<String, dynamic> data) =>
      ClientRequestLeadDataStruct(
        id: castToType<int>(data['id']),
        business: data['business'] is BusinessDataStruct
            ? data['business']
            : BusinessDataStruct.maybeFromMap(data['business']),
        quote: getStructList(
          data['quote'],
          QuoteDataStruct.fromMap,
        ),
      );

  static ClientRequestLeadDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientRequestLeadDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'business': _business?.toMap(),
        'quote': _quote?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'business': serializeParam(
          _business,
          ParamType.DataStruct,
        ),
        'quote': serializeParam(
          _quote,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ClientRequestLeadDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClientRequestLeadDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        business: deserializeStructParam(
          data['business'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessDataStruct.fromSerializableMap,
        ),
        quote: deserializeStructParam<QuoteDataStruct>(
          data['quote'],
          ParamType.DataStruct,
          true,
          structBuilder: QuoteDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ClientRequestLeadDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ClientRequestLeadDataStruct &&
        id == other.id &&
        business == other.business &&
        listEquality.equals(quote, other.quote);
  }

  @override
  int get hashCode => const ListEquality().hash([id, business, quote]);
}

ClientRequestLeadDataStruct createClientRequestLeadDataStruct({
  int? id,
  BusinessDataStruct? business,
}) =>
    ClientRequestLeadDataStruct(
      id: id,
      business: business ?? BusinessDataStruct(),
    );
