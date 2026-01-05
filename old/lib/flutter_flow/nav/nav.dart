import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const HomePageWidget() : const HomePageNoAuthWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? const HomePageWidget()
              : const HomePageNoAuthWidget(),
          routes: [
            FFRoute(
              name: HomePageWidget.routeName,
              path: HomePageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const HomePageWidget(),
            ),
            FFRoute(
              name: HomePageNoAuthWidget.routeName,
              path: HomePageNoAuthWidget.routePath,
              builder: (context, params) => const HomePageNoAuthWidget(),
            ),
            FFRoute(
              name: SearchResultsPageWidget.routeName,
              path: SearchResultsPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SearchResultsPageWidget(
                searchValue: params.getParam(
                  'searchValue',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: Createbusiness1Widget.routeName,
              path: Createbusiness1Widget.routePath,
              requireAuth: true,
              builder: (context, params) => const Createbusiness1Widget(),
            ),
            FFRoute(
              name: TestpageWidget.routeName,
              path: TestpageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const TestpageWidget(),
            ),
            FFRoute(
              name: LoadingPageWidget.routeName,
              path: LoadingPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => LoadingPageWidget(
                textvalue: params.getParam(
                  'textvalue',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: LoadingWidget.routeName,
              path: LoadingWidget.routePath,
              requireAuth: true,
              builder: (context, params) => LoadingWidget(
                textvalue: params.getParam(
                  'textvalue',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: SmartSearchLoadingWidget.routeName,
              path: SmartSearchLoadingWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SmartSearchLoadingWidget(
                textvalue: params.getParam(
                  'textvalue',
                  ParamType.String,
                ),
                prompt: params.getParam(
                  'prompt',
                  ParamType.String,
                ),
                category: params.getParam(
                  'category',
                  ParamType.String,
                ),
                questions: params.getParam(
                  'questions',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: SearchWithGradientWidget.routeName,
              path: SearchWithGradientWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const SearchWithGradientWidget(),
            ),
            FFRoute(
              name: BusinessDashboardEmployeeWidget.routeName,
              path: BusinessDashboardEmployeeWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const BusinessDashboardEmployeeWidget(),
            ),
            FFRoute(
              name: LoginPageNewWidget.routeName,
              path: LoginPageNewWidget.routePath,
              builder: (context, params) => const LoginPageNewWidget(),
            ),
            FFRoute(
              name: RegisterPageWidget.routeName,
              path: RegisterPageWidget.routePath,
              builder: (context, params) => const RegisterPageWidget(),
            ),
            FFRoute(
              name: BusinessProfileNewWidget.routeName,
              path: BusinessProfileNewWidget.routePath,
              requireAuth: true,
              builder: (context, params) => BusinessProfileNewWidget(
                businessId: params.getParam(
                  'businessId',
                  ParamType.int,
                ),
                businessData: params.getParam(
                  'businessData',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: BusinessDataStruct.fromSerializableMap,
                ),
                servicesData: params.getParam<ServiceDataStruct>(
                  'servicesData',
                  ParamType.DataStruct,
                  isList: true,
                  structBuilder: ServiceDataStruct.fromSerializableMap,
                ),
              ),
            ),
            FFRoute(
              name: CreateBusiness0CoverWidget.routeName,
              path: CreateBusiness0CoverWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const CreateBusiness0CoverWidget(),
            ),
            FFRoute(
              name: CreateBusiness2Widget.routeName,
              path: CreateBusiness2Widget.routePath,
              requireAuth: true,
              builder: (context, params) => const CreateBusiness2Widget(),
            ),
            FFRoute(
              name: CreateBusiness3Widget.routeName,
              path: CreateBusiness3Widget.routePath,
              requireAuth: true,
              builder: (context, params) => const CreateBusiness3Widget(),
            ),
            FFRoute(
              name: CreateBusiness4Widget.routeName,
              path: CreateBusiness4Widget.routePath,
              requireAuth: true,
              builder: (context, params) => const CreateBusiness4Widget(),
            ),
            FFRoute(
              name: CreateBusiness5Widget.routeName,
              path: CreateBusiness5Widget.routePath,
              requireAuth: true,
              builder: (context, params) => const CreateBusiness5Widget(),
            ),
            FFRoute(
              name: CreateBusiness6Widget.routeName,
              path: CreateBusiness6Widget.routePath,
              requireAuth: true,
              builder: (context, params) => const CreateBusiness6Widget(),
            ),
            FFRoute(
              name: CreateBusiness7Widget.routeName,
              path: CreateBusiness7Widget.routePath,
              requireAuth: true,
              builder: (context, params) => CreateBusiness7Widget(
                businessName: params.getParam(
                  'businessName',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: CreateBusiness8Widget.routeName,
              path: CreateBusiness8Widget.routePath,
              requireAuth: true,
              builder: (context, params) => const CreateBusiness8Widget(),
            ),
            FFRoute(
              name: BusinessDashboardLeadDetailWidget.routeName,
              path: BusinessDashboardLeadDetailWidget.routePath,
              requireAuth: true,
              builder: (context, params) => BusinessDashboardLeadDetailWidget(
                leadDetail: params.getParam(
                  'leadDetail',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: BusinessLeadsStruct.fromSerializableMap,
                ),
                leadId: params.getParam(
                  'leadId',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: BusinessDashboardLeadSendPropWidget.routeName,
              path: BusinessDashboardLeadSendPropWidget.routePath,
              requireAuth: true,
              builder: (context, params) => BusinessDashboardLeadSendPropWidget(
                lead: params.getParam(
                  'lead',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: BusinessLeadsStruct.fromSerializableMap,
                ),
              ),
            ),
            FFRoute(
              name: BusinessDashboardGregManageWidget.routeName,
              path: BusinessDashboardGregManageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => BusinessDashboardGregManageWidget(
                chatbotData: params.getParam(
                  'chatbotData',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: ChatbotDataStruct.fromSerializableMap,
                ),
              ),
            ),
            FFRoute(
              name: BusinessDashboardServicesWidget.routeName,
              path: BusinessDashboardServicesWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const BusinessDashboardServicesWidget(),
            ),
            FFRoute(
              name: ClientDashboardNotificationsWidget.routeName,
              path: ClientDashboardNotificationsWidget.routePath,
              requireAuth: true,
              builder: (context, params) =>
                  const ClientDashboardNotificationsWidget(),
            ),
            FFRoute(
              name: BusinessDashboardAddServicesWidget.routeName,
              path: BusinessDashboardAddServicesWidget.routePath,
              requireAuth: true,
              builder: (context, params) => BusinessDashboardAddServicesWidget(
                service: params.getParam(
                  'service',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: ServiceDataStruct.fromSerializableMap,
                ),
                serviceId: params.getParam(
                  'serviceId',
                  ParamType.int,
                ),
                create: params.getParam(
                  'create',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: ClientDashboardRequestWidget.routeName,
              path: ClientDashboardRequestWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ClientDashboardRequestWidget(),
            ),
            FFRoute(
              name: ClientDashboardChatsWidget.routeName,
              path: ClientDashboardChatsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ClientDashboardChatsWidget(),
            ),
            FFRoute(
              name: ClientDashboardPostWidget.routeName,
              path: ClientDashboardPostWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ClientDashboardPostWidget(),
            ),
            FFRoute(
              name: ClientDashboardWalletWidget.routeName,
              path: ClientDashboardWalletWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ClientDashboardWalletWidget(),
            ),
            FFRoute(
              name: CheckoutResumeWidget.routeName,
              path: CheckoutResumeWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CheckoutResumeWidget(
                quote: params.getParam(
                  'quote',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: QuoteFullDataStruct.fromSerializableMap,
                ),
                requestId: params.getParam(
                  'requestId',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: CheckoutSelectPaymentMethodWidget.routeName,
              path: CheckoutSelectPaymentMethodWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const CheckoutSelectPaymentMethodWidget(),
            ),
            FFRoute(
              name: CheckoutSuccessWidget.routeName,
              path: CheckoutSuccessWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CheckoutSuccessWidget(
                transactionId: params.getParam(
                  'transactionId',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: ClientDashboardBookingWidget.routeName,
              path: ClientDashboardBookingWidget.routePath,
              requireAuth: true,
              builder: (context, params) => ClientDashboardBookingWidget(
                request: params.getParam(
                  'request',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: ClientRequestStruct.fromSerializableMap,
                ),
                quote: params.getParam(
                  'quote',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: ClientRequestQuoteStruct.fromSerializableMap,
                ),
                business: params.getParam(
                  'business',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: BusinessDataStruct.fromSerializableMap,
                ),
              ),
            ),
            FFRoute(
              name: CreateRequestWidget.routeName,
              path: CreateRequestWidget.routePath,
              requireAuth: true,
              builder: (context, params) => CreateRequestWidget(
                serviceSelected: params.getParam(
                  'serviceSelected',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: ServiceDataStruct.fromSerializableMap,
                ),
                business: params.getParam(
                  'business',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: BusinessDataStruct.fromSerializableMap,
                ),
              ),
            ),
            FFRoute(
              name: ClientBookWidget.routeName,
              path: ClientBookWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ClientBookWidget(),
            ),
            FFRoute(
              name: ClientDashboardWalletMethodsWidget.routeName,
              path: ClientDashboardWalletMethodsWidget.routePath,
              requireAuth: true,
              builder: (context, params) =>
                  const ClientDashboardWalletMethodsWidget(),
            ),
            FFRoute(
              name: SearchResults2Widget.routeName,
              path: SearchResults2Widget.routePath,
              builder: (context, params) => SearchResults2Widget(
                prompt: params.getParam(
                  'prompt',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: BusinessProfileNewPageWidget.routeName,
              path: BusinessProfileNewPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => BusinessProfileNewPageWidget(
                businessId: params.getParam(
                  'businessId',
                  ParamType.int,
                ),
                businessData: params.getParam(
                  'businessData',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: BusinessDataStruct.fromSerializableMap,
                ),
                servicesData: params.getParam<ServiceDataStruct>(
                  'servicesData',
                  ParamType.DataStruct,
                  isList: true,
                  structBuilder: ServiceDataStruct.fromSerializableMap,
                ),
              ),
            ),
            FFRoute(
              name: ChatPageWidget.routeName,
              path: ChatPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ChatPageWidget(),
            ),
            FFRoute(
              name: ChatChatsWidget.routeName,
              path: ChatChatsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ChatChatsWidget(),
            ),
            FFRoute(
              name: ClientBookingServiceWidget.routeName,
              path: ClientBookingServiceWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ClientBookingServiceWidget(),
            ),
            FFRoute(
              name: ClientDashboardRequestDetail2Widget.routeName,
              path: ClientDashboardRequestDetail2Widget.routePath,
              requireAuth: true,
              builder: (context, params) => ClientDashboardRequestDetail2Widget(
                request: params.getParam(
                  'request',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: ClientRequestStruct.fromSerializableMap,
                ),
              ),
            ),
            FFRoute(
              name: CheckoutDESKTOPWidget.routeName,
              path: CheckoutDESKTOPWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const CheckoutDESKTOPWidget(),
            ),
            FFRoute(
              name: ForgotPasswordWidget.routeName,
              path: ForgotPasswordWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ForgotPasswordWidget(),
            ),
            FFRoute(
              name: ResetPasswordPageWidget.routeName,
              path: ResetPasswordPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ResetPasswordPageWidget(),
            ),
            FFRoute(
              name: ConfirmPhoneNumberWidget.routeName,
              path: ConfirmPhoneNumberWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ConfirmPhoneNumberWidget(),
            ),
            FFRoute(
              name: ConfirmEmailWidget.routeName,
              path: ConfirmEmailWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ConfirmEmailWidget(),
            ),
            FFRoute(
              name: ProfilePageWidget.routeName,
              path: ProfilePageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ProfilePageWidget(),
            ),
            FFRoute(
              name: SettingsPageWidget.routeName,
              path: SettingsPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const SettingsPageWidget(),
            ),
            FFRoute(
              name: ClientPageWidget.routeName,
              path: ClientPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const ClientPageWidget(),
            ),
            FFRoute(
              name: BusinessPageWidget.routeName,
              path: BusinessPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const BusinessPageWidget(),
            ),
            FFRoute(
              name: PaginatestWidget.routeName,
              path: PaginatestWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const PaginatestWidget(),
            ),
            FFRoute(
              name: OfficePageWidget.routeName,
              path: OfficePageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const OfficePageWidget(),
            ),
            FFRoute(
              name: BusinessLeadDetailWidget.routeName,
              path: BusinessLeadDetailWidget.routePath,
              requireAuth: true,
              builder: (context, params) => BusinessLeadDetailWidget(
                leadDetail: params.getParam(
                  'leadDetail',
                  ParamType.DataStruct,
                  isList: false,
                  structBuilder: BusinessLeadsStruct.fromSerializableMap,
                ),
                leadId: params.getParam(
                  'leadId',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: SearchPageWidget.routeName,
              path: SearchPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => SearchPageWidget(
                prompt: params.getParam(
                  'prompt',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: BusinessPublicPageWidget.routeName,
              path: BusinessPublicPageWidget.routePath,
              builder: (context, params) => BusinessPublicPageWidget(
                businessId: params.getParam(
                  'businessId',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: RequestPageWidget.routeName,
              path: RequestPageWidget.routePath,
              requireAuth: true,
              builder: (context, params) => const RequestPageWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/homePageNoAuth';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_connek_definitivo.jpg',
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
