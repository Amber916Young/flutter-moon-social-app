import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/param/login_params.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_email_params.dart';
import 'package:moon/src/features/auth/business/param/verify_phone_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/data/model/signup_model.dart';
import 'package:moon/src/features/auth/data/model/user_log_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(LoginParams params);
  Future<Either<Failure, String>> registration(SignUpModel signUpModel);
  Future<Either<Failure, void>> updateToken();
  Future<Either<Failure, void>> saveUserToken(String token);
  Future<bool> clearSharedData();
  Future<Either<Failure, bool>> deleteUser();
  Future<Either<Failure, String>> forgetPassword(String email);
  Future<Either<Failure, String>> getDeviceToken();
  Future<Either<Failure, String>> verifyToken(VerifyTokenParams params);
  Future<Either<Failure, String>> resetPassword(RestPassParams params);
  Future<Either<Failure, String>> checkEmail(String email);
  Future<Either<Failure, String>> verifyEmail(VerifyEmailParams params);
  Future<Either<Failure, String>> checkPhone(String phone);
  Future<Either<Failure, String>> verifyPhone(VerifyPhoneParams params);
  Future<Either<Failure, void>> saveUserNumberAndPassword(UserLogModel userLogModel);
  Future<Either<Failure, String>> getUserLogData();
  Future<Either<Failure, bool>> clearUserLog();
  bool isLoggedIn();
  String getUserToken();
}
