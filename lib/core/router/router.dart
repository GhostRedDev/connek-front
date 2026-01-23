import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/layout.dart';
import '../widgets/biometric_auth_guard.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/register_page.dart';
import '../../features/auth/forgot_password_page.dart';
import '../../features/auth/reset_password_page.dart';
import '../../features/auth/confirm_phone_page.dart';
import '../../features/home/home_page.dart';
import '../../features/search/search_page.dart';
import '../../features/settings/settings_page.dart';
import '../../features/settings/profile_page.dart';
import '../../features/chat/chat_chats.dart';
import '../../features/chat/chat_page.dart'; // Restore this
import '../../features/notifications/notification_page.dart'; // Added
import '../../features/chat/new_chat_page.dart';
import '../../features/call/pages/call_page.dart'; // Corrected CallPage import

import '../../features/client/client_page.dart';
import '../../features/client/create_request_page.dart';
import '../../features/client/client_booking_service.dart';
import '../../features/client/client_dashboard_requests.dart';
import '../../features/client/client_dashboard_bookmarks.dart';
import '../../features/client/client_dashboard_support.dart'; // Added ClientDashboardSupport
import '../../features/client/client_dashboard_chat.dart';
import '../../features/client/client_dashboard_post.dart';
import '../../features/client/client_dashboard_wallet.dart';
import '../../features/client/client_dashboard_booking.dart';
import '../../features/client/checkout_resume.dart';
import '../../features/client/pages/client_request_details_page.dart';
import '../../features/client/models/service_request_model.dart';
import '../../features/business/business_page.dart';
import '../../features/business/payment_method_list.dart';
import '../../features/business/business_profile_page.dart';
import '../../features/business/business_sheet_create_service.dart';
import '../../features/business/business_sheet_create_portfolio.dart';
import '../../features/business/business_dashboard_employees.dart';
import '../../features/business/business_dashboard_services.dart';
import '../../features/business/business_dashboard_add_services.dart';
import '../../features/business/business_dashboard_leads.dart'; // Added
import '../../features/business/create_business_d_cover.dart';
import '../../features/business/wizard/create_business_step_1.dart';
import '../../features/business/wizard/create_business_step_2.dart';
import '../../features/business/wizard/create_business_step_3.dart';
import '../../features/business/wizard/create_business_step_4.dart';
import '../../features/business/wizard/create_business_step_5.dart';
import '../../features/business/wizard/create_business_step_6.dart';
import '../../features/business/wizard/create_business_step_7.dart';
import '../../features/business/wizard/create_business_step_8.dart';
import '../../features/office/office_page.dart';
import '../../features/office/widgets/office_train_greg_page.dart';
import '../../features/office/widgets/office_settings_greg_page.dart';

// Providers for Redirection Logic
import '../providers/user_mode_provider.dart';
import '../../features/settings/providers/profile_provider.dart';
import '../../features/shared/pages/booking_details_page.dart';
import '../../features/client/pages/business_profile_view.dart';

// Global Key for Root Navigator (to cover shell)
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
bool _isFirstLoad = true; // Track initial app load

