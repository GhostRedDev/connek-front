import '../database.dart';

class GregWorkflowsTable extends SupabaseTable<GregWorkflowsRow> {
  @override
  String get tableName => 'greg_workflows';

  @override
  GregWorkflowsRow createRow(Map<String, dynamic> data) =>
      GregWorkflowsRow(data);
}

class GregWorkflowsRow extends SupabaseDataRow {
  GregWorkflowsRow(super.data);

  @override
  SupabaseTable get table => GregWorkflowsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int? get gregId => getField<int>('greg_id');
  set gregId(int? value) => setField<int>('greg_id', value);

  dynamic get startState => getField<dynamic>('start_state');
  set startState(dynamic value) => setField<dynamic>('start_state', value);

  dynamic get endState => getField<dynamic>('end_state');
  set endState(dynamic value) => setField<dynamic>('end_state', value);

  int? get conversationId => getField<int>('conversation_id');
  set conversationId(int? value) => setField<int>('conversation_id', value);
}
