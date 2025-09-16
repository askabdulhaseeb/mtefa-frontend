/// Mock implementations of repositories for testing
import 'package:mockito/annotations.dart';
import 'package:mtefa/domain/repositories/auth_repository.dart';
import 'package:mtefa/core/utils/token_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mtefa/core/database/database.dart';

// Generate mocks using mockito
@GenerateMocks([
  AuthRepository,
  TokenManager,
  FlutterSecureStorage,
  AppDatabase,
])
void main() {}