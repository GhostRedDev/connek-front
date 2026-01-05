import '../database.dart';

class MessagesTable extends SupabaseTable<MessagesRow> {
  @override
  String get tableName => 'messages';

  @override
  MessagesRow createRow(Map<String, dynamic> data) => MessagesRow(data);
}

class MessagesRow extends SupabaseDataRow {
  MessagesRow(super.data);

  @override
  SupabaseTable get table => MessagesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get conversationId => getField<int>('conversation_id')!;
  set conversationId(int value) => setField<int>('conversation_id', value);

  String get content => getField<String>('content')!;
  set content(String value) => setField<String>('content', value);

  String get contentType => getField<String>('content_type')!;
  set contentType(String value) => setField<String>('content_type', value);

  bool get senderClient => getField<bool>('sender_client')!;
  set senderClient(bool value) => setField<bool>('sender_client', value);

  bool get senderBot => getField<bool>('sender_bot')!;
  set senderBot(bool value) => setField<bool>('sender_bot', value);

  int get sender => getField<int>('sender')!;
  set sender(int value) => setField<int>('sender', value);

  int get receiver => getField<int>('receiver')!;
  set receiver(int value) => setField<int>('receiver', value);
}
