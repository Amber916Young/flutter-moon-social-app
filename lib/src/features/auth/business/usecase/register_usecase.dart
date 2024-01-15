import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';
import 'package:moon/src/features/auth/data/model/signup_model.dart';

class AuthRegisterUseCase implements UseCase<String, SignUpModel> {
  final AuthRepository authRepository;
  const AuthRegisterUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(SignUpModel signUpModel) {
    return authRepository.registration(signUpModel);
  }
}
