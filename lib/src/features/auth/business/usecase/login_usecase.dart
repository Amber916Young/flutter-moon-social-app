import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/param/login_params.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthLoginUseCase implements UseCase<String, LoginParams> {
  final AuthRepository authRepository;
  const AuthLoginUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return authRepository.login(params);
  }
}
