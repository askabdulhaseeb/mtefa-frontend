import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mtefa/core/resources/data_state.dart';
import 'package:mtefa/core/utils/token_manager.dart';
import 'package:mtefa/data/repositories/auth_repository_impl.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';
import 'package:mtefa/domain/usecases/auth/login_usecase.dart';
import 'package:mtefa/presentation/screens/auth/providers/login_provider.dart';
import '../fixtures/auth_fixtures.dart';
import '../mocks/mock_repositories.mocks.dart';

/// Integration tests for complete authentication flow
/// Tests the interaction between multiple layers of the authentication system
void main() {
  group('Authentication Flow Integration Tests', () {
    late AuthRepositoryImpl authRepository;
    late LoginUseCase loginUseCase;
    late LoginProvider loginProvider;
    late MockTokenManager mockTokenManager;
    late MockFlutterSecureStorage mockSecureStorage;

    setUp(() {
      // Initialize mocks
      mockTokenManager = MockTokenManager();
      mockSecureStorage = MockFlutterSecureStorage();
      
      // Initialize repository with mocks
      authRepository = AuthRepositoryImpl(
        tokenManager: mockTokenManager,
        secureStorage: mockSecureStorage,
      );
      
      // Initialize use case with repository
      loginUseCase = LoginUseCase(authRepository);
      
      // Initialize provider with use case
      loginProvider = LoginProvider(loginUseCase: loginUseCase);
      
      // Setup default mock behaviors
      when(mockTokenManager.saveTokens(
        accessToken: anyNamed('accessToken'),
        refreshToken: anyNamed('refreshToken'),
        expiresIn: anyNamed('expiresIn'),
      )).thenAnswer((_) async => Future.value());
      
      when(mockSecureStorage.write(
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenAnswer((_) async => Future.value());
    });

    tearDown(() {
      loginProvider.dispose();
    });

    test('Complete successful login flow from UI to data persistence', () async {
      // Arrange - User enters credentials in UI
      loginProvider.emailController.text = AuthFixtures.validEmail;
      loginProvider.passwordController.text = AuthFixtures.validPassword;
      loginProvider.toggleRememberMe(); // Enable remember me
      
      // Act - User initiates login
      await loginProvider.login();
      
      // Assert - Verify complete flow
      // 1. Provider state should be updated
      expect(loginProvider.loginState, isA<DataSuccess<LoginResponseEntity>>());
      expect(loginProvider.isLoading, isFalse);
      expect(loginProvider.emailError, isNull);
      expect(loginProvider.passwordError, isNull);
      
      // 2. Token manager should have saved tokens
      verify(mockTokenManager.saveTokens(
        accessToken: anyNamed('accessToken'),
        refreshToken: anyNamed('refreshToken'),
        expiresIn: anyNamed('expiresIn'),
      )).called(1);
      
      // 3. User data should be saved in secure storage
      verify(mockSecureStorage.write(
        key: 'current_user',
        value: anyNamed('value'),
      )).called(1);
      
      // 4. Auth token should be saved
      verify(mockSecureStorage.write(
        key: 'auth_token',
        value: anyNamed('value'),
      )).called(1);
      
      // 5. Remember me credentials should be saved
      verify(mockSecureStorage.write(
        key: 'saved_email',
        value: AuthFixtures.validEmail.toLowerCase(),
      )).called(1);
      
      verify(mockSecureStorage.write(
        key: 'saved_password',
        value: AuthFixtures.validPassword.trim(),
      )).called(1);
      
      verify(mockSecureStorage.write(
        key: 'remember_me',
        value: 'true',
      )).called(1);
    });

    test('Complete failed login flow with validation errors', () async {
      // Arrange - User enters invalid email
      loginProvider.emailController.text = 'invalid-email';
      loginProvider.passwordController.text = '123'; // Too short
      
      // Act - User attempts login
      await loginProvider.login();
      
      // Assert - Verify validation flow
      // 1. Provider should have validation errors
      expect(loginProvider.emailError, equals('Please enter a valid email'));
      expect(loginProvider.passwordError, equals('Password must be at least 6 characters'));
      
      // 2. Login state should remain null (not attempted)
      expect(loginProvider.loginState, isNull);
      
      // 3. Repository should not be called
      verifyNever(mockTokenManager.saveTokens(
        accessToken: anyNamed('accessToken'),
        refreshToken: anyNamed('refreshToken'),
        expiresIn: anyNamed('expiresIn'),
      ));
      
      verifyNever(mockSecureStorage.write(
        key: anyNamed('key'),
        value: anyNamed('value'),
      ));
    });

    test('Login with saved credentials flow', () async {
      // Arrange - Setup saved credentials in storage
      when(mockSecureStorage.read(key: 'remember_me'))
          .thenAnswer((_) async => 'true');
      when(mockSecureStorage.read(key: 'saved_email'))
          .thenAnswer((_) async => AuthFixtures.validEmail);
      when(mockSecureStorage.read(key: 'saved_password'))
          .thenAnswer((_) async => AuthFixtures.validPassword);
      
      // Act - Get saved credentials and login
      final savedCredentials = await authRepository.getSavedCredentials();
      if (savedCredentials != null) {
        await loginProvider.loginWithSavedCredentials(
          savedCredentials['email']!,
          savedCredentials['password']!,
        );
      }
      
      // Assert
      // 1. Credentials should be retrieved
      expect(savedCredentials, isNotNull);
      expect(savedCredentials?['email'], equals(AuthFixtures.validEmail));
      expect(savedCredentials?['password'], equals(AuthFixtures.validPassword));
      
      // 2. Login should succeed
      expect(loginProvider.loginState, isA<DataSuccess<LoginResponseEntity>>());
      expect(loginProvider.emailController.text, equals(AuthFixtures.validEmail));
      expect(loginProvider.passwordController.text, equals(AuthFixtures.validPassword));
      expect(loginProvider.rememberMe, isTrue);
      
      // 3. New tokens should be saved
      verify(mockTokenManager.saveTokens(
        accessToken: anyNamed('accessToken'),
        refreshToken: anyNamed('refreshToken'),
        expiresIn: anyNamed('expiresIn'),
      )).called(1);
    });

    test('Complete logout flow', () async {
      // Arrange - First login
      loginProvider.emailController.text = AuthFixtures.validEmail;
      loginProvider.passwordController.text = AuthFixtures.validPassword;
      await loginProvider.login();
      
      // Setup logout mocks
      when(mockTokenManager.clearTokens())
          .thenAnswer((_) async => Future.value());
      when(mockSecureStorage.delete(key: anyNamed('key')))
          .thenAnswer((_) async => Future.value());
      
      // Act - Perform logout
      final logoutResult = await authRepository.logout();
      loginProvider.resetForm();
      
      // Assert
      // 1. Logout should succeed
      expect(logoutResult, isA<DataSuccess<void>>());
      
      // 2. Tokens should be cleared
      verify(mockTokenManager.clearTokens()).called(1);
      
      // 3. User data should be cleared
      verify(mockSecureStorage.delete(key: 'current_user')).called(1);
      verify(mockSecureStorage.delete(key: 'auth_token')).called(1);
      
      // 4. Provider should be reset
      expect(loginProvider.emailController.text, isEmpty);
      expect(loginProvider.passwordController.text, isEmpty);
      expect(loginProvider.loginState, isNull);
      expect(loginProvider.rememberMe, isFalse);
    });

    test('Authentication check flow', () async {
      // Arrange - Setup authentication state
      when(mockTokenManager.isAuthenticated())
          .thenAnswer((_) async => true);
      
      // Act
      final isAuthenticated = await authRepository.isAuthenticated();
      
      // Assert
      expect(isAuthenticated, isTrue);
      verify(mockTokenManager.isAuthenticated()).called(1);
    });

    test('Get current user flow after successful login', () async {
      // Arrange - Perform login first
      loginProvider.emailController.text = AuthFixtures.validEmail;
      loginProvider.passwordController.text = AuthFixtures.validPassword;
      await loginProvider.login();
      
      // Setup mock for reading user data
      final userJson = AuthFixtures.createTestUserJson();
      when(mockSecureStorage.read(key: 'current_user'))
          .thenAnswer((_) async => '${userJson}');
      
      // Act - Get current user
      final currentUserResult = await authRepository.getCurrentUser();
      
      // Assert
      expect(currentUserResult, isA<DataSuccess<UserEntity>>());
      final user = (currentUserResult as DataSuccess).data;
      expect(user?.email, equals(AuthFixtures.validEmail));
      expect(user?.userId, equals(AuthFixtures.testUserId));
    });

    test('Business switching flow', () async {
      // Arrange - Setup initial user data
      final userJson = '${AuthFixtures.createTestUserJson()}';
      when(mockSecureStorage.read(key: 'current_user'))
          .thenAnswer((_) async => userJson);
      
      // Act - Switch business
      const newBusinessId = 'new_business_456';
      final switchResult = await authRepository.switchBusiness(
        businessId: newBusinessId,
      );
      
      // Assert
      expect(switchResult, isA<DataSuccess<UserEntity>>());
      final updatedUser = (switchResult as DataSuccess).data;
      expect(updatedUser?.currentBusinessId, equals(newBusinessId));
      
      // Verify user data was saved with new business ID
      verify(mockSecureStorage.write(
        key: 'current_user',
        value: anyNamed('value'),
      )).called(1);
    });

    test('Clear saved credentials flow', () async {
      // Arrange - Setup mocks
      when(mockSecureStorage.delete(key: anyNamed('key')))
          .thenAnswer((_) async => Future.value());
      
      // Act
      await authRepository.clearSavedCredentials();
      
      // Assert - Verify all credential keys were deleted
      verify(mockSecureStorage.delete(key: 'saved_email')).called(1);
      verify(mockSecureStorage.delete(key: 'saved_password')).called(1);
      verify(mockSecureStorage.delete(key: 'remember_me')).called(1);
    });

    test('Error recovery flow - network failure during login', () async {
      // Arrange - Setup network failure
      when(mockTokenManager.saveTokens(
        accessToken: anyNamed('accessToken'),
        refreshToken: anyNamed('refreshToken'),
        expiresIn: anyNamed('expiresIn'),
      )).thenThrow(Exception('Network error'));
      
      loginProvider.emailController.text = AuthFixtures.validEmail;
      loginProvider.passwordController.text = AuthFixtures.validPassword;
      
      // Act - Attempt login
      await loginProvider.login();
      
      // Assert
      // 1. Login should fail
      expect(loginProvider.loginState, isA<DataFailed<LoginResponseEntity>>());
      
      // 2. Error should be captured
      final failedState = loginProvider.loginState as DataFailed;
      expect(failedState.errorCode, equals('LOGIN_FAILED'));
      
      // 3. UI should not be in loading state
      expect(loginProvider.isLoading, isFalse);
      
      // 4. User data should not be saved
      verifyNever(mockSecureStorage.write(
        key: 'current_user',
        value: anyNamed('value'),
      ));
    });

    test('Session refresh flow', () async {
      // This test would verify token refresh flow when implemented
      // Currently, the refreshToken method returns NOT_IMPLEMENTED
      
      // Act
      final refreshResult = await authRepository.refreshToken(
        refreshToken: 'old_refresh_token',
      );
      
      // Assert
      expect(refreshResult, isA<DataFailed<AuthTokenEntity>>());
      expect((refreshResult as DataFailed).errorCode, equals('NOT_IMPLEMENTED'));
    });

    test('Form validation and error clearing flow', () async {
      // Arrange - Set invalid data
      loginProvider.emailController.text = '';
      loginProvider.passwordController.text = '';
      
      // Act - Validate form
      final isValid = loginProvider.validateForm();
      
      // Assert - Validation should fail
      expect(isValid, isFalse);
      expect(loginProvider.emailError, isNotNull);
      expect(loginProvider.passwordError, isNotNull);
      
      // Act - User corrects the form
      loginProvider.emailController.text = AuthFixtures.validEmail;
      loginProvider.passwordController.text = AuthFixtures.validPassword;
      loginProvider.clearErrors();
      
      // Assert - Errors should be cleared
      expect(loginProvider.emailError, isNull);
      expect(loginProvider.passwordError, isNull);
      
      // Act - Validate again
      final isValidNow = loginProvider.validateForm();
      
      // Assert - Validation should pass
      expect(isValidNow, isTrue);
    });
  });
}