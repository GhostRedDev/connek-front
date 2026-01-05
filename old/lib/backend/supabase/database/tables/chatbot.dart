import '../database.dart';

class ChatbotTable extends SupabaseTable<ChatbotRow> {
  @override
  String get tableName => 'chatbot';

  @override
  ChatbotRow createRow(Map<String, dynamic> data) => ChatbotRow(data);
}

class ChatbotRow extends SupabaseDataRow {
  ChatbotRow(super.data);

  @override
  SupabaseTable get table => ChatbotTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get assistantId => getField<String>('assistant_id')!;
  set assistantId(String value) => setField<String>('assistant_id', value);

  String? get instructions => getField<String>('instructions');
  set instructions(String? value) => setField<String>('instructions', value);

  int? get businessId => getField<int>('business_id');
  set businessId(int? value) => setField<int>('business_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  int get employeeId => getField<int>('employee_id')!;
  set employeeId(int value) => setField<int>('employee_id', value);

  bool get status => getField<bool>('status')!;
  set status(bool value) => setField<bool>('status', value);
}
