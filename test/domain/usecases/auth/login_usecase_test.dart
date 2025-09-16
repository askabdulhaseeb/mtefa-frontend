import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mtefa/core/resources/data_state.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';
import 'package:mtefa/domain/usecases/auth/login_usecase.dart';
import '../../../fixtures/auth_fixtures.dart';
import '../../../mocks/mock_repositories.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  group('LoginUseCase', () {
    group('Validation', () {
      test('should return error when params are null', () async {
        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: null);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed).error, equals('Login parameters are required'));
        expect(result.errorCode, equals('INVALID_PARAMS'));
        verifyNever(mockAuthRepository.login(email: anyNamed('email'), password: anyNamed('password')));
      });

      test('should return error when email is empty', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: '',
          password: AuthFixtures.validPassword,
        );

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed).error, equals('Email is required'));
        expect(result.errorCode, equals('EMAIL_REQUIRED'));
        verifyNever(mockAuthRepository.login(email: anyNamed('email'), password: anyNamed('password')));
      });

      test('should return error when email format is invalid', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.invalidEmail,
          password: AuthFixtures.validPassword,
        );

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed).error, equals('Invalid email format'));
        expect(result.errorCode, equals('INVALID_EMAIL'));
        verifyNever(mockAuthRepository.login(email: anyNamed('email'), password: anyNamed('password')));
      });

      test('should validate various email formats', () async {
        // Arrange
        final List<String> invalidEmails = <String>[
          'plaintext',
          '@example.com',
          'user@',
          'user@.com',
          'user@example',
          'user @example.com',
          'user@exam ple.com',
        ];

        // Act & Assert
        for (final String email in invalidEmails) {
          final LoginParams params = LoginParams(
            email: email,
            password: AuthFixtures.validPassword,
          );
          
          final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);
          
          expect(result, isA<DataFailed<LoginResponseEntity>>(), 
            reason: 'Email "$email" should be invalid');
          expect((result as DataFailed).errorCode, equals('INVALID_EMAIL'));
        }
      });

      test('should accept valid email formats', () async {
        // Arrange
        final List<String> validEmails = <String>[
          'user@example.com',
          'user.name@example.com',
          'user+tag@example.co.uk',
          'user_123@example-domain.com',
        ];

        // Setup mock
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => DataSuccess(AuthFixtures.createTestLoginResponse()));

        // Act & Assert
        for (final String email in validEmails) {
          final LoginParams params = LoginParams(
            email: email,
            password: AuthFixtures.validPassword,
          );
          
          final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);
          
          expect(result, isA<DataSuccess<LoginResponseEntity>>(), 
            reason: 'Email "$email" should be valid');
        }
      });

      test('should return error when password is empty', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: '',
        );

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed).error, equals('Password is required'));
        expect(result.errorCode, equals('PASSWORD_REQUIRED'));
        verifyNever(mockAuthRepository.login(email: anyNamed('email'), password: anyNamed('password')));
      });

      test('should return error when password is too short', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.shortPassword,
        );

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed).error, equals('Password must be at least 6 characters'));
        expect(result.errorCode, equals('PASSWORD_TOO_SHORT'));
        verifyNever(mockAuthRepository.login(email: anyNamed('email'), password: anyNamed('password')));
      });
    });

    group('Login Process', () {
      test('should call repository login with trimmed and lowercased email', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: '  Test@Example.COM  ',
          password: '  password123  ',
        );
        
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => DataSuccess(AuthFixtures.createTestLoginResponse()));

        // Act
        await loginUseCase.call(params: params);

        // Assert
        verify(mockAuthRepository.login(
          email: 'test@example.com',
          password: 'password123',
        )).called(1);
      });

      test('should return success when login is successful', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
        );
        
        final LoginResponseEntity expectedResponse = AuthFixtures.createTestLoginResponse();
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => DataSuccess(expectedResponse));

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataSuccess<LoginResponseEntity>>());
        expect((result as DataSuccess).data, equals(expectedResponse));
        verify(mockAuthRepository.login(
          email: AuthFixtures.validEmail.toLowerCase(),
          password: AuthFixtures.validPassword.trim(),
        )).called(1);
      });

      test('should return failure when repository returns failure', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
        );
        
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => const DataFailed(
          error: 'Invalid credentials',
          errorCode: 'INVALID_CREDENTIALS',
        ));

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed).error, equals('Invalid credentials'));
        expect(result.errorCode, equals('INVALID_CREDENTIALS'));
      });

      test('should handle two-factor authentication response', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
        );
        
        final LoginResponseEntity twoFactorResponse = AuthFixtures.createTestLoginResponse(
          requiresTwoFactor: true,
        );
        
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => DataSuccess(twoFactorResponse));

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataSuccess<LoginResponseEntity>>());
        expect((result as DataSuccess).data?.requiresTwoFactor, isTrue);
      });
    });

    group('Remember Me', () {
      test('should save credentials when rememberMe is true and login successful', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
          rememberMe: true,
        );
        
        final LoginResponseEntity successResponse = AuthFixtures.createTestLoginResponse();
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => DataSuccess(successResponse));
        
        when(mockAuthRepository.saveCredentials(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => Future.value());

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataSuccess<LoginResponseEntity>>());
        verify(mockAuthRepository.saveCredentials(
          email: AuthFixtures.validEmail.toLowerCase(),
          password: AuthFixtures.validPassword.trim(),
        )).called(1);
      });

      test('should not save credentials when rememberMe is false', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
          rememberMe: false,
        );
        
        final LoginResponseEntity successResponse = AuthFixtures.createTestLoginResponse();
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => DataSuccess(successResponse));

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataSuccess<LoginResponseEntity>>());
        verifyNever(mockAuthRepository.saveCredentials(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ));
      });

      test('should not save credentials when login fails', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
          rememberMe: true,
        );
        
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => const DataFailed(
          error: 'Login failed',
          errorCode: 'LOGIN_FAILED',
        ));

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        verifyNever(mockAuthRepository.saveCredentials(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ));
      });
    });

    group('Error Handling', () {
      test('should handle repository exceptions', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
        );
        
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(Exception('Network error'));

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        expect(result, isA<DataFailed<LoginResponseEntity>>());
        expect((result as DataFailed).error, contains('An unexpected error occurred during login'));
        expect(result.errorCode, equals('LOGIN_ERROR'));
        expect(result.errorDetails?['exception'], contains('Network error'));
      });

      test('should handle save credentials exceptions gracefully', () async {
        // Arrange
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
          rememberMe: true,
        );
        
        final LoginResponseEntity successResponse = AuthFixtures.createTestLoginResponse();
        when(mockAuthRepository.login(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => DataSuccess(successResponse));
        
        when(mockAuthRepository.saveCredentials(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(Exception('Storage error'));

        // Act
        final DataState<LoginResponseEntity> result = await loginUseCase.call(params: params);

        // Assert
        // Should still return success even if saving credentials fails
        expect(result, isA<DataSuccess<LoginResponseEntity>>());
      });
    });

    group('LoginParams', () {
      test('should create LoginParams with default rememberMe value', () {
        // Arrange & Act
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
        );

        // Assert
        expect(params.email, equals(AuthFixtures.validEmail));
        expect(params.password, equals(AuthFixtures.validPassword));
        expect(params.rememberMe, isFalse);
      });

      test('should create LoginParams with custom rememberMe value', () {
        // Arrange & Act
        const LoginParams params = LoginParams(
          email: AuthFixtures.validEmail,
          password: AuthFixtures.validPassword,
          rememberMe: true,
        );

        // Assert
        expect(params.rememberMe, isTrue);
      });
    });
  });
}