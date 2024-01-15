import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthVerifyTokenUseCase implements UseCase<String, VerifyTokenParams> {
  final AuthRepository authRepository;
  const AuthVerifyTokenUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(VerifyTokenParams params) {
    return authRepository.verifyToken(params);
  }
}
