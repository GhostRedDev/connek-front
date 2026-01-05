import '../database.dart';

class TransactionsTable extends SupabaseTable<TransactionsRow> {
  @override
  String get tableName => 'transactions';

  @override
  TransactionsRow createRow(Map<String, dynamic> data) => TransactionsRow(data);
}

class TransactionsRow extends SupabaseDataRow {
  TransactionsRow(super.data);

  @override
  SupabaseTable get table => TransactionsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get sender => getField<int>('sender')!;
  set sender(int value) => setField<int>('sender', value);

  int get receiver => getField<int>('receiver')!;
  set receiver(int value) => setField<int>('receiver', value);

  int get amountCents => getField<int>('amount_cents')!;
  set amountCents(int value) => setField<int>('amount_cents', value);

  String get currency => getField<String>('currency')!;
  set currency(String value) => setField<String>('currency', value);

  String get category => getField<String>('category')!;
  set category(String value) => setField<String>('category', value);

  String get stripePaymentId => getField<String>('stripe_payment_id')!;
  set stripePaymentId(String value) =>
      setField<String>('stripe_payment_id', value);

  int get paymentMethod => getField<int>('payment_method')!;
  set paymentMethod(int value) => setField<int>('payment_method', value);

  String get description => getField<String>('description')!;
  set description(String value) => setField<String>('description', value);

  int? get senderBusiness => getField<int>('sender_business');
  set senderBusiness(int? value) => setField<int>('sender_business', value);

  int? get receiverBusiness => getField<int>('receiver_business');
  set receiverBusiness(int? value) => setField<int>('receiver_business', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);
}
