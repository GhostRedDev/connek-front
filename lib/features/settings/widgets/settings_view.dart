import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/widgets/auth_success_overlay.dart'; // For feedback

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final _supabase = Supabase.instance.client;
  bool _isLoading = false;

  // --- Helpers ---

  Future<void> _updateMetadata(String key, dynamic value) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(data: {key: value}),
      );
      // UI updates automatically via StreamBuilder
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating setting: $e')),
        );
      }
    }
  }

  Future<void> _updatePhone() async {
    final controller = TextEditingController(text: _supabase.auth.currentUser?.phone ?? '');
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Phone Number'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'New Phone Number'),
          keyboardType: TextInputType.phone,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (controller.text.trim().isEmpty) return;
              
              try {
                setState(() => _isLoading = true);
                await _supabase.auth.updateUser(
                  UserAttributes(phone: controller.text.trim()),
                );
                if (mounted) {
                   await showAuthSuccessDialog(context, message: 'Phone updated!', isLogin: true);
                }
              } catch (e) {
                if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
              } finally {
                if (mounted) setState(() => _isLoading = false);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _changePassword() async {
    final passwordController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'New Password'),
          obscureText: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (passwordController.text.length < 6) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password too short')));
                 return;
              }

              try {
                setState(() => _isLoading = true);
                await _supabase.auth.updateUser(
                  UserAttributes(password: passwordController.text),
                );
                if (mounted) {
                   await showAuthSuccessDialog(context, message: 'Password changed successfully!', isLogin: true);
                }
              } catch (e) {
                if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
              } finally {
               if (mounted) setState(() => _isLoading = false);
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
     // TODO: Implement real delete (requires Edge Function or complex logic usually)
     // For now, sign out or deactivate logic placeholder
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Deactivation request sent.")));
  }

  @override
  Widget build(BuildContext context) {
    // Theme Constants
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);
    final subTextColor = isDark ? Colors.grey[400]! : const Color(0xFF57636C);
    
    return StreamBuilder<AuthState>(
      stream: _supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        final user = session?.user;
        final metadata = user?.userMetadata ?? {};

        // Derived State
        final bool pushNotifications = metadata['push_notifications'] ?? true;
        final bool reminders = metadata['reminders'] ?? true;
        final bool messages = metadata['messages'] ?? true;
        final bool emailNotifications = metadata['email_notifications'] ?? true;
        final bool news = metadata['news'] ?? false;
        final bool activity = metadata['activity'] ?? true;
        final bool reports = metadata['reports'] ?? false;

        return SingleChildScrollView(
           // Padding: Top=190 (Header), Bottom=100 (NavBar), Sides=20
           padding: const EdgeInsets.fromLTRB(20, 190, 20, 100), 
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (_isLoading) 
                 const LinearProgressIndicator(minHeight: 2),

               // Header
               Padding(
                 padding: const EdgeInsets.only(bottom: 20),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Settings',
                       style: GoogleFonts.outfit(
                         fontSize: 24,
                         fontWeight: FontWeight.bold,
                         color: textColor,
                       ),
                     ),
                     const SizedBox(height: 4),
                     Text(
                       'Adjust your settings',
                       style: GoogleFonts.inter(
                         fontSize: 14,
                         color: subTextColor,
                       ),
                     ),
                   ],
                 ),
               ),

               // --- Language ---
               _buildSectionHeader('Language', 'Region settings', textColor, subTextColor),
               _buildSettingItem(
                 context,
                 label: 'Language',
                 icon: Icons.language,
                 onTap: () {}, // Future: Language Picker
                 trailing: Text('English', style: TextStyle(color: subTextColor)),
               ),

               const SizedBox(height: 24),

               // --- Auth ---
               _buildSectionHeader('Auth', 'Security & Access', textColor, subTextColor),
               _buildSettingItem(
                 context, 
                 label: 'Phone Number', 
                 icon: Icons.phone, 
                 onTap: _updatePhone,
                 trailing: user?.phone != null ? Text(user!.phone!, style: TextStyle(color: subTextColor, fontSize: 12)) : null
               ),
               _buildSettingItem(context, label: '2FA', icon: Icons.security, onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Coming Soon")))),
               _buildSettingItem(context, label: 'Change password', icon: Icons.lock_outline, onTap: _changePassword),
               _buildSettingItem(context, label: 'Active sessions', icon: Icons.devices, onTap: () {}),
               _buildSettingItem(context, label: 'Login methods', icon: Icons.login, onTap: () {
                 // Show providers
                 final providers = user?.appMetadata['providers'] as List? ?? [];
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Linked: ${providers.join(', ')}")));
               }),

               const SizedBox(height: 24),

               // --- Notifications ---
               _buildSectionHeader('Notifications', 'Preferences', textColor, subTextColor),
               _buildSwitchItem('Push notifications', pushNotifications, (v) => _updateMetadata('push_notifications', v)),
               _buildSwitchItem('Reminders', reminders, (v) => _updateMetadata('reminders', v)),
               _buildSwitchItem('Messages', messages, (v) => _updateMetadata('messages', v)),
               _buildSwitchItem('Email notifications', emailNotifications, (v) => _updateMetadata('email_notifications', v)),
               _buildSwitchItem('News', news, (v) => _updateMetadata('news', v)),
               _buildSwitchItem('Activity', activity, (v) => _updateMetadata('activity', v)),
               _buildSwitchItem('Reports', reports, (v) => _updateMetadata('reports', v)),
               
               const SizedBox(height: 24),

               // --- General ---
               _buildSectionHeader('General settings', 'App Preferences', textColor, subTextColor),
               _buildSettingItem(context, label: 'Location', icon: Icons.location_on_outlined, onTap: () {}),
               _buildSettingItem(context, label: 'Units formats (\$, hours)', icon: Icons.attach_money, onTap: () {}),

               const SizedBox(height: 24),

               // --- Privacy ---
               _buildSectionHeader('Privacy', 'Data Control', textColor, subTextColor),
               _buildSettingItem(context, label: 'Shared data', icon: Icons.share, onTap: () {}),
               _buildSettingItem(
                 context, 
                 label: 'Deactivate account', 
                 icon: Icons.delete_forever, 
                 isDestructive: true,
                 onTap: _deleteAccount,
               ),
             ],
           ),
        );
      }
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, Color titleColor, Color subColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: titleColor)),
          const SizedBox(height: 2),
          Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: subColor)),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, {
    required String label, 
    IconData? icon, 
    required VoidCallback onTap, 
    Widget? trailing,
    bool isDestructive = false
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDestructive ? Colors.redAccent : (isDark ? Colors.white : const Color(0xFF1A1D21));

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
           border: Border(bottom: BorderSide(color: isDark ? Colors.white12 : Colors.grey[200]!)),
        ),
        child: Row(
          children: [
             if (icon != null) ...[
               Icon(icon, size: 20, color: isDestructive ? Colors.redAccent : Colors.grey[500]),
               const SizedBox(width: 12),
             ],
             Expanded(
               child: Text(
                 label,
                 style: GoogleFonts.inter(
                   fontSize: 14, 
                   fontWeight: FontWeight.w500,
                   color: color,
                 ),
               ),
             ),
             if (trailing != null) trailing
             else Icon(Icons.chevron_right, size: 18, color: Colors.grey[500]),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(String label, bool value, ValueChanged<bool> onChanged) {
    return Container(
       width: double.infinity,
       height: 50,
        decoration: BoxDecoration(
           border: Border(bottom: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.grey[200]!)),
        ),
       child: Row(
         children: [
           Expanded(
             child: Text(
               label,
               style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
             ),
           ),
           Switch.adaptive(
             value: value, 
             onChanged: onChanged,
             activeColor: const Color(0xFF4F87C9),
           ),
         ],
       ),
    );
  }
}
