import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/route/routes.dart';
import 'package:moon/src/features/auth/presentation/screen/login_screen.dart';
import 'package:moon/src/features/auth/presentation/screen/phone_login_screen.dart';
import 'package:provider/provider.dart';
import 'package:moon/src/features/auth/presentation/screen/register_screen.dart';
import 'package:moon/src/features/home/presentation/home_detail_screen.dart';
import 'package:moon/src/features/home/presentation/home_screen.dart';
import 'package:moon/src/features/home/presentation/video_detail_screen.dart';
import 'package:moon/src/features/language/choose_language_screen.dart';
import 'package:moon/src/features/profile/presentation/edit_profile_screen.dart';
import 'package:moon/src/features/profile/presentation/my_friends_screen.dart';
import 'package:moon/src/features/profile/presentation/profile_screen.dart';
import 'responsive_helper.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();
  static final Handler _homeHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, HomeScreen()),
  );
  static final Handler _loginHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, LoginScreen()),
  );
  static final Handler _phoneLoginHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, PhoneLoginScreen()),
  );
  static final Handler _registerHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, RegisterScreen()),
  );
  static final Handler _profileHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, ProfileScreen()),
  );
  static final Handler _editProfileHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, EditProfileScreen()),
  );

  static final Handler _myFriendsHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, MyFriendsScreen()),
  );
  static final Handler _homeDetailScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, HomeDetailScreen()),
  );
  static final Handler _videoScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => _routeHandler(context!, VideoScreen()),
  );
  static final Handler _languageHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return ChooseLanguageScreen(fromMenu: params['page'][0] == 'menu');
  });

//*******Route Define*********
  static void setupRouter() {
    router.define(Routes.loginScreen, handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.homeScreen, handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.phoneLoginScreen, handler: _phoneLoginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.registerScreen, handler: _registerHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.profileScreen, handler: _profileHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.editProfileScreen, handler: _editProfileHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.myFriendsScreen, handler: _myFriendsHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.homeDetailScreen, handler: _homeDetailScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.videoScreen, handler: _videoScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.languageScreen, handler: _languageHandler, transitionType: TransitionType.fadeIn);
  }

  static Widget _routeHandler(BuildContext context, Widget route, {bool isBranchCheck = false}) {
    return route;
  }
}
