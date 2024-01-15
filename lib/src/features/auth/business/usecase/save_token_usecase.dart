import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthSaveTokenUseCase implements UseCase<void, String> {
  final AuthRepository authRepository;
  const AuthSaveTokenUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(String token) {
    return authRepository.saveUserToken(token);
  }
}
