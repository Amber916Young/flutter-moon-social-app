import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moon/src/core/constant/app_constants.dart';
import 'package:moon/src/core/data/dio/dio_client.dart';
import 'package:moon/src/core/data/dio/logging_interceptor.dart';
import 'package:moon/src/core/provider/language_provider.dart';
import 'package:moon/src/core/provider/localization_provider.dart';
import 'package:moon/src/core/provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moon/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:moon/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:moon/src/features/auth/business/repository/auth_repository.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:moon/src/features/auth/business/usecase/check_email_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/check_is_login_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/check_phone_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/clear_data_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/clear_user_data_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/delete_user_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/forgot_pass_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/get_device_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/get_user_log_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/get_user_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/login_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/register_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/reset_pass_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/save_number_pass_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/save_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/update_token_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/verify_email_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/verify_phone_usecase.dart';
import 'package:moon/src/features/auth/business/usecase/verify_token_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        dataSource: sl(),
      ));

  // Data Layer
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource(dioClient: sl(), sharedPreferences: sl()));

  // Usecase
  // auth
  sl.registerLazySingleton<AuthRegisterUseCase>(() => AuthRegisterUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthSaveTokenUseCase>(() => AuthSaveTokenUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthUpdateTokenUseCase>(() => AuthUpdateTokenUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthLoginUseCase>(() => AuthLoginUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthClearSharedDataUseCase>(() => AuthClearSharedDataUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthDeleteUseCase>(() => AuthDeleteUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthForgotPassUseCase>(() => AuthForgotPassUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthGetDeviceTokenUseCase>(() => AuthGetDeviceTokenUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthVerifyTokenUseCase>(() => AuthVerifyTokenUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthRestPassUseCase>(() => AuthRestPassUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthCheckEmailUseCase>(() => AuthCheckEmailUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthVerifyEmailUseCase>(() => AuthVerifyEmailUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthCheckPhoneUseCase>(() => AuthCheckPhoneUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthVerifyPhoneUseCase>(() => AuthVerifyPhoneUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthNumberAndPassUseCase>(() => AuthNumberAndPassUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthGetUserLogUseCase>(() => AuthGetUserLogUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthClearUserDataUseCase>(() => AuthClearUserDataUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthGetUserTokenUseCase>(() => AuthGetUserTokenUseCase(authRepository: sl()));
  sl.registerLazySingleton<AuthCheckIsLoginUseCase>(() => AuthCheckIsLoginUseCase(authRepository: sl()));

  // Registering Provider
  sl.registerFactory<AuthProvider>(() => AuthProvider(
        authVerifyPhoneUseCase: sl<AuthVerifyPhoneUseCase>(),
        authGetUserLogUseCase: sl<AuthGetUserLogUseCase>(),
        authCheckIsLoginUseCase: sl<AuthCheckIsLoginUseCase>(),
        authGetUserTokenUseCase: sl<AuthGetUserTokenUseCase>(),
        authClearUserDataUseCase: sl<AuthClearUserDataUseCase>(),
        authCheckPhoneUseCase: sl<AuthCheckPhoneUseCase>(),
        authNumberAndPassUseCase: sl<AuthNumberAndPassUseCase>(),
        authVerifyEmailUseCase: sl<AuthVerifyEmailUseCase>(),
        authCheckEmailUseCase: sl<AuthCheckEmailUseCase>(),
        authRestPassUseCase: sl<AuthRestPassUseCase>(),
        authVerifyTokenUseCase: sl<AuthVerifyTokenUseCase>(),
        authGetDeviceTokenUseCase: sl<AuthGetDeviceTokenUseCase>(),
        authForgotPassUseCase: sl<AuthForgotPassUseCase>(),
        authDeleteUseCase: sl<AuthDeleteUseCase>(),
        authRegisterUseCase: sl<AuthRegisterUseCase>(),
        authSaveTokenUseCase: sl<AuthSaveTokenUseCase>(),
        authUpdateTokenUseCase: sl<AuthUpdateTokenUseCase>(),
        authLoginUseCase: sl<AuthLoginUseCase>(),
        authClearSharedDataUseCase: sl<AuthClearSharedDataUseCase>(),
      ));

  //common provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl(), dioClient: sl()));
  sl.registerFactory(() => LanguageProvider());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
