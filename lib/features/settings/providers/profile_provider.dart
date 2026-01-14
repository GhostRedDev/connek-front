import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/models/user_model.dart';
import '../../../core/providers/auth_provider.dart';

// --- Repository ---

class ProfileRepository {
  final SupabaseClient _supabase;

  ProfileRepository(this._supabase);

  // Fetch Profile by Auth User Object (Optimized: Parallel Fetch)
  Future<UserProfile?> getProfile({User? currUser}) async {
    final user = currUser ?? _supabase.auth.currentUser;
    print('👤 ProfileRepository: Current Auth User: ${user?.id ?? "NULL"}');

    if (user == null) return null;

    try {
      print('🚀 ProfileRepository: FAST FETCH for ${user.id}...');

      // PARALLEL REQUESTS: Fetch Client AND Business simultaneously
      final results = await Future.wait([
        // 0: Client Profile
        _supabase.from('client').select().eq('user_id', user.id).maybeSingle(),

        // 1: Business Profile (by owner_user)
        _supabase
            .from('business')
            .select('id, name, profile_image')
            .eq('owner_user', user.id)
            .maybeSingle(),
      ]);

      final clientData = results[0];
      final businessData = results[1];

      print(
        '📥 ProfileRepository: Fetch complete. Client: ${clientData != null}, Business: ${businessData != null}',
      );

      if (clientData != null) {
        // Resolve Client Image
        if (clientData['photo_id'] != null) {
          String pid = clientData['photo_id'].toString();
          if (pid.isNotEmpty && !pid.startsWith('http')) {
            if (!pid.contains('/')) pid = '${clientData['id']}/$pid';
            clientData['photo_id'] = _supabase.storage
                .from('client')
                .getPublicUrl(pid);
          }
        }

        // Merge Business Data if exists
        if (businessData != null) {
          clientData['has_business'] = true;
          clientData['business_name'] = businessData['name'];
          clientData['business_profile_image'] = businessData['profile_image'];
          clientData['business_id'] = businessData['id'];

          // Resolve Business Image
          if (clientData['business_profile_image'] != null) {
            String bPid = clientData['business_profile_image'].toString();
            if (bPid.isNotEmpty && !bPid.startsWith('http')) {
              if (!bPid.contains('/')) bPid = '${businessData['id']}/$bPid';
              clientData['business_profile_image'] = _supabase.storage
                  .from('business')
                  .getPublicUrl(bPid);
            }
          }
        }

        return UserProfile.fromJson(clientData);
      } else {
        // Create default profile if not exists (This is rare, usually on SignUp)
        // We can keep this sequential as it's a one-time setup
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
  late ProfileRepository _repository;

  @override
  Future<UserProfile?> build() async {
    // Watch Auth State to refetch profile on login/logout
    final authState = ref.watch(authStateProvider);
    final user =
        authState.value?.session?.user ??
        Supabase.instance.client.auth.currentUser;

    _repository = ref.read(profileRepositoryProvider);
    return _fetchProfile(user: user);
  }

  Future<UserProfile?> _fetchProfile({User? user}) async {
    return await _repository.getProfile(currUser: user);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      final user = Supabase.instance.client.auth.currentUser;
      return _fetchProfile(user: user);
    });
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
