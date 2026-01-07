import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2)); 
    if (!mounted) return;

    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      context.go('/home');
    } else {
      context.go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D21), // Dark background matching app theme
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/conneck_logo_white.png',
              width: 150,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Text(
                'connek',
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            // Loading Indicator
            const SpinKitFadingCircle(
              color: Color(0xFF4F87C9), // App Blue
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
