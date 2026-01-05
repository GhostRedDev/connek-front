import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
       // Placeholder for registration logic
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Registration functionality to be implemented')),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D21),
        body: CustomScrollView(
          slivers: [
             SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.40,
              pinned: true,
              backgroundColor: const Color(0xFF1A1D21),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => context.go('/welcome'),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/regis.png', // Ensure this asset exists or use placeholder
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
                      ),
                    ),
                    // Gradient
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
                            errorBuilder: (context, error, stackTrace) => const Text('connek', style: TextStyle(color: Colors.white, fontSize: 30)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const SizedBox(height: 20),
                       Text(
                        'Create an account',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Name Fields
                      Row(
                        children: [
                          Expanded(child: _buildTextField(controller: _firstNameController, label: 'First Name', hint: 'First Name')),
                          const SizedBox(width: 10),
                          Expanded(child: _buildTextField(controller: _lastNameController, label: 'Last Name', hint: 'Last Name')),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Contact Fields
                      _buildTextField(controller: _emailController, label: 'Email', hint: 'Enter your email'),
                      const SizedBox(height: 16),
                      _buildTextField(controller: _phoneController, label: 'Phone', hint: 'Enter your phone', keyboardType: TextInputType.phone),
                      const SizedBox(height: 16),
                      
                      // Date of Birth
                      Text('Date of Birth', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(flex: 2, child: _buildTextField(controller: _yearController, hint: 'Year', keyboardType: TextInputType.number)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildTextField(controller: _monthController, hint: 'Month', keyboardType: TextInputType.number)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildTextField(controller: _dayController, hint: 'Day', keyboardType: TextInputType.number)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Password Fields
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Password',
                        obscureText: !_passwordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Confirm Password',
                        obscureText: !_confirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                          onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F87C9),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          ),
                          child: Text('Create account', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.normal)),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Social Sign Up
                      const Center(child: Text('Or sign up with', style: TextStyle(color: Colors.grey))),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           _socialButton(Icons.g_mobiledata, 'Google'), // Replace icon/image
                           const SizedBox(width: 20),
                           _socialButton(Icons.apple, 'Apple'),
                        ],
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? ', style: TextStyle(color: Colors.grey)),
                          InkWell(
                            onTap: () => context.go('/login'),
                            child: const Text('Log in now', style: TextStyle(color: Color(0xFF4F87C9), fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: const Color(0xFF22262B),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
  
  Widget _socialButton(IconData icon, String label) {
     return Container(
       width: 50, height: 50,
       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
       child: Icon(icon, color: Colors.black),
     );
  }
}
