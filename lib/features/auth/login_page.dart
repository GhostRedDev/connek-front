import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/providers/locale_provider.dart';
import '../../system_ui/core/constants.dart';
import '../../system_ui/form/inputs.dart';
import '../../system_ui/form/switches.dart';
import '../../system_ui/form/labels.dart';
import '../../system_ui/layout/buttons.dart';
import '../../system_ui/layout/grid.dart';
import '../../system_ui/typography.dart';
import '../../system_ui/feedback/toasts.dart';
import 'controllers/login_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _onSignIn() async {
    final success = await ref
        .read(loginControllerProvider.notifier)
        .signIn(_emailCtrl.text.trim(), _passCtrl.text.trim());

    if (success && mounted) {
      // Redirect directly without showing success dialog
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (prev, next) {
      if (next.hasError) {
        AppToast.showError(
          context,
          title: 'Error',
          description: next.error.toString(),
        );
      }
    });

    final isLoading = ref.watch(loginControllerProvider).isLoading;
    final t = ref.watch(translationProvider).value ?? {};

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const _LoginHeader(),
            SliverToBoxAdapter(
              child: AppContainer(
                maxWidth: AppBreakpoints.tablet,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center title info
                    children: [
                      const SizedBox(height: AppSpacing.l),

                      // Title
                      AppText.h2(
                        t['login_title'] ?? 'Welcome Back',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.s),
                      AppText.muted(
                        'Please enter your details to sign in',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Social Buttons (Top)
                      _SocialButtonsv2(t: t, isLoading: isLoading),

                      const SizedBox(height: AppSpacing.l),

                      // Divider
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.m,
                            ),
                            child: AppText.muted(t['or_divider'] ?? 'or'),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.l),

                      // Form (Aligned to start)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email
                            AppLabel(
                              text: t['email_label'] ?? 'Email address',
                              isRequired: true,
                            ),
                            const SizedBox(height: AppSpacing.s),
                            AppInput.text(
                              controller: _emailCtrl,
                              placeholder:
                                  t['email_hint'] ?? 'Enter your email address',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: AppSpacing.m),

                            // Password
                            AppLabel(
                              text: t['password_label'] ?? 'Password',
                              isRequired: true,
                            ),
                            const SizedBox(height: AppSpacing.s),
                            AppInput.text(
                              controller: _passCtrl,
                              placeholder: '••••••••',
                              obscureText: _obscurePass,
                              trailing: ShadButton.ghost(
                                width: 24,
                                height: 24,
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  _obscurePass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 16,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePass = !_obscurePass,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.m),

                      // Options
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: AppSpacing.s,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform.scale(
                                scale: 0.9,
                                child: AppSwitch(
                                  checked: _rememberMe,
                                  onCheckedChange: (v) =>
                                      setState(() => _rememberMe = v),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.s),
                              AppText.small(t['remember_me'] ?? 'Remember Me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () => context.push('/forgot-password'),
                            child: AppText.small(
                              t['forgot_password'] ?? 'Forgot Password?',
                              color: ShadTheme.of(context).colorScheme.primary,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Actions
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        AppButton.primary(
                          text: t['sign_in_button'] ?? 'Sign in',
                          width: double.infinity,
                          onPressed: _onSignIn,
                        ),

                      const SizedBox(height: AppSpacing.xl),

                      // Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText.muted(
                            t['no_account'] ?? "New on our platform? ",
                          ),
                          InkWell(
                            onTap: () => context.push('/register'),
                            child: AppText.small(
                              t['sign_up_link'] ?? 'Create an account',
                              color: ShadTheme.of(context).colorScheme.primary,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
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
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    // We use a high flexible space to show the carousel
    return SliverAppBar(
      expandedHeight: 400, // Increased height for better visibility
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: const FlexibleSpaceBar(background: _LoginHeroCarousel()),
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).cardColor.withValues(alpha: 0.5),
          child: BackButton(color: Theme.of(context).iconTheme.color),
        ),
      ),
    );
  }
}

class _LoginHeroCarousel extends StatefulWidget {
  const _LoginHeroCarousel();

  @override
  State<_LoginHeroCarousel> createState() => _LoginHeroCarouselState();
}

class _LoginHeroCarouselState extends State<_LoginHeroCarousel>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late Timer _timer;

  // Data for the carousel with layout configs
  // We use alignments to position elements dynamically
  final List<Map<String, dynamic>> _slides = [
    {
      'text': 'CONECTA', // Was NECESITAS. "Connect" is a strong start.
      'image':
          'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=2664&auto=format&fit=crop', // Meeting
      'textAlign': Alignment.center,
      'logoAlign': const Alignment(0.0, 0.35), // Logo strictly below word
    },
    {
      'text': 'GESTIONA', // Was VENDER. "Manage/Optimize"
      'image':
          'https://images.unsplash.com/photo-1553877615-30c73a63b067?q=80&w=2665&auto=format&fit=crop', // Handshake
      'logoAlign': Alignment.topLeft,
      'textAlign': Alignment.bottomRight,
    },
    {
      'text': 'VENDE', // Was GANAR. Direct benefit.
      'image':
          'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=2671&auto=format&fit=crop', // Team
      'logoAlign': Alignment.center,
      'textAlign': Alignment.bottomCenter,
    },
    {
      'text': 'CRECE', // Was CRECER. Imperative "Grow"
      'image':
          'https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=2670&auto=format&fit=crop', // Modern Office
      'logoAlign': Alignment.topRight,
      'textAlign': Alignment.centerLeft,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _slides.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine theme mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Adapt colors based on theme
    final textColor = isDark ? Colors.white : Colors.black;
    final logoAsset = isDark
        ? 'assets/images/conneck_logo_white.png'
        : 'assets/images/conneck_logo_dark.png';

    // Determine active slide
    final activeSlide = _slides[_currentIndex];
    final Alignment logoAlign = activeSlide['logoAlign'] as Alignment;
    final Alignment textAlign = activeSlide['textAlign'] as Alignment;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Background Image with Animated Switcher
        // We use a Container with a dark color as base to ensure text contrast if image fails
        Container(
          color: isDark ? const Color(0xFF1a1a1a) : const Color(0xFFF5F5F5),
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 1200),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: SizedBox.expand(
            key: ValueKey<String>(activeSlide['image'] as String),
            child: Image.network(
              activeSlide['image'] as String,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox();
              },
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),
        ),

        // 2. Overlay Gradient (Top -> Down for readability)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      // Dark Mode Overlays
                      Colors.black54,
                      Colors.black26,
                      Colors.transparent,
                    ]
                  : [
                      // Light Mode Overlays (White-ish to support black text)
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.3),
                      Colors.transparent,
                    ],
              stops: const [0.0, 0.4, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // 3. "Luminous Shadow" / Seamless Transition (Bottom -> Up)
        // This gradient starts from the scaffold background color and fades up,
        // creating the "ligerito efecto" of blending the carousel into the form.
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 150, // Height of the fade
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
                stops: const [0.0, 0.5, 0.8, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // 3. Dynamic Logo
        AnimatedAlign(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutBack, // Bouncy/Live feel
          alignment: logoAlign,
          child: Padding(
            padding: const EdgeInsets.all(32.0), // Safety padding
            child: Image.asset(
              logoAsset,
              width: 100, // Slightly smaller to fit varied positions
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.rocket_launch, color: textColor, size: 60),
            ),
          ),
        ),

        // 4. Dynamic Masked Text
        AnimatedAlign(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCubic,
          alignment: textAlign,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: _MaskedTextReveal(
              key: ValueKey<String>(activeSlide['text'] as String),
              text: activeSlide['text'] as String,
              textColor: textColor,
            ),
          ),
        ),

        // 5. Progress Indicators / Decor
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_slides.length, (index) {
              final isActive = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 32 : 8,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive ? textColor : textColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _MaskedTextReveal extends StatefulWidget {
  final String text;
  final Color textColor;
  const _MaskedTextReveal({
    super.key,
    required this.text,
    required this.textColor,
  });

  @override
  State<_MaskedTextReveal> createState() => _MaskedTextRevealState();
}

class _MaskedTextRevealState extends State<_MaskedTextReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Slide up effect: starts slightly below (0.5) and moves to center (0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.7),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36, // Slightly adjusted for flexible positioning
              fontWeight: FontWeight.w900,
              color: widget.textColor,
              letterSpacing: 3.0,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: widget.textColor == Colors.black
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black54,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButtonsv2 extends ConsumerWidget {
  final Map<String, dynamic> t;
  final bool isLoading;
  const _SocialButtonsv2({required this.t, required this.isLoading});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: AppButton.outline(
            text: '', // Icon only
            icon: Icons
                .g_mobiledata, // Replace with Google Logo asset if available
            onPressed: isLoading
                ? () {}
                : () => ref
                      .read(loginControllerProvider.notifier)
                      .signInWithGoogle(),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: AppButton.outline(
            text: '',
            icon: Icons.facebook,
            onPressed: () {}, // Facebook placeholder
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: AppButton.outline(
            text: '',
            icon: Icons.apple,
            onPressed: () {}, // Apple placeholder
          ),
        ),
      ],
    );
  }
}
