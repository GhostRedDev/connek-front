import '../database.dart';

class PaymentMethodsTable extends SupabaseTable<PaymentMethodsRow> {
  @override
  String get tableName => 'payment_methods';

  @override
  PaymentMethodsRow createRow(Map<String, dynamic> data) =>
      PaymentMethodsRow(data);
}

class PaymentMethodsRow extends SupabaseDataRow {
  PaymentMethodsRow(super.data);

  @override
  SupabaseTable get table => PaymentMethodsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get paymentMethodId => getField<String>('payment_method_id')!;
  set paymentMethodId(String value) =>
      setField<String>('payment_method_id', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  bool get main => getField<bool>('main')!;
  set main(bool value) => setField<bool>('main', value);

  String? get brand => getField<String>('brand');
  set brand(String? value) => setField<String>('brand', value);

  String? get expMonth => getField<String>('exp_month');
  set expMonth(String? value) => setField<String>('exp_month', value);

  String? get expYear => getField<String>('exp_year');
  set expYear(String? value) => setField<String>('exp_year', value);

  String? get last4 => getField<String>('last4');
  set last4(String? value) => setField<String>('last4', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  bool get defaultMethod => getField<bool>('default_method')!;
  set defaultMethod(bool value) => setField<bool>('default_method', value);
}
