import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthGetUserTokenUseCase implements SingleUseCase<String, NoParams> {
  final AuthRepository authRepository;
  const AuthGetUserTokenUseCase({
    required this.authRepository,
  });

  @override
  String call(NoParams params) {
    return authRepository.getUserToken();
  }
}
