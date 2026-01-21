import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/review_model.dart';
import '../services/review_service.dart';

// Service Provider
final reviewServiceProvider = Provider<ReviewService>((ref) {
  return ReviewService(Supabase.instance.client);
});

// Async Notifier for Business Reviews
class ReviewNotifier extends FamilyAsyncNotifier<List<ReviewModel>, String> {
  late final String _businessId;

  @override
  Future<List<ReviewModel>> build(String arg) async {
    _businessId = arg;
    return ref.read(reviewServiceProvider).getReviews(_businessId);
  }

  Future<void> addReview({required int rating, required String content}) async {
    final user = Supabase.instance.client.auth.currentUser;
    // We assume the user is logged in.
    // We also need the client_id.
    // If auth metadata has client_id we use it, otherwise we might need to fetch it.
    // For now assuming we can get client_id from somewhere or user metadata.
    // Since this is "client dashboard", maybe we have a `currentClientProvider`?
    // Let's assume we can fetch it or pass it.
    // To minimize complexity, I'll fetch the client ID associated with the user ID if possible
    // or assume the caller handles this check.
    // BETTER: Use a helper to get client ID.

    if (user == null) throw Exception("User not logged in");

    // Retrieve client_id logic (Simplified for this task: query 'clients' table by user_id)
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
            businessId: _businessId,
            rating: rating,
            content: content,
          );
      final currentList = state.value ?? [];
      return [newReview, ...currentList];
    });
  }

  Future<void> toggleLike(int reviewId) async {
    // Optimistic update?
    // Doing strict update for now
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    // Retrieve client_id logic (Duplicated for now, ideal to have userProvider)
    final clientData = await Supabase.instance.client
        .from('clients')
        .select('id')
        .eq('user_id', user.id)
        .single();
    final int clientId = clientData['id'];

    // We toggle in service
    await ref
        .read(reviewServiceProvider)
        .toggleLike(clientId: clientId, reviewId: reviewId);

    // We should reload to update counts or update state locally?
    // Since we don't have real "likesCount" in the model fetching (it wasn't in the simple select),
    // we simply reload or ignore count update if we can't see it.
    // But let's reload to be safe.
    ref.invalidateSelf();
  }
}

final reviewProvider =
    AsyncNotifierProvider.family<ReviewNotifier, List<ReviewModel>, String>(() {
      return ReviewNotifier();
    });
