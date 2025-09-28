import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mtefa/core/resources/data_state.dart';
import 'package:mtefa/data/repositories/auth_repository_impl.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';
import '../../fixtures/auth_fixtures.dart';
import '../../mocks/mock_repositories.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepository;
  late MockTokenManager mockTokenManager;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockTokenManager = MockTokenManager();
    mockSecureStorage = MockFlutterSecureStorage();
    authRepository = AuthRepositoryImpl(
      tokenManager: mockTokenManager,
      secureStorage: mockSecureStorage,
    );
  });

  group('AuthRepositoryImpl', () {
    group('login', () {
      test('should return LoginResponseEntity on successful login', () async {
        // Arrange
        const String email = AuthFixtures.validEmail;
        const String password = AuthFixtures.validPassword;
        
        // Setup mocks for successful login
        when(mockTokenManager.saveTokens(
          accessToken: anyNamed('accessToken'),
          refreshToken: anyNamed('refreshToken'),
          expiresIn: anyNamed('expiresIn'),
        )).thenAnswer((_) async => Future<void>.value());
        
        when(mockSecureStorage.write(
          key: anyNamed('key'),
          value: anyNamed('value'),
        )).thenAnswer((_) async => Future<void>.value());

        // Act
        final DataState<LoginResponseEntity> result = await authRepository.login(
          email: email,
          password: password,
        );

        // Assert
        expect(result, isA<DataSuccess<LoginResponseEntity>>());
        expect(result.isSuccess, isTrue);
        
        final LoginResponseEntity loginResponse = (result as DataSuccess<LoginResponseEntity>).data;
        expect(loginResponse?.user.email, equals(email));
        expect(loginResponse?.token.accessToken, isNotEmpty);
        
        // Verify token manager was called
        verify(mockTokenManager.saveTokens(
          accessToken: anyNamed('accessToken'),
          refreshToken: anyNamed('refreshToken'),
          expiresIn: anyNamed('expiresIn'),
        )).called(1);
      });

      test('should save user data locally after successful login', () async {
        // Arrange
        const String email = AuthFixtures.validEmail;
        const String password = AuthFixtures.validPassword;
        
        when(mockTokenManager.saveTokens(
          accessToken: anyNamed('accessToken'),
          refreshToken: anyNamed('refreshToken'),
          expiresIn: anyNamed('expiresIn'),
        )).thenAnswer((_) async => Future<void>.value());
        
        when(mockSecureStorage.write(
          key: anyNamed('key'),
          value: anyNamed('value'),
        )).thenAnswer((_) async => Future<void>.value());

        // Act
        await authRepository.login(email: email, password: password);

        // Assert
        // Verify user data was saved
        verify(mockSecureStorage.write(
          key: 'current_user',
          value: anyNamed('value'),
        )).called(1);
        
        // Verify auth token was saved
        verify(mockSecureStorage.write(
          key: 'auth_token',
          value: anyNamed('value'),
        )).called(1);
      });

      test('should handle login failure gracefully', () async {
        // Arrange
        const String email = AuthFixtures.validEmail;
        const String password = 'wrong_password';
        
        when(mockTokenManager.saveTokens(
          accessToken: anyNamed('accessToken'),
          refreshToken: anyNamed('refreshToken'),
          expiresIn: anyNamed('expiresIn'),
        )).thenThrow(Exception('Save failed'));
        
        when(mockSecureStorage.write(
          key: anyNamed('key'),
          value: anyNamed('value'),
        )).thenAnswer((_) async => Future<void>.value());

        // Act
        final DataState<LoginResponseEntity> result = await authRepository.login(
          email: email,
          password: password,
        );

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect(result.isFailed, isTrue);
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('LOGIN_FAILED'));
      });
    });

    group('logout', () {
      test('should clear all stored data on logout', () async {
        // Arrange
        when(mockTokenManager.clearTokens()).thenAnswer((_) async => Future.value());
        when(mockSecureStorage.delete(key: anyNamed('key')))
            .thenAnswer((_) async => Future.value());

        // Act
        final DataState<void> result = await authRepository.logout();

        // Assert
        expect(result, isA<DataSuccess<void>>());
        
        // Verify all data was cleared
        verify(mockTokenManager.clearTokens()).called(1);
        verify(mockSecureStorage.delete(key: 'current_user')).called(1);
        verify(mockSecureStorage.delete(key: 'auth_token')).called(1);
      });

      test('should handle logout errors gracefully', () async {
        // Arrange
        when(mockTokenManager.clearTokens()).thenThrow(Exception('Clear failed'));

        // Act
        final DataState<void> result = await authRepository.logout();

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('LOGOUT_FAILED'));
      });
    });

    group('getCurrentUser', () {
      test('should return current user when data exists', () async {
        // Arrange
        final Map<String, dynamic> userJson = AuthFixtures.createTestUserJson();
        when(mockSecureStorage.read(key: 'current_user'))
            .thenAnswer((_) async => '$userJson');

        // Act
        final DataState<UserEntity> result = await authRepository.getCurrentUser();

        // Assert
        expect(result, isA<DataSuccess<UserEntity>>());
        final user = (result as DataSuccess).data;
        expect(user?.userId, equals(AuthFixtures.testUserId));
        expect(user?.email, equals(AuthFixtures.validEmail));
      });

      test('should return error when no user data exists', () async {
        // Arrange
        when(mockSecureStorage.read(key: 'current_user'))
            .thenAnswer((_) async => null);

        // Act
        final DataState<UserEntity> result = await authRepository.getCurrentUser();

        // Assert
        expect(result, isA<DataFailed<UserEntity>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NO_USER'));
      });

      test('should handle corrupted user data', () async {
        // Arrange
        when(mockSecureStorage.read(key: 'current_user'))
            .thenAnswer((_) async => 'invalid_json');

        // Act
        final DataState<UserEntity> result = await authRepository.getCurrentUser();

        // Assert
        expect(result, isA<DataFailed<UserEntity>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('GET_USER_FAILED'));
      });
    });

    group('isAuthenticated', () {
      test('should delegate to token manager', () async {
        // Arrange
        when(mockTokenManager.isAuthenticated()).thenAnswer((_) async => true);

        // Act
        final bool result = await authRepository.isAuthenticated();

        // Assert
        expect(result, isTrue);
        verify(mockTokenManager.isAuthenticated()).called(1);
      });
    });

    group('saveCredentials and getSavedCredentials', () {
      test('should save credentials securely', () async {
        // Arrange
        const String email = AuthFixtures.validEmail;
        const String password = AuthFixtures.validPassword;
        
        when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenAnswer((_) async => Future.value());

        // Act
        await authRepository.saveCredentials(email: email, password: password);

        // Assert
        verify(mockSecureStorage.write(key: 'saved_email', value: email)).called(1);
        verify(mockSecureStorage.write(key: 'saved_password', value: password)).called(1);
        verify(mockSecureStorage.write(key: 'remember_me', value: 'true')).called(1);
      });

      test('should retrieve saved credentials when remember me is true', () async {
        // Arrange
        when(mockSecureStorage.read(key: 'remember_me')).thenAnswer((_) async => 'true');
        when(mockSecureStorage.read(key: 'saved_email'))
            .thenAnswer((_) async => AuthFixtures.validEmail);
        when(mockSecureStorage.read(key: 'saved_password'))
            .thenAnswer((_) async => AuthFixtures.validPassword);

        // Act
        final Map<String, String>? credentials = await authRepository.getSavedCredentials();

        // Assert
        expect(credentials, isNotNull);
        expect(credentials?['email'], equals(AuthFixtures.validEmail));
        expect(credentials?['password'], equals(AuthFixtures.validPassword));
      });

      test('should return null when remember me is false', () async {
        // Arrange
        when(mockSecureStorage.read(key: 'remember_me')).thenAnswer((_) async => 'false');

        // Act
        final Map<String, String>? credentials = await authRepository.getSavedCredentials();

        // Assert
        expect(credentials, isNull);
        verifyNever(mockSecureStorage.read(key: 'saved_email'));
        verifyNever(mockSecureStorage.read(key: 'saved_password'));
      });

      test('should return null when credentials are incomplete', () async {
        // Arrange
        when(mockSecureStorage.read(key: 'remember_me')).thenAnswer((_) async => 'true');
        when(mockSecureStorage.read(key: 'saved_email'))
            .thenAnswer((_) async => AuthFixtures.validEmail);
        when(mockSecureStorage.read(key: 'saved_password')).thenAnswer((_) async => null);

        // Act
        final Map<String, String>? credentials = await authRepository.getSavedCredentials();

        // Assert
        expect(credentials, isNull);
      });

      test('should clear saved credentials', () async {
        // Arrange
        when(mockSecureStorage.delete(key: anyNamed('key')))
            .thenAnswer((_) async => Future.value());

        // Act
        await authRepository.clearSavedCredentials();

        // Assert
        verify(mockSecureStorage.delete(key: 'saved_email')).called(1);
        verify(mockSecureStorage.delete(key: 'saved_password')).called(1);
        verify(mockSecureStorage.delete(key: 'remember_me')).called(1);
      });
    });

    group('switchBusiness', () {
      test('should update current business ID', () async {
        // Arrange
        const String newBusinessId = 'new_business_123';
        final UserEntity user = AuthFixtures.createTestUser();
        final String userJson = '${AuthFixtures.createTestUserJson()}';
        
        when(mockSecureStorage.read(key: 'current_user'))
            .thenAnswer((_) async => userJson);
        when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenAnswer((_) async => Future.value());

        // Act
        final DataState<UserEntity> result = await authRepository.switchBusiness(businessId: newBusinessId);

        // Assert
        expect(result, isA<DataSuccess<UserEntity>>());
        final updatedUser = (result as DataSuccess).data;
        expect(updatedUser?.currentBusinessId, equals(newBusinessId));
        
        verify(mockSecureStorage.write(
          key: 'current_user',
          value: anyNamed('value'),
        )).called(1);
      });

      test('should return error when no user data exists', () async {
        // Arrange
        when(mockSecureStorage.read(key: 'current_user')).thenAnswer((_) async => null);

        // Act
        final DataState<UserEntity> result = await authRepository.switchBusiness(businessId: 'business_123');

        // Assert
        expect(result, isA<DataFailed<UserEntity>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NO_USER'));
      });
    });

    group('switchBranch', () {
      test('should update current branch ID', () async {
        // Arrange
        const String newBranchId = 'new_branch_123';
        final String userJson = '${AuthFixtures.createTestUserJson()}';
        
        when(mockSecureStorage.read(key: 'current_user'))
            .thenAnswer((_) async => userJson);
        when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenAnswer((_) async => Future.value());

        // Act
        final DataState<UserEntity> result = await authRepository.switchBranch(branchId: newBranchId);

        // Assert
        expect(result, isA<DataSuccess<UserEntity>>());
        final updatedUser = (result as DataSuccess).data;
        expect(updatedUser?.currentBranchId, equals(newBranchId));
        
        verify(mockSecureStorage.write(
          key: 'current_user',
          value: anyNamed('value'),
        )).called(1);
      });
    });

    group('updateFcmToken', () {
      test('should save FCM token', () async {
        // Arrange
        const String fcmToken = 'test_fcm_token_123';
        when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenAnswer((_) async => Future.value());

        // Act
        final DataState<void> result = await authRepository.updateFcmToken(fcmToken: fcmToken);

        // Assert
        expect(result, isA<DataSuccess<void>>());
        verify(mockSecureStorage.write(key: 'fcm_token', value: fcmToken)).called(1);
      });

      test('should handle FCM token update failure', () async {
        // Arrange
        const String fcmToken = 'test_fcm_token_123';
        when(mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
            .thenThrow(Exception('Write failed'));

        // Act
        final DataState<void> result = await authRepository.updateFcmToken(fcmToken: fcmToken);

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('UPDATE_FCM_FAILED'));
      });
    });

    group('Not Implemented Methods', () {
      test('verifyTwoFactor should return not implemented error', () async {
        // Act
        final DataState<LoginResponseEntity> result = await authRepository.verifyTwoFactor(
          code: '123456',
          method: 'sms',
        );

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('refreshToken should return not implemented error', () async {
        // Act
        final DataState<AuthTokenEntity> result = await authRepository.refreshToken(
          refreshToken: 'refresh_token',
        );

        // Assert
        expect(result, isA<DataFailed<AuthTokenEntity>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('changePassword should return not implemented error', () async {
        // Act
        final DataState<void> result = await authRepository.changePassword(
          currentPassword: 'current',
          newPassword: 'new',
        );

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('requestPasswordReset should return not implemented error', () async {
        // Act
        final DataState<void> result = await authRepository.requestPasswordReset(
          email: AuthFixtures.validEmail,
        );

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('resetPassword should return not implemented error', () async {
        // Act
        final DataState<void> result = await authRepository.resetPassword(
          token: 'reset_token',
          newPassword: 'new_password',
        );

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('updateProfile should return not implemented error', () async {
        // Act
        final DataState<UserEntity> result = await authRepository.updateProfile(
          userId: 'user123',
          name: 'New Name',
        );

        // Assert
        expect(result, isA<DataFailed<UserEntity>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('enableTwoFactor should return not implemented error', () async {
        // Act
        final DataState<Map<String, dynamic>> result = await authRepository.enableTwoFactor(method: 'sms');

        // Assert
        expect(result, isA<DataFailed<Map<String, dynamic>>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('disableTwoFactor should return not implemented error', () async {
        // Act
        final DataState<void> result = await authRepository.disableTwoFactor(code: '123456');

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('verifyEmail should return not implemented error', () async {
        // Act
        final DataState<void> result = await authRepository.verifyEmail(token: 'verify_token');

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });

      test('resendVerificationEmail should return not implemented error', () async {
        // Act
        final DataState<void> result = await authRepository.resendVerificationEmail();

        // Assert
        expect(result, isA<DataFailed<void>>());
        expect((result as DataFailed<LoginResponseEntity>).errorCode, equals('NOT_IMPLEMENTED'));
      });
    });
  });
}