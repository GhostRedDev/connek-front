import 'package:go_router/go_router.dart';
import '../../features/auth/home_page_no_auth.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/register_page.dart';
import '../../features/auth/forgot_password_page.dart';
import '../../features/auth/reset_password_page.dart';
import '../../features/auth/confirm_phone_page.dart';
import '../../features/home/home_page.dart';
import '../../features/home/search_page.dart';
import '../../features/settings/settings_page.dart';
import '../../features/settings/profile_page.dart';
import '../../features/chat/chat_chats.dart';
import '../../features/chat/chat_page.dart';
import '../../features/client/client_page.dart';
import '../../features/client/create_request_page.dart';
import '../../features/client/client_booking_service.dart';
import '../../features/client/client_dashboard_requests.dart';
import '../../features/client/client_dashboard_chat.dart';
import '../../features/client/client_dashboard_post.dart';
import '../../features/client/client_dashboard_wallet.dart';
import '../../features/client/client_dashboard_booking.dart';
import '../../features/client/checkout_resume.dart';
import '../../features/business/business_page.dart';
import '../../features/business/payment_method_list.dart';
import '../../features/business/business_profile_page.dart';
import '../../features/business/business_sheet_create_service.dart';
import '../../features/business/business_sheet_create_portfolio.dart';
import '../../features/business/business_dashboard_employees.dart';
import '../../features/business/business_dashboard_services.dart';
import '../../features/business/business_dashboard_add_services.dart';
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
import '../../features/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const HomePageNoAuth(),
    ),
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
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/office',
      builder: (context, state) => const OfficePage(),
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
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/chats',
      builder: (context, state) => const ChatChats(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) => ChatPage(
            chatId: state.pathParameters['id'] ?? '',
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/client',
      builder: (context, state) => const ClientPage(clientId: 'current'),
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
          path: 'dashboard/booking',
          builder: (context, state) => const ClientDashboardBooking(),
        ),
        GoRoute(
          path: 'checkout',
          builder: (context, state) => const CheckoutResume(),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) => ClientPage(
            clientId: state.pathParameters['id'] ?? '',
          ),
        ),
      ]
    ),
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
          builder: (context, state) => const BusinessSheetCreatePortfolio(),
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
          builder: (context, state) => const BusinessDashboardAddServices(),
        ),
        GoRoute(
          path: 'cover',
          builder: (context, state) => const CreateBusinessDCover(),
        ),
        // Wizard routes
        GoRoute(path: 'create/step1', builder: (context, state) => const CreateBusinessStep1()),
        GoRoute(path: 'create/step2', builder: (context, state) => const CreateBusinessStep2()),
        GoRoute(path: 'create/step3', builder: (context, state) => const CreateBusinessStep3()),
        GoRoute(path: 'create/step4', builder: (context, state) => const CreateBusinessStep4()),
        GoRoute(path: 'create/step5', builder: (context, state) => const CreateBusinessStep5()),
        GoRoute(path: 'create/step6', builder: (context, state) => const CreateBusinessStep6()),
        GoRoute(path: 'create/step7', builder: (context, state) => const CreateBusinessStep7()),
        GoRoute(path: 'create/step8', builder: (context, state) => const CreateBusinessStep8()),
      ],
    ),
    GoRoute(
      path: '/payments',
      builder: (context, state) => const PaymentMethodList(),
    ),
  ],
);
