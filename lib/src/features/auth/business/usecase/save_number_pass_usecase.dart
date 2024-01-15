import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';
import 'package:moon/src/features/auth/data/model/user_log_model.dart';

class AuthNumberAndPassUseCase implements UseCase<void, UserLogModel> {
  final AuthRepository authRepository;
  const AuthNumberAndPassUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(UserLogModel userLogModel) {
    return authRepository.saveUserNumberAndPassword(userLogModel);
  }
}
