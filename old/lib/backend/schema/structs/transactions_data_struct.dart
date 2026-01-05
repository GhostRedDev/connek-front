// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionsDataStruct extends BaseStruct {
  TransactionsDataStruct({
    int? id,
    DateTime? createdAt,
    int? sender,
    int? receiver,
    int? senderBusiness,
    int? receiverBusiness,
    int? amountCents,
    String? currency,
    String? category,
    String? stripePaymentId,
    int? paymentMethodId,
    String? description,
    String? title,
  })  : _id = id,
        _createdAt = createdAt,
        _sender = sender,
        _receiver = receiver,
        _senderBusiness = senderBusiness,
        _receiverBusiness = receiverBusiness,
        _amountCents = amountCents,
        _currency = currency,
        _category = category,
        _stripePaymentId = stripePaymentId,
        _paymentMethodId = paymentMethodId,
        _description = description,
        _title = title;

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

  // "sender" field.
  int? _sender;
  int get sender => _sender ?? 0;
  set sender(int? val) => _sender = val;

  void incrementSender(int amount) => sender = sender + amount;

  bool hasSender() => _sender != null;

  // "receiver" field.
  int? _receiver;
  int get receiver => _receiver ?? 0;
  set receiver(int? val) => _receiver = val;

  void incrementReceiver(int amount) => receiver = receiver + amount;

  bool hasReceiver() => _receiver != null;

  // "senderBusiness" field.
  int? _senderBusiness;
  int get senderBusiness => _senderBusiness ?? 0;
  set senderBusiness(int? val) => _senderBusiness = val;

  void incrementSenderBusiness(int amount) =>
      senderBusiness = senderBusiness + amount;

  bool hasSenderBusiness() => _senderBusiness != null;

  // "receiverBusiness" field.
  int? _receiverBusiness;
  int get receiverBusiness => _receiverBusiness ?? 0;
  set receiverBusiness(int? val) => _receiverBusiness = val;

  void incrementReceiverBusiness(int amount) =>
      receiverBusiness = receiverBusiness + amount;

  bool hasReceiverBusiness() => _receiverBusiness != null;

  // "amountCents" field.
  int? _amountCents;
  int get amountCents => _amountCents ?? 0;
  set amountCents(int? val) => _amountCents = val;

  void incrementAmountCents(int amount) => amountCents = amountCents + amount;

  bool hasAmountCents() => _amountCents != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  set currency(String? val) => _currency = val;

  bool hasCurrency() => _currency != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "stripePaymentId" field.
  String? _stripePaymentId;
  String get stripePaymentId => _stripePaymentId ?? '';
  set stripePaymentId(String? val) => _stripePaymentId = val;

  bool hasStripePaymentId() => _stripePaymentId != null;

  // "paymentMethodId" field.
  int? _paymentMethodId;
  int get paymentMethodId => _paymentMethodId ?? 0;
  set paymentMethodId(int? val) => _paymentMethodId = val;

  void incrementPaymentMethodId(int amount) =>
      paymentMethodId = paymentMethodId + amount;

  bool hasPaymentMethodId() => _paymentMethodId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  static TransactionsDataStruct fromMap(Map<String, dynamic> data) =>
      TransactionsDataStruct(
        id: castToType<int>(data['id']),
        createdAt: data['createdAt'] as DateTime?,
        sender: castToType<int>(data['sender']),
        receiver: castToType<int>(data['receiver']),
        senderBusiness: castToType<int>(data['senderBusiness']),
        receiverBusiness: castToType<int>(data['receiverBusiness']),
        amountCents: castToType<int>(data['amountCents']),
        currency: data['currency'] as String?,
        category: data['category'] as String?,
        stripePaymentId: data['stripePaymentId'] as String?,
        paymentMethodId: castToType<int>(data['paymentMethodId']),
        description: data['description'] as String?,
        title: data['title'] as String?,
      );

  static TransactionsDataStruct? maybeFromMap(dynamic data) => data is Map
      ? TransactionsDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'createdAt': _createdAt,
        'sender': _sender,
        'receiver': _receiver,
        'senderBusiness': _senderBusiness,
        'receiverBusiness': _receiverBusiness,
        'amountCents': _amountCents,
        'currency': _currency,
        'category': _category,
        'stripePaymentId': _stripePaymentId,
        'paymentMethodId': _paymentMethodId,
        'description': _description,
        'title': _title,
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
        'sender': serializeParam(
          _sender,
          ParamType.int,
        ),
        'receiver': serializeParam(
          _receiver,
          ParamType.int,
        ),
        'senderBusiness': serializeParam(
          _senderBusiness,
          ParamType.int,
        ),
        'receiverBusiness': serializeParam(
          _receiverBusiness,
          ParamType.int,
        ),
        'amountCents': serializeParam(
          _amountCents,
          ParamType.int,
        ),
        'currency': serializeParam(
          _currency,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'stripePaymentId': serializeParam(
          _stripePaymentId,
          ParamType.String,
        ),
        'paymentMethodId': serializeParam(
          _paymentMethodId,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
      }.withoutNulls;

  static TransactionsDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TransactionsDataStruct(
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
        sender: deserializeParam(
          data['sender'],
          ParamType.int,
          false,
        ),
        receiver: deserializeParam(
          data['receiver'],
          ParamType.int,
          false,
        ),
        senderBusiness: deserializeParam(
          data['senderBusiness'],
          ParamType.int,
          false,
        ),
        receiverBusiness: deserializeParam(
          data['receiverBusiness'],
          ParamType.int,
          false,
        ),
        amountCents: deserializeParam(
          data['amountCents'],
          ParamType.int,
          false,
        ),
        currency: deserializeParam(
          data['currency'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        stripePaymentId: deserializeParam(
          data['stripePaymentId'],
          ParamType.String,
          false,
        ),
        paymentMethodId: deserializeParam(
          data['paymentMethodId'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TransactionsDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TransactionsDataStruct &&
        id == other.id &&
        createdAt == other.createdAt &&
        sender == other.sender &&
        receiver == other.receiver &&
        senderBusiness == other.senderBusiness &&
        receiverBusiness == other.receiverBusiness &&
        amountCents == other.amountCents &&
        currency == other.currency &&
        category == other.category &&
        stripePaymentId == other.stripePaymentId &&
        paymentMethodId == other.paymentMethodId &&
        description == other.description &&
        title == other.title;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        createdAt,
        sender,
        receiver,
        senderBusiness,
        receiverBusiness,
        amountCents,
        currency,
        category,
        stripePaymentId,
        paymentMethodId,
        description,
        title
      ]);
}

TransactionsDataStruct createTransactionsDataStruct({
  int? id,
  DateTime? createdAt,
  int? sender,
  int? receiver,
  int? senderBusiness,
  int? receiverBusiness,
  int? amountCents,
  String? currency,
  String? category,
  String? stripePaymentId,
  int? paymentMethodId,
  String? description,
  String? title,
}) =>
    TransactionsDataStruct(
      id: id,
      createdAt: createdAt,
      sender: sender,
      receiver: receiver,
      senderBusiness: senderBusiness,
      receiverBusiness: receiverBusiness,
      amountCents: amountCents,
      currency: currency,
      category: category,
      stripePaymentId: stripePaymentId,
      paymentMethodId: paymentMethodId,
      description: description,
      title: title,
    );
