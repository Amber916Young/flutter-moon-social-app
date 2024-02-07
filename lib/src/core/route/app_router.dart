import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/src/core/component/not_found.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:moon/src/features/auth/presentation/screen/create_account_screen.dart';
import 'package:moon/src/features/auth/presentation/screen/login_screen.dart';
import 'package:moon/src/features/auth/presentation/screen/maintainance_screen.dart';
import 'package:moon/src/features/auth/presentation/screen/phone_login_screen.dart';
import 'package:moon/src/features/auth/presentation/screen/register_screen.dart';
import 'package:moon/src/features/home/presentation/screen/home_detail_screen.dart';
import 'package:moon/src/features/home/presentation/screen/home_screen.dart';
import 'package:moon/src/features/home/presentation/screen/post_write_screen.dart';
import 'package:moon/src/features/home/presentation/screen/video_detail_screen.dart';
import 'package:moon/src/features/language/choose_language_screen.dart';
import 'package:moon/src/features/message/presentation/screen/chat_screen.dart';
import 'package:moon/src/features/message/presentation/screen/message_screen.dart';
import 'package:moon/src/features/profile/presentation/edit_profile_screen.dart';
import 'package:moon/src/features/profile/presentation/my_friends_screen.dart';
import 'package:moon/src/features/profile/presentation/profile_screen.dart';
import 'package:moon/src/features/splash/presentation/screen/Invalid_sreen.dart';
import 'package:moon/src/features/splash/presentation/screen/splash_screen.dart';
import 'package:provider/provider.dart';

class RouteUri {
  static const String home = '/';
  static const String main = '/home';
  static const String splash = '/splash';

  static const String error404 = '/404';
  static const String invalid = '/invalid';

  static const String login = '/login';
  static const String phoneLogin = '/login-phone';
  static const String register = '/sign-up';
  static const String forgotPass = '/forgot-password';
  static const String createNewPass = '/create-new-password';
  static const String createAccount = '/create-account';
  static const String verify = '/verify';
  static const String maintain = '/maintain';
  static const String notification = '/notification';
  static const String videoScreen = '/video';
  static const String postWriteScreen = '/post-write';

  static const String chatMessageScreen = '/chat';

  static const String myProfile = '/profile';
  static const String editProfile = '/profile-edit';
  static const String friendsList = '/friends';
  static const String postDetailScreen = '/post-details';

  static const String menu = '/menu';
}

const List<String> unrestrictedRoutes = [
  RouteUri.error404,
  RouteUri.login,
  RouteUri.invalid,
  RouteUri.register,
  RouteUri.home,
  RouteUri.splash,
  RouteUri.createNewPass,
  RouteUri.createAccount,
  RouteUri.notification,
  RouteUri.postWriteScreen,
  RouteUri.forgotPass,
  RouteUri.maintain,
  RouteUri.main,
  RouteUri.verify,
];

const List<String> publicRoutes = [
  // RouteUri.login, // Enable this line for actual authentication flow.
  // RouteUri.register, // Enable this line for actual authentication flow.
];

GoRouter appRouter(navigatorKey) {
  return GoRouter(
    initialLocation: RouteUri.home,
    errorPageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: const NotFound(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
    ),
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: RouteUri.home,
        redirect: (context, state) => RouteUri.login,
      ),
      GoRoute(
        path: RouteUri.main,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.invalid,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const InvalidJumpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.splash,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.postDetailScreen,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const PostDetailScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.menu,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const ChooseLanguageScreen(fromMenu: true),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.friendsList,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const ChatMessageScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.editProfile,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const EditProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.friendsList,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const MyFriendsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.editProfile,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const EditProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.myProfile,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.videoScreen,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const VideoScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.notification,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const MessageScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.phoneLogin,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const PhoneLoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.login,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: RouteUri.register,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const RegisterScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteUri.maintain,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const MaintenanceScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteUri.createAccount,
        pageBuilder: (context, state) {
          String? email = "12324";
          // try {
          //   email = utf8.decode(base64Decode(state.queryParameters['email']!));
          // } catch (error) {
          //   email = null;
          // }
          // if (email == null) {
          //   return CustomTransitionPage<void>(
          //     key: state.pageKey,
          //     child: const SplashScreen(),
          //     transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
          //   );
          // }
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: CreateAccountScreen(email: email),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: RouteUri.postWriteScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const PostWriteScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      // GoRoute(
      //   path: RouteUri.verify,
      //   pageBuilder: (context, state) {
      //     return CustomTransitionPage<void>(
      //       key: state.pageKey,
      //       child: VerificationScreen(
      //         fromSignUp: state.queryParameters['page'] == 'sign-up',
      //         emailAddress: jsonDecode(state.queryParameters['email'] ?? ''),
      //       ),
      //       transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: RouteUri.createNewPass,
      //   pageBuilder: (context, state) {
      //     CreateNewPasswordScreen? createPassScreen = ModalRoute.of(context)!.settings.arguments as CreateNewPasswordScreen?;
      //     return CustomTransitionPage<void>(
      //       key: state.pageKey,
      //       child: createPassScreen ??
      //           CreateNewPasswordScreen(
      //             email: state.queryParameters['email'],
      //             resetToken: state.queryParameters['token'],
      //           ),
      //       transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: RouteUri.forgotPass,
      //   pageBuilder: (context, state) => CustomTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const ForgotPasswordScreen(),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
      //   ),
      // ),
    ],
    redirect: (context, state) {
      bool isLoggedIn = true;
      // bool isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      if (unrestrictedRoutes.contains(state.matchedLocation)) {
        return null;
      } else if (publicRoutes.contains(state.matchedLocation)) {
        if (isLoggedIn) {
          return RouteUri.home;
        }
      } else {
        if (!isLoggedIn) {
          return RouteUri.login;
        }
      }
      return null;
    },
  );
}
