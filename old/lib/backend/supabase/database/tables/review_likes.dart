import '../database.dart';

class ReviewLikesTable extends SupabaseTable<ReviewLikesRow> {
  @override
  String get tableName => 'review_likes';

  @override
  ReviewLikesRow createRow(Map<String, dynamic> data) => ReviewLikesRow(data);
}

class ReviewLikesRow extends SupabaseDataRow {
  ReviewLikesRow(super.data);

  @override
  SupabaseTable get table => ReviewLikesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  int get reviewId => getField<int>('review_id')!;
  set reviewId(int value) => setField<int>('review_id', value);
}
