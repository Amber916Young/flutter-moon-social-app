import 'package:moon/src/core/data/usecase/usecase.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';

class AuthClearSharedDataUseCase implements SingleUseCaseAsync<bool, NoParams> {
  final AuthRepository authRepository;
  const AuthClearSharedDataUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> call(NoParams params) {
    return authRepository.clearSharedData();
  }
}
