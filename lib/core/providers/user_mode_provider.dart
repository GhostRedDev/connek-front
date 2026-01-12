import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/settings/providers/profile_provider.dart';

// True = Business Mode, False = Client Mode
class UserModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false; // Default: Client Mode
  }

  void setMode(bool isBusiness) {
    state = isBusiness;
  }

  void toggle() {
    state = !state;
  }
}

final userModeProvider = NotifierProvider<UserModeNotifier, bool>(
  UserModeNotifier.new,
);

// Helper provider to check if switch is allowed
final canSwitchToBusinessProvider = Provider<bool>((ref) {
  final profileAsync = ref.watch(profileProvider);
  return profileAsync.when(
    data: (profile) => profile?.hasBusiness ?? false,
    loading: () => false,
    error: (_, __) => false,
  );
});
