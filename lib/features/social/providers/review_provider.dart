import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';
import '../models/review_model.dart';
import '../services/review_service.dart';

// Service Provider
// Using apiServiceProvider which is defined in core/services/api_service.dart
final reviewServiceProvider = Provider<ReviewService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ReviewService(apiService);
});

// Async Notifier for Business Reviews
class ReviewNotifier extends FamilyAsyncNotifier<List<ReviewModel>, String> {
  late final String _businessId;

  @override
  Future<List<ReviewModel>> build(String arg) async {
    _businessId = arg;
    return ref.watch(reviewServiceProvider).getReviews(_businessId);
  }

  Future<void> addReview({required int rating, required String content}) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Fetch client ID
    final clientData = await Supabase.instance.client
        .from('clients')
        .select('id')
        .eq('user_id', user.id)
        .single();
    final int clientId = clientData['id'];

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newReview = await ref
          .read(reviewServiceProvider)
          .createReview(
            clientId: clientId,
            businessId: int.parse(_businessId),
            rating: rating,
            content: content,
          );
      final currentList = state.value ?? [];
      return [newReview, ...currentList];
    });
  }

  Future<void> toggleLike(int reviewId) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final clientData = await Supabase.instance.client
        .from('clients')
        .select('id')
        .eq('user_id', user.id)
        .single();
    final int clientId = clientData['id'];

    // Call updated toggleLike with required args
    await ref
        .read(reviewServiceProvider)
        .toggleLike(
          clientId: clientId,
          targetId: reviewId,
          targetType: 'review',
        );

    ref.invalidateSelf();
  }
}

final reviewProvider =
    AsyncNotifierProvider.family<ReviewNotifier, List<ReviewModel>, String>(() {
      return ReviewNotifier();
    });
