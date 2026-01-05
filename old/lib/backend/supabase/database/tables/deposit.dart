import '../database.dart';

class DepositTable extends SupabaseTable<DepositRow> {
  @override
  String get tableName => 'deposit';

  @override
  DepositRow createRow(Map<String, dynamic> data) => DepositRow(data);
}

class DepositRow extends SupabaseDataRow {
  DepositRow(super.data);

  @override
  SupabaseTable get table => DepositTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get amountCents => getField<int>('amount_cents')!;
  set amountCents(int value) => setField<int>('amount_cents', value);

  String get currency => getField<String>('currency')!;
  set currency(String value) => setField<String>('currency', value);

  String get category => getField<String>('category')!;
  set category(String value) => setField<String>('category', value);

  int? get paymentMethodId => getField<int>('payment_method_id');
  set paymentMethodId(int? value) => setField<int>('payment_method_id', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  String? get stripePaymentId => getField<String>('stripe_payment_id');
  set stripePaymentId(String? value) =>
      setField<String>('stripe_payment_id', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);
}
