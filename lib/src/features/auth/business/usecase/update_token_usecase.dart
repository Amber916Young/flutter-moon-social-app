import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthUpdateTokenUseCase implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  const AuthUpdateTokenUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return authRepository.updateToken();
  }
}
