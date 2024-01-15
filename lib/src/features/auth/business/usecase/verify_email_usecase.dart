import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_email_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthVerifyEmailUseCase implements UseCase<String, VerifyEmailParams> {
  final AuthRepository authRepository;
  const AuthVerifyEmailUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(VerifyEmailParams params) {
    return authRepository.verifyEmail(params);
  }
}
