import 'package:dartz/dartz.dart';
import 'package:moon/src/core/data/exception/failure.dart';
import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/param/reset_pass_params.dart';
import 'package:moon/src/features/auth/business/param/verify_token_params.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthCheckPhoneUseCase implements UseCase<String, String> {
  final AuthRepository authRepository;
  const AuthCheckPhoneUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(String phone) {
    return authRepository.checkPhone(phone);
  }
}
