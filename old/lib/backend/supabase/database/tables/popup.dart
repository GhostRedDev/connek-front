import '../database.dart';

class PopupTable extends SupabaseTable<PopupRow> {
  @override
  String get tableName => 'popup';

  @override
  PopupRow createRow(Map<String, dynamic> data) => PopupRow(data);
}

class PopupRow extends SupabaseDataRow {
  PopupRow(super.data);

  @override
  SupabaseTable get table => PopupTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get firstName => getField<String>('first_name');
  set firstName(String? value) => setField<String>('first_name', value);

  String? get lastName => getField<String>('last_name');
  set lastName(String? value) => setField<String>('last_name', value);

  double? get phone => getField<double>('phone');
  set phone(double? value) => setField<double>('phone', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  bool? get hasBusiness => getField<bool>('has_business');
  set hasBusiness(bool? value) => setField<bool>('has_business', value);

  String? get businessName => getField<String>('business_name');
  set businessName(String? value) => setField<String>('business_name', value);

  String? get businessType => getField<String>('business_type');
  set businessType(String? value) => setField<String>('business_type', value);
}
