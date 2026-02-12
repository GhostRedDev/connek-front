import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/api_service.dart';
import '../models/review_model.dart';
// Note: You might need to create CommentModel if it doesn't exist, or use dynamic for now.

final reviewServiceProvider = Provider<ReviewService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ReviewService(apiService);
});

class ReviewService {
  final ApiService _apiService;

  ReviewService(this._apiService);

  // Get Reviews for a Business
  Future<List<ReviewModel>> getReviews(String businessId) async {
    try {
      final response = await _apiService.get('/reviews/business/$businessId');

      if (response is List) {
        return response.map((json) => ReviewModel.fromJson(json)).toList();
      } else if (response is Map && response.containsKey('data')) {
        // Handle if wrapped in response object
        final list = response['data'] as List;
        return list.map((json) => ReviewModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching reviews: $e');
    }
  }

  // Create a Review
  Future<ReviewModel> createReview({
    required int clientId,
    required int businessId,
    required int rating,
    required String content,
  }) async {
    try {
      final body = {
        'client_id': clientId,
        'business_id': businessId,
        'rating': rating,
        'content': content,
      };

      final response = await _apiService.post('/reviews/create', body: body);

      // Assuming backend returns the created object directly or in 'data'
      if (response is Map && response.containsKey('data')) {
        return ReviewModel.fromJson(response['data']);
      }

      return ReviewModel.fromJson(response);
    } catch (e) {
      throw Exception('Error creating review: $e');
    }
  }

  // Create a Comment (Reply to review)
  Future<dynamic> createComment({
    required int clientId,
    required int reviewId,
    required String content,
    int? parentId,
  }) async {
    try {
      final body = {
        'client_id': clientId,
        'review_id': reviewId,
        'content': content,
        'parent_id': parentId,
      };

      final response = await _apiService.post('/comments/create', body: body);
      return response;
    } catch (e) {
      throw Exception('Error creating comment: $e');
    }
  }

  // Toggle Like (Review or Comment)
  Future<dynamic> toggleLike({
    required int clientId,
    required int targetId,
    required String targetType, // 'review' or 'comment'
  }) async {
    try {
      final body = {
        'client_id': clientId,
        'target_id': targetId,
        'target_type': targetType,
      };

      final response = await _apiService.post('/likes/toggle', body: body);
      return response;
    } catch (e) {
      throw Exception('Error toggling like: $e');
    }
  }

  // Get Comments for a Review
  Future<List<dynamic>> getComments(int reviewId) async {
    try {
      final response = await _apiService.get('/comments/review/$reviewId');
      if (response is List) {
        return response; // Return list of comments
      } else if (response is Map && response.containsKey('data')) {
        return response['data'] as List;
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching comments: $e');
    }
  }
}
