import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'widgets/auth_success_overlay.dart';
import '../../core/providers/locale_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor, // Adaptive background
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight:
                  MediaQuery.of(context).size.height *
                  0.40, // Expanded height for effect
              pinned: true, // Keep bar visible
              backgroundColor: const Color(0xFF1A1D21),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => context.pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?q=80&w=2613&auto=format&fit=crop',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xCC222831), Color(0x00222831)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(-0.64, 1),
                            end: AlignmentDirectional(0.64, -1),
                          ),
                        ),
                      ),
                    ),
                    // Logo
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/conneck_logo_white.png',
                            width: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text(
                                  'connek',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      t['login_title'] ?? 'Search and find services',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email Field
                    _buildLabel(t['email_label'] ?? 'Email', context),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      decoration: _inputDecoration(
                        context,
                        hint: t['email_hint'] ?? 'Enter your email',
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password Field
                    _buildLabel(t['password_label'] ?? 'Password', context),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      obscureText: !_passwordVisible,
                      decoration: _inputDecoration(
                        context,
                        hint: t['password_hint'] ?? 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () => setState(
                            () => _passwordVisible = !_passwordVisible,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Remember Me & Forgot Password
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8, // horizontal gap
                      runSpacing: 0, // vertical gap
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: _rememberMe,
                                activeThumbColor: const Color(0xFF4F87C9),
                                onChanged: (val) =>
                                    setState(() => _rememberMe = val),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              t['remember_me'] ?? 'Remember me',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: Text(
                            t['forgot_password'] ?? 'Forgot password?',
                            style: const TextStyle(color: Color(0xFF4F87C9)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Show loading
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (c) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            final response = await Supabase.instance.client.auth
                                .signInWithPassword(
                                  email: email,
                                  password: password,
                                );

                            // Dismiss loading
                            if (mounted) Navigator.of(context, rootNavigator: true).pop();

                            if (response.user != null) {
                              if (mounted) {
                                // Show Custom Neon Overlay
                                await showAuthSuccessDialog(
                                  context,
                                  message:
                                      'Has sido logueado exitosamente.\nBienvenido a Comeet.', // Maybe translate too?
                                  isLogin: true,
                                );

                                if (mounted) context.go('/');
                              }
                            }
                          } on AuthException catch (error) {
                            // Dismiss loading
                            if (mounted) Navigator.of(context, rootNavigator: true).pop();

                            // Specific Supabase Auth Errors (Wrong password, User not found, etc.)
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Authentication Error: ${error.message}',
                                  ), // e.g., "Invalid login credentials"
                                  backgroundColor: Colors.orange,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          } catch (e) {
                            // Dismiss loading
                            if (mounted) Navigator.of(context, rootNavigator: true).pop();

                            // General Errors (Network, Code, etc.)
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Connection Error: Please check your internet or try again later.\nDetails: $e',
                                  ),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F87C9),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          t['sign_in_button'] ?? 'Sign in',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[700])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            t['or_divider'] ?? 'Or',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey[700])),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Google Sign In
                    _buildSocialButton(
                      label: t['sign_in_google'] ?? 'Sign in with Google',
                      icon: Icons.g_mobiledata,
                      color: Colors.white,
                      onPressed: _googleSignIn,
                    ),
                    const SizedBox(height: 16),
                    // Apple Sign In
                    _buildSocialButton(
                      label: t['sign_in_apple'] ?? 'Sign in with Apple',
                      icon: Icons.apple,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 40),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${t['no_account'] ?? "Don't have an account?"} ",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        InkWell(
                          onTap: () => context.push('/register'),
                          child: Text(
                            t['sign_up_link'] ?? 'Sign up now',
                            style: const TextStyle(
                              color: Color(0xFF4F87C9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
    Widget? suffixIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Theme.of(context).hintColor.withOpacity(0.7),
        fontSize: 14,
      ),
      filled: true,
      fillColor: Theme.of(context).cardColor,
      hoverColor: isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.black.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: suffixIcon,
    );
  }

  Future<void> _googleSignIn() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.connek://login',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Sign In Failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF31363F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
