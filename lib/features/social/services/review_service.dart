import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/review_model.dart';

class ReviewService {
  final SupabaseClient _supabase;

  ReviewService(this._supabase);

  // Get Reviews for a Business
  Future<List<ReviewModel>> getReviews(String businessId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('*, client:client_id(*)') // Nested select for client data
          .eq('business_id', businessId)
          .order('created_at', ascending: false);

      // Map to models
      final List<ReviewModel> reviews = (response as List).map((json) {
        // Just in case client comes as a list or different structure, handle it
        // Supabase foreign table join usually returns a single object if 1:1 or N:1
        return ReviewModel.fromJson(json);
      }).toList();

      return reviews;
    } catch (e) {
      throw Exception('Error fetching reviews: $e');
    }
  }

  // Create a Review
  Future<ReviewModel> createReview({
    required int clientId,
    required String businessId,
    required int rating,
    required String content,
  }) async {
    try {
      final response = await _supabase
          .from('reviews')
          .insert({
            'client_id': clientId,
            'business_id': int.parse(businessId),
            'rating': rating,
            'content': content,
          })
          .select()
          .single();

      // We need to fetch the review AGAIN to get the nested client data
      // OR we can optimistically return it if we have the client object.
      // For simplicity, let's fetch it again properly or construct it.
      // Fetching again to be safe:
      final fullReviewResponse = await _supabase
          .from('reviews')
          .select('*, client:client_id(*)')
          .eq('id', response['id'])
          .single();

      return ReviewModel.fromJson(fullReviewResponse);
    } catch (e) {
      throw Exception('Error creating review: $e');
    }
  }

  // Toggle Like (Review)
  Future<bool> toggleLike({
    required int clientId,
    required int reviewId,
  }) async {
    try {
      // 1. Check if liked
      final existingLike = await _supabase
          .from('review_likes')
          .select()
          .eq('client_id', clientId)
          .eq('review_id', reviewId)
          .maybeSingle();

      if (existingLike != null) {
        // Unlike
        await _supabase
            .from('review_likes')
            .delete()
            .eq('id', existingLike['id']);
        return false; // Liked = false
      } else {
        // Like
        await _supabase.from('review_likes').insert({
          'client_id': clientId,
          'review_id': reviewId,
        });
        return true; // Liked = true
      }
    } catch (e) {
      throw Exception('Error toggling like: $e');
    }
  }
}
