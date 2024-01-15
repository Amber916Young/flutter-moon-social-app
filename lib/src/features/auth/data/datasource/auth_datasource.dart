import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:moon/src/core/constant/app_constants.dart';
import 'package:moon/src/core/data/exception/api_error_handler.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/param/login_params.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_email_params.dart';
import 'package:moon/src/features/auth/business/param/verify_phone_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/data/model/signup_model.dart';
import 'package:moon/src/core/data/dio/dio_client.dart';
import 'package:moon/src/features/auth/data/model/user_log_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataSource {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  AuthDataSource({required this.dioClient, required this.sharedPreferences});

  Future<Either<Failure, String>> registration(SignUpModel signUpModel) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.registerUri,
        data: signUpModel.toJson(),
      );
      if (response.statusCode == 200) {
        Map map = response.data;
        String token = map["temporary_token"];
        return right(token);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> login(LoginParams params) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.loginUri,
        data: {"email_or_phone": params.email, "email": params.email, "password": params.password},
      );
      if (response.statusCode == 200) {
        Map map = response.data;
        String token = map["token"];
        return right(token);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> forgetPassword(String email) async {
    try {
      Response response = await dioClient!.post(AppConstants.forgetPasswordUri, data: {"email_or_phone": email, "email": email});
      if (response.statusCode == 200) {
        return right(response.data["message"]);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> getDeviceToken() async {
    String? deviceToken = '@';
    try {
      deviceToken = (await FirebaseMessaging.instance.getToken())!;
      return right(deviceToken);
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> verifyToken(VerifyTokenParams params) async {
    try {
      Response response = await dioClient!.post(AppConstants.verifyTokenUri, data: {"email_or_phone": params.email, "email": params.email, "reset_token": params.verificationCode});
      if (response.statusCode == 200) {
        return right(response.data["message"]);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> resetPassword(RestPassParams params) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.resetPasswordUri,
        data: {"_method": "put", "reset_token": params.resetToken, "password": params.password, "confirm_password": params.confirmPassword, "email_or_phone": params.email, "email": params.email},
      );

      if (response.statusCode == 200) {
        return right(response.data["message"]);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> checkEmail(String email) async {
    try {
      Response response = await dioClient!.post(AppConstants.checkEmailUri, data: {"email": email});
      if (response.statusCode == 200) {
        return right(response.data["token"]);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> verifyEmail(VerifyEmailParams params) async {
    try {
      Response response = await dioClient!.post(AppConstants.verifyEmailUri, data: {"email": params.email, "token": params.verificationCode});
      if (response.statusCode == 200) {
        return right(response.data["message"]);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> checkPhone(String phone) async {
    try {
      Response response = await dioClient!.post(AppConstants.baseUrl + AppConstants.checkPhoneUri + phone, data: {"phone": phone});
      if (response.statusCode == 200) {
        return right(response.data["token"]);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> verifyPhone(VerifyPhoneParams params) async {
    try {
      Response response = await dioClient!.post(AppConstants.verifyPhoneUri, data: {"phone": params.phone.trim(), "token": params.verificationCode});
      if (response.statusCode == 200) {
        return right(response.data["message"]);
      }
      return left(ServerFailure(errorMessage: response.data, errorCode: response.statusCode.toString()));
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, void>> updateToken() async {
    try {
      String? deviceToken = '@';

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
        NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          final result = await getDeviceToken();
          await result.fold((l) async {}, (r) async {
            deviceToken = r;
          });
        }
      } else {
        final result = await getDeviceToken();
        await result.fold((l) async {}, (r) async {
          deviceToken = r;
        });
      }

      if (!kIsWeb) {
        FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
      }

      Response response = await dioClient!.post(
        AppConstants.tokenUri,
        data: {"_method": "put", "cm_firebase_token": deviceToken},
      );

      return right(null);
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, void>> saveUserToken(String token) async {
    try {
      await dioClient!.updateHeader(getToken: token);
      await sharedPreferences!.setString(AppConstants.token, token);
      return right(null);
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, bool>> deleteUser() async {
    try {
      await dioClient!.delete(AppConstants.customerRemove);
      return right(true);
    } catch (e) {
      return left(ConnectionFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<Either<Failure, String>> getUserLogData() async {
    try {
      if (sharedPreferences!.containsKey(AppConstants.userLogData)) {
        return right(sharedPreferences!.getString(AppConstants.userLogData)!);
      } else {
        return left(CacheFailure(errorMessage: "No Data"));
      }
    } catch (e) {
      return left(CacheFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  String getUserToken() {
    return sharedPreferences!.getString(AppConstants.token) ?? "";
  }

  Future<Either<Failure, bool>> clearUserLog() async {
    try {
      return right(await sharedPreferences!.remove(AppConstants.userLogData));
    } catch (e) {
      return left(CacheFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  Future<bool> clearSharedData() async {
    if (!kIsWeb) {
      Future.delayed(const Duration(milliseconds: 100)).then((value) async => await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.topic));
    }
    // await dioClient!.post(
    //   AppConstants.tokenUri,
    //   data: {"_method": "put", "cm_firebase_token": '@'},
    // );

    await sharedPreferences!.remove(AppConstants.token);
    await sharedPreferences!.remove(AppConstants.cartList);
    await sharedPreferences!.remove(AppConstants.placeOrderData);
    await sharedPreferences!.remove(AppConstants.userAddress);
    await sharedPreferences!.remove(AppConstants.addressPlaceId);
    await sharedPreferences!.remove(AppConstants.branch);
    return true;
  }

  Future<Either<Failure, void>> saveUserNumberAndPassword(UserLogModel userLogModel) async {
    try {
      await sharedPreferences!.setString(AppConstants.userLogData, jsonEncode(userLogModel.toJson()));

      // await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      // await sharedPreferences.setString(AppConstants.USER_COUNTRY_CODE, countryCode);
      // await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
      return right(null);
    } catch (e) {
      return left(CacheFailure(errorMessage: ApiErrorHandler.getMessage(e)));
    }
  }

  bool isLoggedIn() {
    return sharedPreferences!.containsKey(AppConstants.token);
  }
}
