import '../database.dart';

class WorkflowsTable extends SupabaseTable<WorkflowsRow> {
  @override
  String get tableName => 'workflows';

  @override
  WorkflowsRow createRow(Map<String, dynamic> data) => WorkflowsRow(data);
}

class WorkflowsRow extends SupabaseDataRow {
  WorkflowsRow(super.data);

  @override
  SupabaseTable get table => WorkflowsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get workflow => getField<String>('workflow');
  set workflow(String? value) => setField<String>('workflow', value);

  int? get employeeId => getField<int>('employee_id');
  set employeeId(int? value) => setField<int>('employee_id', value);

  dynamic get startState => getField<dynamic>('start_state');
  set startState(dynamic value) => setField<dynamic>('start_state', value);

  dynamic get endState => getField<dynamic>('end_state');
  set endState(dynamic value) => setField<dynamic>('end_state', value);
}
