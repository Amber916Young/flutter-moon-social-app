import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthGetUserLogUseCase implements UseCase<String, NoParams> {
  final AuthRepository authRepository;
  const AuthGetUserLogUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return authRepository.getUserLogData();
  }
}
