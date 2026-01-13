import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/models/user_model.dart';
import '../../../core/providers/auth_provider.dart';

// --- Repository ---

class ProfileRepository {
  final SupabaseClient _supabase;

  ProfileRepository(this._supabase);

  // Fetch Profile by Auth User ID (Create if doesn't exist)
  Future<UserProfile?> getProfile() async {
    final user = _supabase.auth.currentUser;
    print('👤 ProfileRepository: Current Auth User: ${user?.id ?? "NULL"}');
    if (user == null) return null;

    try {
      print(
        '🔍 ProfileRepository: Fetching client data for user_id: ${user.id}...',
      );
      final data = await _supabase
          .from('client')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      print(
        '📥 ProfileRepository: Database response data: ${data != null ? "FOUND" : "NOT FOUND"}',
      );

      if (data != null) {
        return UserProfile.fromJson(data);
      } else {
        // Create default profile if not exists
        final newProfile = {
          'user_id': user.id,
          'email': user.email ?? '',
          'first_name': '',
          'last_name': '',
          'created_at': DateTime.now().toIso8601String(),
        };

        final createdData = await _supabase
            .from('client')
            .insert(newProfile)
            .select()
            .single();

        return UserProfile.fromJson(createdData);
      }
    } catch (e) {
      print('❌ ProfileRepository: Error in getProfile: $e');
      return null;
    }
  }

  // Update Profile
  Future<UserProfile> updateProfile(UserProfile profile) async {
    try {
      final data = await _supabase
          .from('client')
          .update(profile.toJson())
          .eq('id', profile.id)
          .select()
          .single();

      return UserProfile.fromJson(data);
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }

  // Upload Profile Image (Generic for Avatar/Banner)
  Future<String> uploadProfileImage(
    XFile file,
    int clientId,
    String type,
  ) async {
    try {
      final bytes = await file.readAsBytes();
      final fileExt = file.name.split('.').last;
      final fileName =
          '${type}_${clientId}_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final path = '$clientId/$fileName';

      // Upload to 'client' bucket
      await _supabase.storage
          .from('client')
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );

      // Get Public URL
      final publicUrl = _supabase.storage.from('client').getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      throw Exception('Error uploading $type: $e');
    }
  }
}

// --- Provider Definitions ---

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(Supabase.instance.client);
});

final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserProfile?>(
  ProfileNotifier.new,
);

// --- Notifier ---

class ProfileNotifier extends AsyncNotifier<UserProfile?> {
  late final ProfileRepository _repository;

  @override
  Future<UserProfile?> build() async {
    // Watch Auth State to refetch profile on login/logout
    ref.watch(authStateProvider);

    _repository = ref.read(profileRepositoryProvider);
    return _fetchProfile();
  }

  Future<UserProfile?> _fetchProfile() async {
    return await _repository.getProfile();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProfile());
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? aboutMe,
    String? dob,
    String? email, // Email update
  }) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final updatedProfile = currentProfile.copyWith(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      aboutMe: aboutMe,
      dob: dob,
      // Note: Updating email here only updates the 'client' table record.
      // It does NOT update the Supabase Auth user email.
      // Ideally, email sync should happen via Edge Function or Auth Listener.
    );

    try {
      final result = await _repository.updateProfile(updatedProfile);
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> uploadAvatar(XFile file) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    try {
      final publicUrl = await _repository.uploadProfileImage(
        file,
        currentProfile.id,
        'avatar',
      );

      final updatedProfile = currentProfile.copyWith(photoId: publicUrl);
      final result = await _repository.updateProfile(updatedProfile);

      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> uploadBanner(XFile file) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    try {
      final publicUrl = await _repository.uploadProfileImage(
        file,
        currentProfile.id,
        'banner',
      );

      final updatedProfile = currentProfile.copyWith(bannerUrl: publicUrl);
      final result = await _repository.updateProfile(updatedProfile);

      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Backwards compatibility if needed, but we should use uploadAvatar
  Future<void> uploadImage(XFile file) => uploadAvatar(file);
}
