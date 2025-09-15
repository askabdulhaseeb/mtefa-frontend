import 'package:get_it/get_it.dart';

import 'core/utils/token_manager.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Initialize all dependencies
  _core();
  _auth();
}

void _core() {
  // Core utilities
  sl.registerLazySingleton<TokenManager>(() => TokenManager());
}

void _auth() {}