final routerProvider = Provider<GoRouter>((ref) {
  // DO NOT watch providers here to avoid recreating GoRouter on every change.
  // Instead, read them inside the redirect callback.

  return GoRouter(
    navigatorKey: rootNavigatorKey, // Use key
    initialLocation: '/',
    // Refresh listener for auth changes (optional but good practice)
    refreshListenable: GoRouterRefreshStream(
      Supabase.instance.client.auth.onAuthStateChange,
    ),
    redirect: (context, state) {
      // Force Home on Initial Load (Disable Deep Linking/Persistence on Reload)
      if (_isFirstLoad) {
        _isFirstLoad = false;
        if (state.uri.toString() != '/') {
          return '/';
        }
      }

      final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
      final isBusinessRoute = state.uri.toString().startsWith('/business');
      final isOfficeRoute = state.uri.toString().startsWith('/office');

      // Access current state via ref.read
      final userMode = ref.read(userModeProvider);
      final profileAsync = ref.read(profileProvider);

      // 1. Basic Auth Guard
      // If needed, but generally we allow guest access to home/search.
      // Assuming business/office/client are protected by Supabase RLS anyway,
      // but UI redirection is nicer.

      if (!isLoggedIn) {
        if (isBusinessRoute ||
            isOfficeRoute ||
            state.uri.toString().startsWith('/client')) {
          return '/login';
        }
      }

      // 2. Business Route Protection
      if (isBusinessRoute && isLoggedIn) {
        // Must be in Business Mode
        if (!userMode) {
          // If in Client Mode, redirect to Client Dashboard or Home
          return '/client';
        }

        // Must have Business Profile (Check loaded profile)
        // If profile is loading, we might want to wait or show loading, but redirect is sync-ish.
        // We'll rely on the fact that if data is available and hasBusiness is false, we block.
        // If loading, we let it pass for now and let the page handle empty states, OR block safely.

        if (profileAsync.hasValue) {
          final profile = profileAsync.value;
          if (profile != null && !profile.hasBusiness) {
            // User trying to access business but has no business -> maybe create one?
            // For now, redirect to create business or home.
            // If we want to allow access to "create business", we need an exception.
            if (!state.uri.toString().startsWith('/business/create')) {
              // Redirect to Wizard Step 1 if they have no business?
              // Or just kick to client.
              return '/business/create/step1';
            }
          }
        }
      }

      // 3. Office Route Protection (Admin only - Stubbed)
      // if (isOfficeRoute) { ... }

      return null; // No redirect
    },
    routes: [
      // --- UNAUTHORIZED ROUTES (No App Bar/NavBar) ---
      // Note: '/' is now the Unified Home inside the Shell
      // Auth Routes moved to ShellRoute for consistent layout

      // Call Route (Full Screen, No Shell)
      GoRoute(
        path: '/call/:id',
        builder: (context, state) {
          final callId = state.pathParameters['id'] ?? '';
          final isCaller = state.uri.queryParameters['isCaller'] == 'true';
          // Default to true if not specified (or check explicit 'false')
          final isVideo = state.uri.queryParameters['isVideo'] != 'false';
          return CallPage(callId: callId, isCaller: isCaller, isVideo: isVideo);
        },
      ),

      // New Chat (Full Screen, No Shell)
      GoRoute(
        path: '/chats/new',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NewChatPage(),
      ),

      // --- AUTHORIZED & GUEST (Unified Shell) ---
      ShellRoute(
        builder: (context, state, child) {
          return BiometricAuthGuard(
            child: AppLayout(currentPath: state.uri.toString(), child: child),
          );
        },
        routes: [
          // Unified Home Page (Handles both Guest and Auth views)
          GoRoute(path: '/', builder: (context, state) => const HomePage()),

          // Auth Routes (Now using AppLayout)
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/forgot-password',
            builder: (context, state) => const ForgotPasswordPage(),
          ),
          GoRoute(
            path: '/reset-password',
            builder: (context, state) => const ResetPasswordPage(),
          ),
          GoRoute(
            path: '/confirm-phone',
            builder: (context, state) => const ConfirmPhonePage(),
          ),
          GoRoute(
            path: '/office',
            builder: (context, state) => const OfficePage(),
            routes: [
              GoRoute(
                path: 'train-greg',
                builder: (context, state) => const OfficeTrainGregPage(),
              ),
              GoRoute(
                path: 'settings-greg',
                builder: (context, state) => const OfficeSettingsGregPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) =>
                ProfilePage(initialTab: state.uri.queryParameters['tab']),
          ),
          GoRoute(
            path: '/chats',
            builder: (context, state) => const ChatChats(),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: ChatPage(chatId: state.pathParameters['id'] ?? ''),
                    transitionDuration: const Duration(milliseconds: 200),
                    reverseTransitionDuration: const Duration(
                      milliseconds: 200,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: Curves.easeOutQuad));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationPage(),
          ),

          // Client Routes (Usually mapped to 'Buy')
          GoRoute(
            path: '/client',
            builder: (context, state) => const ClientPage(),
            routes: [
              GoRoute(
                path: 'request',
                builder: (context, state) => const CreateRequestPage(),
              ),
              GoRoute(
                path: 'booking',
                builder: (context, state) => const ClientBookingService(),
              ),
              GoRoute(
                path: 'dashboard/requests',
                builder: (context, state) => const ClientDashboardRequests(),
              ),
              GoRoute(
                path: 'dashboard/support',
                builder: (context, state) => const ClientDashboardSupport(),
              ),
              GoRoute(
                path: 'dashboard/chat',
                builder: (context, state) => const ClientDashboardChat(),
              ),
              GoRoute(
                path: 'dashboard/post',
                builder: (context, state) => const ClientDashboardPost(),
              ),
              GoRoute(
                path: 'dashboard/wallet',
                builder: (context, state) => const ClientDashboardWallet(),
              ),
              GoRoute(
                path: 'dashboard/bookmarks',
                builder: (context, state) {
                  print('Navigating to Bookmarks');
                  return const ClientDashboardBookmarks();
                },
              ),
              GoRoute(
                path: 'dashboard/booking', // Matches existing link
                builder: (context, state) => const ClientDashboardBooking(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => BookingDetailsPage(
                      bookingId: state.pathParameters['id'] ?? '',
                      isClientView: true,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'checkout',
                builder: (context, state) => const CheckoutResume(),
              ),
              GoRoute(
                path: 'request-details',
                builder: (context, state) {
                  final request = state.extra as ServiceRequest;
                  return ClientRequestDetailsPage(request: request);
                },
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => const ClientPage(),
              ),
              GoRoute(
                path: 'business/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return BusinessProfileView(businessId: id);
                },
              ),
            ],
          ),

          // Business Routes (Usually mapped to 'Sell')
          GoRoute(
            path: '/business',
            builder: (context, state) => const BusinessPage(),
            routes: [
              GoRoute(
                path: 'profile',
                builder: (context, state) => const BusinessProfilePage(),
              ),
              GoRoute(
                path: 'create-service',
                builder: (context, state) => const BusinessSheetCreateService(),
              ),
              GoRoute(
                path: 'create-portfolio',
                builder: (context, state) =>
                    const BusinessSheetCreatePortfolio(),
              ),
              GoRoute(
                path: 'employees',
                builder: (context, state) => const BusinessDashboardEmployees(),
              ),
              GoRoute(
                path: 'services',
                builder: (context, state) => const BusinessDashboardServices(),
              ),
              GoRoute(
                path: 'add-services',
                builder: (context, state) =>
                    const BusinessDashboardAddServices(),
              ),
              GoRoute(
                path: 'cover',
                builder: (context, state) => const CreateBusinessDCover(),
              ),
              GoRoute(
                path: 'leads',
                builder: (context, state) => const BusinessDashboardLeads(),
              ),
              GoRoute(
                path: 'bookings/:id',
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) => BookingDetailsPage(
                  bookingId: state.pathParameters['id'] ?? '',
                  isClientView: false,
                ),
              ),
              // Wizard
              GoRoute(
                path: 'create/step1',
                builder: (context, state) => const CreateBusinessStep1(),
              ),
              GoRoute(
                path: 'create/step2',
                builder: (context, state) => const CreateBusinessStep2(),
              ),
              GoRoute(
                path: 'create/step3',
                builder: (context, state) => const CreateBusinessStep3(),
              ),
              GoRoute(
                path: 'create/step4',
                builder: (context, state) => const CreateBusinessStep4(),
              ),
              GoRoute(
                path: 'create/step5',
                builder: (context, state) => const CreateBusinessStep5(),
              ),
              GoRoute(
                path: 'create/step6',
                builder: (context, state) => const CreateBusinessStep6(),
              ),
              GoRoute(
                path: 'create/step7',
                builder: (context, state) => const CreateBusinessStep7(),
              ),
              GoRoute(
                path: 'create/step8',
                builder: (context, state) => const CreateBusinessStep8(),
              ),
            ],
          ),

          GoRoute(
            path: '/payments',
            builder: (context, state) => const PaymentMethodList(),
          ),
        ],
      ),
    ],
  );
});

// Helper for stream listening
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
