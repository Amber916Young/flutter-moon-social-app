import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/param/login_params.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_email_params.dart';
import 'package:moon/src/features/auth/business/param/verify_phone_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';
import 'package:moon/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:moon/src/features/auth/data/model/signup_model.dart';
import 'package:moon/src/features/auth/data/model/user_log_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, String>> registration(SignUpModel signUpModel) async {
    return await dataSource.registration(signUpModel);
  }

  @override
  Future<Either<Failure, String>> login(LoginParams params) async {
    return await dataSource.login(params);
  }

  @override
  Future<Either<Failure, void>> updateToken() async {
    return await dataSource.updateToken();
  }

  @override
  Future<Either<Failure, void>> saveUserToken(String token) async {
    return await dataSource.saveUserToken(token);
  }

  @override
  Future<bool> clearSharedData() async {
    return await dataSource.clearSharedData();
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    return await dataSource.deleteUser();
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    return await dataSource.forgetPassword(email);
  }

  @override
  Future<Either<Failure, String>> getDeviceToken() async {
    return await dataSource.getDeviceToken();
  }

  @override
  Future<Either<Failure, String>> verifyToken(VerifyTokenParams params) async {
    return await dataSource.verifyToken(params);
  }

  @override
  Future<Either<Failure, String>> resetPassword(RestPassParams params) async {
    return await dataSource.resetPassword(params);
  }

  @override
  Future<Either<Failure, String>> checkEmail(String email) async {
    return await dataSource.checkEmail(email);
  }

  @override
  Future<Either<Failure, String>> verifyEmail(VerifyEmailParams params) async {
    return await dataSource.verifyEmail(params);
  }

  @override
  Future<Either<Failure, String>> checkPhone(String phone) async {
    return await dataSource.checkPhone(phone);
  }

  @override
  Future<Either<Failure, String>> verifyPhone(VerifyPhoneParams params) async {
    return await dataSource.verifyPhone(params);
  }

  @override
  Future<Either<Failure, void>> saveUserNumberAndPassword(UserLogModel userLogModel) async {
    return await dataSource.saveUserNumberAndPassword(userLogModel);
  }

  @override
  Future<Either<Failure, String>> getUserLogData() async {
    return await dataSource.getUserLogData();
  }

  @override
  Future<Either<Failure, bool>> clearUserLog() async {
    return await dataSource.clearUserLog();
  }

  @override
  String getUserToken() {
    return dataSource.getUserToken();
  }

  @override
  bool isLoggedIn() {
    return dataSource.isLoggedIn();
  }
}
