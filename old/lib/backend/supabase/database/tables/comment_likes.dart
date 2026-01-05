import '../database.dart';

class CommentLikesTable extends SupabaseTable<CommentLikesRow> {
  @override
  String get tableName => 'comment_likes';

  @override
  CommentLikesRow createRow(Map<String, dynamic> data) => CommentLikesRow(data);
}

class CommentLikesRow extends SupabaseDataRow {
  CommentLikesRow(super.data);

  @override
  SupabaseTable get table => CommentLikesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  int get commentId => getField<int>('comment_id')!;
  set commentId(int value) => setField<int>('comment_id', value);
}
