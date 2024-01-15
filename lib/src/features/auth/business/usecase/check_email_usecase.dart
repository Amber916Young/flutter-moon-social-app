import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthCheckEmailUseCase implements UseCase<String, String> {
  final AuthRepository authRepository;
  const AuthCheckEmailUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(String email) {
    return authRepository.checkEmail(email);
  }
}
