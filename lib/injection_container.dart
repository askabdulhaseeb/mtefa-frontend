import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/database/database.dart';
import 'core/utils/token_manager.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'presentation/screens/auth/providers/login_provider.dart';
import 'presentation/screens/dashboard/providers/dashboard_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  
  // Initialize all dependencies
  _core();
  _auth();
  _dashboard();
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

void _dashboard() {
  // Dashboard Provider
  sl.registerFactory<DashboardProvider>(
    () => DashboardProvider(),
  );
}
