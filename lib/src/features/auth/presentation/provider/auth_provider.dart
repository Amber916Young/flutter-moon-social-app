import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moon/src/features/auth/business/param/login_params.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_email_params.dart';
import 'package:moon/src/features/auth/business/param/verify_phone_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/business/usecase/check_email_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/check_is_login_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/check_phone_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/clear_data_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/clear_user_data_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/delete_user_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/forgot_pass_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/get_device_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/get_user_log_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/get_user_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/login_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/register_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/reset_pass_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/save_number_pass_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/save_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/update_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/verify_email_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/verify_phone_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/verify_token_usecase.dart';

class AuthProvider with ChangeNotifier {
  final AuthRegisterUseCase authRegisterUseCase;
  final AuthSaveTokenUseCase authSaveTokenUseCase;
  final AuthUpdateTokenUseCase authUpdateTokenUseCase;
  final AuthLoginUseCase authLoginUseCase;
  final AuthClearSharedDataUseCase authClearSharedDataUseCase;
  final AuthDeleteUseCase authDeleteUseCase;
  final AuthForgotPassUseCase authForgotPassUseCase;
  final AuthGetDeviceTokenUseCase authGetDeviceTokenUseCase;
  final AuthVerifyTokenUseCase authVerifyTokenUseCase;
  final AuthRestPassUseCase authRestPassUseCase;
  final AuthCheckEmailUseCase authCheckEmailUseCase;
  final AuthVerifyEmailUseCase authVerifyEmailUseCase;
  final AuthCheckPhoneUseCase authCheckPhoneUseCase;
  final AuthVerifyPhoneUseCase authVerifyPhoneUseCase;
  final AuthNumberAndPassUseCase authNumberAndPassUseCase;
  final AuthGetUserLogUseCase authGetUserLogUseCase;
  final AuthClearUserDataUseCase authClearUserDataUseCase;
  final AuthGetUserTokenUseCase authGetUserTokenUseCase;
  final AuthCheckIsLoginUseCase authCheckIsLoginUseCase;

  AuthProvider(
      {required this.authVerifyPhoneUseCase,
      required this.authGetUserLogUseCase,
      required this.authCheckIsLoginUseCase,
      required this.authGetUserTokenUseCase,
      required this.authClearUserDataUseCase,
      required this.authCheckPhoneUseCase,
      required this.authNumberAndPassUseCase,
      required this.authVerifyEmailUseCase,
      required this.authCheckEmailUseCase,
      required this.authRestPassUseCase,
      required this.authVerifyTokenUseCase,
      required this.authGetDeviceTokenUseCase,
      required this.authForgotPassUseCase,
      required this.authDeleteUseCase,
      required this.authRegisterUseCase,
      required this.authSaveTokenUseCase,
      required this.authUpdateTokenUseCase,
      required this.authLoginUseCase,
      required this.authClearSharedDataUseCase});
  Timer? _timer;
  int? currentTime = 60;
  bool _isLoading = false;
  String? _registrationErrorMessage = '';
  String? _loginErrorMessage = "";
  String? _forgotPassErrorMessage = '';
  bool _isForgotPasswordLoading = false;
  bool _isPhoneNumberVerificationButtonLoading = false;
  String? _phoneNumberVerificationErrorMessage = '';
  bool resendButtonLoading = false;
  String? _verificationMsg = '';
  String _email = '';
  String _phone = '';
  String _verificationCode = '';
  bool _isEnableVerificationCode = false;
  bool _isActiveRememberMe = false;
  bool _isAgreePolicy = false;

  bool get isLoading => _isLoading;

  String? get registrationErrorMessage => _registrationErrorMessage;

  String? get phoneNumberVerificationErrorMessage => _phoneNumberVerificationErrorMessage;

  String? get loginErrorMessage => _loginErrorMessage;

  String? get forgotPassErrorMessage => _forgotPassErrorMessage;

  bool get isForgotPasswordLoading => _isForgotPasswordLoading;

  bool get isPhoneNumberVerificationButtonLoading => _isPhoneNumberVerificationButtonLoading;

  String? get verificationMessage => _verificationMsg;

  String get email => _email;

  String get phone => _phone;

  String get verificationCode => _verificationCode;

  bool get isEnableVerificationCode => _isEnableVerificationCode;

  bool get isActiveRememberMe => _isActiveRememberMe;
  bool get isAgreePolicy => _isAgreePolicy;

  Future<bool> login(String? phone, String? password) async {
    _isLoading = true;
    // _loginErrorMessage = '';
    bool isSuccess = false;

    notifyListeners();
    // final result = await authLoginUseCase.call(LoginParams(email: phone!, password: password!));

    // await result.fold((l) async {
    //   _loginErrorMessage = l.errorMessage;
    //   isSuccess = false;
    // }, (r) async {
    // await authSaveTokenUseCase.call(r);
    // await authUpdateTokenUseCase.call(NoParams());
    // await Provider.of<ProfileProvider>(Get.context!, listen: false).getUserInfo(true, isUpdate: false);
    // isSuccess = true;
    // });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }

  toggleAgree() {
    _isAgreePolicy = !_isAgreePolicy;
    notifyListeners();
  }
}
