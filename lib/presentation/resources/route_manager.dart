import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/domain/provider/auth_provider.dart';
import 'package:inside_1/presentation/exhibition_screen/exhibition_screen.dart';
import 'package:inside_1/presentation/explore/explore.dart';
import 'package:inside_1/presentation/home/home.dart';
import 'package:inside_1/presentation/login/login.dart';
import 'package:inside_1/presentation/profile/profile.dart';
import 'package:inside_1/presentation/signup/signup.dart';
import 'package:inside_1/presentation/welcome/welcome.dart';
import 'package:inside_1/presentation/payment_page/payment_page.dart';
import 'package:inside_1/presentation/payment_success/payment_success.dart';
import 'package:inside_1/presentation/widgets/root_layout.dart';

class AppPageRoutePath {
  static const String welcome = '/welcome';
  static const String login = 'login';
  static const String createAccount = 'createAccount';
  static const String home = '/home';
  static const String signup = 'signUp';
  static const String explore = '/explore';
  static const String profile = '/profile';
  static const String paymentPage = 'paymentPage';
  static const String paymentSuccess = 'paymentSuccess';

  static const String exhibitionScreen = 'exhibitionScreen';
}

class AppPageRouteName {
  static const String welcome = 'Welcome';
  static const String login = 'Login';
  static const String createAccount = 'CreateAccount';
  static const String home = 'Home';
  static const String signup = 'SignUp';

  static const String explore = 'Explore';
  static const String profile = 'Profile';

  static const String exhibitionScreen = 'ExhibitionScreen';
  static const String paymentPage = 'PaymentPage';
  static const String paymentSuccess = 'PaymentSuccess';
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppPageRoutePath.home,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (BuildContext context, GoRouterState state, Widget child) =>
          MaterialPage(
        key: state.pageKey,
        child: RootLayout(body: child),
      ),
      routes: [
        GoRoute(
            name: AppPageRouteName.home,
            path: AppPageRoutePath.home,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                CustomTransitionPage(
                  key: state.pageKey,
                  child: const Home(),
                  transitionsBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child,
                  ) =>
                      FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  ),
                ),
            routes: [
              GoRoute(
                name: AppPageRouteName.exhibitionScreen,
                path: AppPageRoutePath.exhibitionScreen,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  Exhibition exhibition = state.extra as Exhibition;
                  return MaterialPage(
                    key: state.pageKey,
                    child: ExhibitionScreen(exhibition: exhibition),
                  );
                },
              ),
              GoRoute(
                name: AppPageRouteName.paymentPage,
                path: AppPageRoutePath.paymentPage,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: PaymentPage(),
                  );
                },
              ),
              // GoRoute(
              //   name: AppPageRouteName.paymentSuccess,
              //   path: AppPageRoutePath.paymentSuccess,
              //   pageBuilder: (BuildContext context, GoRouterState state) {
              //     return MaterialPage(
              //       key: state.pageKey,
              //       child: Payment(),
              //     );
              //   },
              // ),
            ]),
        GoRoute(
          name: AppPageRouteName.explore,
          path: AppPageRoutePath.explore,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const Explore(),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            ),
          ),
        ),
        GoRoute(
          name: AppPageRouteName.profile,
          path: AppPageRoutePath.profile,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const Profile(),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      name: AppPageRouteName.welcome,
      path: AppPageRoutePath.welcome,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage(
          key: state.pageKey,
          child: const Welcome(),
        );
      },
      routes: [
        GoRoute(
          name: AppPageRouteName.login,
          path: AppPageRoutePath.login,
          pageBuilder: (BuildContext context, GoRouterState state) {
            initLoginModule();
            return MaterialPage(
              key: state.pageKey,
              child: LoginView(),
            );
          },
        ),
        GoRoute(
          name: AppPageRouteName.signup,
          path: AppPageRoutePath.signup,
          pageBuilder: (BuildContext context, GoRouterState state) {
            initSignupModule();
            return MaterialPage(
              key: state.pageKey,
              child: SignupView(),
            );
          },
        ),

      ],
    ),
  ],
  redirect: (context, state) {
    final isLoggedIn = instance<AuthState>().isLoggedIn;
    final bool toWelcome = state.matchedLocation == '/welcome';
    final bool logging = state.matchedLocation == '/welcome/login';
    final bool inForgotPassword =
        state.matchedLocation == '/welcome/login/forgotPassword';
    final bool registering = state.matchedLocation == '/welcome/signUp';

    if (!isLoggedIn) {
      // user is not logged in
      if (toWelcome || registering || logging || inForgotPassword) {
        return null;
      }
      return AppPageRoutePath.welcome;
    }
    if (registering || logging) {
      // user is logged in but still going to the welcome screen
      return AppPageRoutePath.home;
    }
    return null;
  },
  refreshListenable: instance<AuthState>(),
);
