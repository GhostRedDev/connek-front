import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D21), // Dark background
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section (Image + Gradient + Logo)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?q=80&w=2613&auto=format&fit=crop', // Cityscape placeholder
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF222831).withValues(alpha: 0.8), // Dark top
                              const Color(0xFF1A1D21), // Seamless blend to body
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Logo
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Text(
                          'connek',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -1.0,
                          ),
                        ),
                      ),
                    ),
                    // Back Button
                    Positioned(
                      top: 140, // Adjust based on design
                      left: 16,
                      child: ElevatedButton.icon(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_rounded, size: 18),
                        label: const Text('Back to search'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF31363F),
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const SizedBox(height: 20),
                    Text(
                      'Search and find services',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email Field
                    _buildLabel('Email'),
                    const SizedBox(height: 8),
                    TextFormField(
                       controller: _emailController,
                       style: const TextStyle(color: Colors.white),
                       decoration: _inputDecoration(hint: 'Enter your email'),
                    ),
                    
                    const SizedBox(height: 16),

                    // Password Field
                    _buildLabel('Password'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !_passwordVisible,
                      decoration: _inputDecoration(
                        hint: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Remember Me & Forgot Password
                    Row(
                      children: [
                        // Custom Switch/Toggle for Remember Me
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: _rememberMe,
                            activeColor: const Color(0xFF4F87C9),
                            onChanged: (val) => setState(() => _rememberMe = val),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Remember me', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot password?', style: TextStyle(color: Color(0xFF4F87C9))),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.go('/home'), // Navigate to Home
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F87C9), // Blue
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Sign in',
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
                          child: Text('Or', style: TextStyle(color: Colors.grey[500])),
                        ),
                        Expanded(child: Divider(color: Colors.grey[700])),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Google Sign In
                    _buildSocialButton(
                      label: 'Sign in with Google',
                      icon: Icons.g_mobiledata, // Placeholder
                      color: Colors.white,
                      // In real app use assets/images/fixgoogle.png
                    ),
                    const SizedBox(height: 16),
                     // Apple Sign In
                    _buildSocialButton(
                      label: 'Sign in with Apple',
                      icon: Icons.apple,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 40),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: TextStyle(color: Colors.grey[400])),
                        InkWell(
                          onTap: () => context.push('/register'),
                          child: const Text(
                            'Sign up now',
                            style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      filled: true,
      fillColor: const Color(0xFF22262B), // Slightly lighter than bg
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: suffixIcon,
    );
  }

  Widget _buildSocialButton({required String label, required IconData icon, required Color color}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF31363F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
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
