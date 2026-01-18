import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/biometric_service.dart';

class BiometricAuthGuard extends ConsumerStatefulWidget {
  final Widget child;
  const BiometricAuthGuard({super.key, required this.child});

  @override
  ConsumerState<BiometricAuthGuard> createState() => _BiometricAuthGuardState();
}

class _BiometricAuthGuardState extends ConsumerState<BiometricAuthGuard> {
  bool _isAuthenticated = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      if (mounted) {
        setState(() {
          _isAuthenticated = true;
          _isChecking = false;
        });
      }
      return;
    }

    final service = ref.read(biometricServiceProvider);
    final enabled = await service.isBiometricEnabled();

    if (!enabled) {
      if (mounted) {
        setState(() {
          _isAuthenticated = true;
          _isChecking = false;
        });
      }
      return;
    }

    _authenticate();
  }

  Future<void> _authenticate() async {
    final service = ref.read(biometricServiceProvider);
    final authenticated = await service.authenticate();

    if (mounted) {
      setState(() {
        _isAuthenticated = authenticated;
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isAuthenticated) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                'Autenticación Requerida',
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _authenticate,
                child: const Text('Intentar de nuevo'),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
