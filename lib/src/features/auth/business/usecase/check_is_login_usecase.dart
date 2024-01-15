import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthCheckIsLoginUseCase implements SingleUseCase<bool, NoParams> {
  final AuthRepository authRepository;
  const AuthCheckIsLoginUseCase({
    required this.authRepository,
  });

  @override
  bool call(NoParams params) {
    return authRepository.isLoggedIn();
  }
}
