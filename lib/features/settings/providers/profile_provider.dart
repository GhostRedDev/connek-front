import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/user_model.dart';

// --- Repository ---

class ProfileRepository {
  final SupabaseClient _supabase;

  ProfileRepository(this._supabase);

  // Fetch Profile by Auth User ID (Create if doesn't exist)
  Future<UserProfile?> getProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await _supabase
          .from('client')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

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
      // If error (e.g. duplicate key race condition), try fetching again or throw
      throw Exception('Error fetching/creating profile: $e');
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
  Future<String> uploadProfileImage(String filePath, int clientId, String type) async {
    try {
      final file = File(filePath);
      final fileName = '${type}_${clientId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '$clientId/$fileName';

      // Upload to 'client' bucket
      await _supabase.storage.from('client').upload(path, file);

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

final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserProfile?>(ProfileNotifier.new);


// --- Notifier ---

class ProfileNotifier extends AsyncNotifier<UserProfile?> {
  late final ProfileRepository _repository;

  @override
  Future<UserProfile?> build() async {
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

  Future<void> uploadAvatar(String filePath) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    try {
      final publicUrl = await _repository.uploadProfileImage(filePath, currentProfile.id, 'avatar');
      
      final updatedProfile = currentProfile.copyWith(photoId: publicUrl);
      final result = await _repository.updateProfile(updatedProfile);
      
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> uploadBanner(String filePath) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    try {
      final publicUrl = await _repository.uploadProfileImage(filePath, currentProfile.id, 'banner');
      
      final updatedProfile = currentProfile.copyWith(bannerUrl: publicUrl);
      final result = await _repository.updateProfile(updatedProfile);
      
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  // Backwards compatibility if needed, but we should use uploadAvatar
  Future<void> uploadImage(String filePath) => uploadAvatar(filePath);
}
