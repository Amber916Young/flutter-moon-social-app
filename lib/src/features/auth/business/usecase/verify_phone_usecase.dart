import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_email_params.dart';
import 'package:moon/src/features/auth/business/param/verify_phone_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthVerifyPhoneUseCase implements UseCase<String, VerifyPhoneParams> {
  final AuthRepository authRepository;
  const AuthVerifyPhoneUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(VerifyPhoneParams params) {
    return authRepository.verifyPhone(params);
  }
}
