import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthClearUserDataUseCase implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;
  const AuthClearUserDataUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return authRepository.clearUserLog();
  }
}
