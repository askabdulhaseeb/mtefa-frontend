import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/token_manager.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'presentation/screens/auth/providers/login_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  
  // Initialize all dependencies
  _core();
  _auth();
}

void _core() {
  // Core utilities
  sl.registerLazySingleton<TokenManager>(() => TokenManager(
    storage: sl<FlutterSecureStorage>(),
  ));
}

void _auth() {
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      tokenManager: sl<TokenManager>(),
      secureStorage: sl<FlutterSecureStorage>(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );
  
  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  
  // Providers
  sl.registerFactory<LoginProvider>(
    () => LoginProvider(
      loginUseCase: sl<LoginUseCase>(),
    ),
  );
}
