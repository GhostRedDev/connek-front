import '../database.dart';

class ReviewsTable extends SupabaseTable<ReviewsRow> {
  @override
  String get tableName => 'reviews';

  @override
  ReviewsRow createRow(Map<String, dynamic> data) => ReviewsRow(data);
}

class ReviewsRow extends SupabaseDataRow {
  ReviewsRow(super.data);

  @override
  SupabaseTable get table => ReviewsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get clientId => getField<int>('client_id')!;
  set clientId(int value) => setField<int>('client_id', value);

  int get businessId => getField<int>('business_id')!;
  set businessId(int value) => setField<int>('business_id', value);

  int get rating => getField<int>('rating')!;
  set rating(int value) => setField<int>('rating', value);

  String get content => getField<String>('content')!;
  set content(String value) => setField<String>('content', value);

  int get reviewBusinessId => getField<int>('review_business_id')!;
  set reviewBusinessId(int value) => setField<int>('review_business_id', value);
}
