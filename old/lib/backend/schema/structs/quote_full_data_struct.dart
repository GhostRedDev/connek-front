// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuoteFullDataStruct extends BaseStruct {
  QuoteFullDataStruct({
    int? quoteId,
    String? createdAt,
    int? leadId,
    int? serviceId,
    String? description,
    String? status,
    int? amountCents,
    bool? paid,
    String? expiring,
    ClientRequestLeadDataNoQuoteStruct? lead,
    ServiceDataStruct? service,
  })  : _quoteId = quoteId,
        _createdAt = createdAt,
        _leadId = leadId,
        _serviceId = serviceId,
        _description = description,
        _status = status,
        _amountCents = amountCents,
        _paid = paid,
        _expiring = expiring,
        _lead = lead,
        _service = service;

  // "quoteId" field.
  int? _quoteId;
  int get quoteId => _quoteId ?? 0;
  set quoteId(int? val) => _quoteId = val;

  void incrementQuoteId(int amount) => quoteId = quoteId + amount;

  bool hasQuoteId() => _quoteId != null;

  // "createdAt" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "leadId" field.
  int? _leadId;
  int get leadId => _leadId ?? 0;
  set leadId(int? val) => _leadId = val;

  void incrementLeadId(int amount) => leadId = leadId + amount;

  bool hasLeadId() => _leadId != null;

  // "serviceId" field.
  int? _serviceId;
  int get serviceId => _serviceId ?? 0;
  set serviceId(int? val) => _serviceId = val;

  void incrementServiceId(int amount) => serviceId = serviceId + amount;

  bool hasServiceId() => _serviceId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "amountCents" field.
  int? _amountCents;
  int get amountCents => _amountCents ?? 0;
  set amountCents(int? val) => _amountCents = val;

  void incrementAmountCents(int amount) => amountCents = amountCents + amount;

  bool hasAmountCents() => _amountCents != null;

  // "paid" field.
  bool? _paid;
  bool get paid => _paid ?? false;
  set paid(bool? val) => _paid = val;

  bool hasPaid() => _paid != null;

  // "expiring" field.
  String? _expiring;
  String get expiring => _expiring ?? '';
  set expiring(String? val) => _expiring = val;

  bool hasExpiring() => _expiring != null;

  // "lead" field.
  ClientRequestLeadDataNoQuoteStruct? _lead;
  ClientRequestLeadDataNoQuoteStruct get lead =>
      _lead ?? ClientRequestLeadDataNoQuoteStruct();
  set lead(ClientRequestLeadDataNoQuoteStruct? val) => _lead = val;

  void updateLead(Function(ClientRequestLeadDataNoQuoteStruct) updateFn) {
    updateFn(_lead ??= ClientRequestLeadDataNoQuoteStruct());
  }

  bool hasLead() => _lead != null;

  // "service" field.
  ServiceDataStruct? _service;
  ServiceDataStruct get service => _service ?? ServiceDataStruct();
  set service(ServiceDataStruct? val) => _service = val;

  void updateService(Function(ServiceDataStruct) updateFn) {
    updateFn(_service ??= ServiceDataStruct());
  }

  bool hasService() => _service != null;

  static QuoteFullDataStruct fromMap(Map<String, dynamic> data) =>
      QuoteFullDataStruct(
        quoteId: castToType<int>(data['quoteId']),
        createdAt: data['createdAt'] as String?,
        leadId: castToType<int>(data['leadId']),
        serviceId: castToType<int>(data['serviceId']),
        description: data['description'] as String?,
        status: data['status'] as String?,
        amountCents: castToType<int>(data['amountCents']),
        paid: data['paid'] as bool?,
        expiring: data['expiring'] as String?,
        lead: data['lead'] is ClientRequestLeadDataNoQuoteStruct
            ? data['lead']
            : ClientRequestLeadDataNoQuoteStruct.maybeFromMap(data['lead']),
        service: data['service'] is ServiceDataStruct
            ? data['service']
            : ServiceDataStruct.maybeFromMap(data['service']),
      );

  static QuoteFullDataStruct? maybeFromMap(dynamic data) => data is Map
      ? QuoteFullDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'quoteId': _quoteId,
        'createdAt': _createdAt,
        'leadId': _leadId,
        'serviceId': _serviceId,
        'description': _description,
        'status': _status,
        'amountCents': _amountCents,
        'paid': _paid,
        'expiring': _expiring,
        'lead': _lead?.toMap(),
        'service': _service?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'quoteId': serializeParam(
          _quoteId,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'leadId': serializeParam(
          _leadId,
          ParamType.int,
        ),
        'serviceId': serializeParam(
          _serviceId,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'amountCents': serializeParam(
          _amountCents,
          ParamType.int,
        ),
        'paid': serializeParam(
          _paid,
          ParamType.bool,
        ),
        'expiring': serializeParam(
          _expiring,
          ParamType.String,
        ),
        'lead': serializeParam(
          _lead,
          ParamType.DataStruct,
        ),
        'service': serializeParam(
          _service,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static QuoteFullDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuoteFullDataStruct(
        quoteId: deserializeParam(
          data['quoteId'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.String,
          false,
        ),
        leadId: deserializeParam(
          data['leadId'],
          ParamType.int,
          false,
        ),
        serviceId: deserializeParam(
          data['serviceId'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        amountCents: deserializeParam(
          data['amountCents'],
          ParamType.int,
          false,
        ),
        paid: deserializeParam(
          data['paid'],
          ParamType.bool,
          false,
        ),
        expiring: deserializeParam(
          data['expiring'],
          ParamType.String,
          false,
        ),
        lead: deserializeStructParam(
          data['lead'],
          ParamType.DataStruct,
          false,
          structBuilder: ClientRequestLeadDataNoQuoteStruct.fromSerializableMap,
        ),
        service: deserializeStructParam(
          data['service'],
          ParamType.DataStruct,
          false,
          structBuilder: ServiceDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'QuoteFullDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is QuoteFullDataStruct &&
        quoteId == other.quoteId &&
        createdAt == other.createdAt &&
        leadId == other.leadId &&
        serviceId == other.serviceId &&
        description == other.description &&
        status == other.status &&
        amountCents == other.amountCents &&
        paid == other.paid &&
        expiring == other.expiring &&
        lead == other.lead &&
        service == other.service;
  }

  @override
  int get hashCode => const ListEquality().hash([
        quoteId,
        createdAt,
        leadId,
        serviceId,
        description,
        status,
        amountCents,
        paid,
        expiring,
        lead,
        service
      ]);
}

QuoteFullDataStruct createQuoteFullDataStruct({
  int? quoteId,
  String? createdAt,
  int? leadId,
  int? serviceId,
  String? description,
  String? status,
  int? amountCents,
  bool? paid,
  String? expiring,
  ClientRequestLeadDataNoQuoteStruct? lead,
  ServiceDataStruct? service,
}) =>
    QuoteFullDataStruct(
      quoteId: quoteId,
      createdAt: createdAt,
      leadId: leadId,
      serviceId: serviceId,
      description: description,
      status: status,
      amountCents: amountCents,
      paid: paid,
      expiring: expiring,
      lead: lead ?? ClientRequestLeadDataNoQuoteStruct(),
      service: service ?? ServiceDataStruct(),
    );
