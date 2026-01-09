import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connek_frontend/features/settings/providers/profile_provider.dart';
import 'profile_bottom_sheet.dart';

class LoginDropdownButton extends ConsumerWidget {
  const LoginDropdownButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session =
            snapshot.data?.session ??
            Supabase.instance.client.auth.currentSession;
        final bool isLoggedIn = session != null;

        final profileState = ref.watch(profileProvider);
        final user = profileState.value;

        return InkWell(
          onTap: () => showProfileBottomSheet(context),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(2), // Border width
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isLoggedIn
                  ? const LinearGradient(
                      colors: [
                        Color(0xFF4285F4),
                        Color(0xFF90CAF9),
                      ], // Blue gradient for Auth
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [
                        Color(0xFF2C3138),
                        Color(0xFF1A1D21),
                      ], // Grey gradient for Guest
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            ),
            child: Container(
              // width: 40, // Removed to fill parent
              // height: 40, // Removed to fill parent
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.4), // Inner bg
                image:
                    (isLoggedIn &&
                        user?.photoId != null &&
                        user!.photoId!.isNotEmpty)
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(user.photoId!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child:
                  (isLoggedIn &&
                      user?.photoId != null &&
                      user!.photoId!.isNotEmpty)
                  ? null // Image is in decoration
                  : Center(
                      child: Icon(
                        isLoggedIn ? Icons.person : Icons.person_outline,
                        color: Colors.white,
                        size: 28, // Increased from 24
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
