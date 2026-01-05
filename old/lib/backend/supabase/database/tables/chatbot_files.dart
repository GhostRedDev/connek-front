import '../database.dart';

class ChatbotFilesTable extends SupabaseTable<ChatbotFilesRow> {
  @override
  String get tableName => 'chatbot_files';

  @override
  ChatbotFilesRow createRow(Map<String, dynamic> data) => ChatbotFilesRow(data);
}

class ChatbotFilesRow extends SupabaseDataRow {
  ChatbotFilesRow(super.data);

  @override
  SupabaseTable get table => ChatbotFilesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get filename => getField<String>('filename');
  set filename(String? value) => setField<String>('filename', value);

  String? get size => getField<String>('size');
  set size(String? value) => setField<String>('size', value);

  String? get contentType => getField<String>('content_type');
  set contentType(String? value) => setField<String>('content_type', value);

  String? get assistantId => getField<String>('assistant_id');
  set assistantId(String? value) => setField<String>('assistant_id', value);

  String? get fileId => getField<String>('file_id');
  set fileId(String? value) => setField<String>('file_id', value);
}
