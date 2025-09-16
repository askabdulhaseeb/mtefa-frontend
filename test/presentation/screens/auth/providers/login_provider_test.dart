import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mtefa/core/resources/data_state.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';
import 'package:mtefa/domain/usecases/auth/login_usecase.dart';
import 'package:mtefa/presentation/screens/auth/providers/login_provider.dart';
import '../../../../fixtures/auth_fixtures.dart';

// Generate mock for LoginUseCase
@GenerateMocks(<Type>[LoginUseCase])
import 'login_provider_test.mocks.dart';

void main() {
  late LoginProvider loginProvider;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginProvider = LoginProvider(loginUseCase: mockLoginUseCase);
  });

  tearDown(() {
    loginProvider.dispose();
  });

  group('LoginProvider', () {
    group('Initial State', () {
      test('should have empty email and password controllers', () {
        expect(loginProvider.emailController.text, isEmpty);
        expect(loginProvider.passwordController.text, isEmpty);
      });

      test('should have initial state values', () {
        expect(loginProvider.loginState, isNull);
        expect(loginProvider.rememberMe, isFalse);
        expect(loginProvider.isPasswordVisible, isFalse);
        expect(loginProvider.emailError, isNull);
        expect(loginProvider.passwordError, isNull);
        expect(loginProvider.isLoading, isFalse);
      });

      test('should not allow submit when fields are empty', () {
        expect(loginProvider.canSubmit, isFalse);
      });
    });

    group('toggleRememberMe', () {
      test('should toggle remember me state', () {
        // Initial state
        expect(loginProvider.rememberMe, isFalse);
        
        // First toggle
        loginProvider.toggleRememberMe();
        expect(loginProvider.rememberMe, isTrue);
        
        // Second toggle
        loginProvider.toggleRememberMe();
        expect(loginProvider.rememberMe, isFalse);
      });
    });

    group('togglePasswordVisibility', () {
      test('should toggle password visibility state', () {
        // Initial state
        expect(loginProvider.isPasswordVisible, isFalse);
        
        // First toggle
        loginProvider.togglePasswordVisibility();
        expect(loginProvider.isPasswordVisible, isTrue);
        
        // Second toggle
        loginProvider.togglePasswordVisibility();
        expect(loginProvider.isPasswordVisible, isFalse);
      });
    });

    group('Error Management', () {
      test('should set and clear email error', () {
        // Set error
        loginProvider.setEmailError('Email is required');
        expect(loginProvider.emailError, equals('Email is required'));
        
        // Clear error
        loginProvider.setEmailError(null);
        expect(loginProvider.emailError, isNull);
      });

      test('should set and clear password error', () {
        // Set error
        loginProvider.setPasswordError('Password is required');
        expect(loginProvider.passwordError, equals('Password is required'));
        
        // Clear error
        loginProvider.setPasswordError(null);
        expect(loginProvider.passwordError, isNull);
      });

      test('clearErrors should clear all errors', () {
        // Set errors
        loginProvider.setEmailError('Email error');
        loginProvider.setPasswordError('Password error');
        
        // Clear all errors
        loginProvider.clearErrors();
        expect(loginProvider.emailError, isNull);
        expect(loginProvider.passwordError, isNull);
      });
    });

    group('Email Validation', () {
      test('should validate empty email', () {
        loginProvider.emailController.text = '';
        final bool isValid = loginProvider.validateEmail();
        
        expect(isValid, isFalse);
        expect(loginProvider.emailError, equals('Email is required'));
      });

      test('should validate invalid email format', () {
        final List<String> invalidEmails = <String>[
          'invalid',
          '@example.com',
          'user@',
          'user@.com',
        ];
        
        for (final String email in invalidEmails) {
          loginProvider.emailController.text = email;
          final bool isValid = loginProvider.validateEmail();
          
          expect(isValid, isFalse, reason: 'Email "$email" should be invalid');
          expect(loginProvider.emailError, equals('Please enter a valid email'));
        }
      });

      test('should validate correct email format', () {
        final List<String> validEmails = <String>[
          'user@example.com',
          'user.name@example.com',
          'user+tag@example.co.uk',
        ];
        
        for (final String email in validEmails) {
          loginProvider.emailController.text = email;
          final bool isValid = loginProvider.validateEmail();
          
          expect(isValid, isTrue, reason: 'Email "$email" should be valid');
          expect(loginProvider.emailError, isNull);
        }
      });
    });

    group('Password Validation', () {
      test('should validate empty password', () {
        loginProvider.passwordController.text = '';
        final bool isValid = loginProvider.validatePassword();
        
        expect(isValid, isFalse);
        expect(loginProvider.passwordError, equals('Password is required'));
      });

      test('should validate short password', () {
        loginProvider.passwordController.text = '12345';
        final bool isValid = loginProvider.validatePassword();
        
        expect(isValid, isFalse);
        expect(loginProvider.passwordError, equals('Password must be at least 6 characters'));
      });

      test('should validate valid password', () {
        loginProvider.passwordController.text = '123456';
        final bool isValid = loginProvider.validatePassword();
        
        expect(isValid, isTrue);
        expect(loginProvider.passwordError, isNull);
      });
    });

    group('Form Validation', () {
      test('should return false when email and password are invalid', () {
        loginProvider.emailController.text = '';
        loginProvider.passwordController.text = '';
        
        final bool isValid = loginProvider.validateForm();
        
        expect(isValid, isFalse);
        expect(loginProvider.emailError, isNotNull);
        expect(loginProvider.passwordError, isNotNull);
      });

      test('should return false when only email is invalid', () {
        loginProvider.emailController.text = 'invalid';
        loginProvider.passwordController.text = '123456';
        
        final bool isValid = loginProvider.validateForm();
        
        expect(isValid, isFalse);
        expect(loginProvider.emailError, isNotNull);
        expect(loginProvider.passwordError, isNull);
      });

      test('should return false when only password is invalid', () {
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123';
        
        final bool isValid = loginProvider.validateForm();
        
        expect(isValid, isFalse);
        expect(loginProvider.emailError, isNull);
        expect(loginProvider.passwordError, isNotNull);
      });

      test('should return true when both are valid', () {
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        
        final bool isValid = loginProvider.validateForm();
        
        expect(isValid, isTrue);
        expect(loginProvider.emailError, isNull);
        expect(loginProvider.passwordError, isNull);
      });
    });

    group('canSubmit', () {
      test('should not allow submit when email is empty', () {
        loginProvider.emailController.text = '';
        loginProvider.passwordController.text = '123456';
        
        expect(loginProvider.canSubmit, isFalse);
      });

      test('should not allow submit when password is empty', () {
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '';
        
        expect(loginProvider.canSubmit, isFalse);
      });

      test('should not allow submit when loading', () {
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        
        // Simulate loading state by calling login
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async {
          await Future.delayed(const Duration(seconds: 1));
          return DataSuccess(AuthFixtures.createTestLoginResponse());
        });
        
        loginProvider.login();
        expect(loginProvider.canSubmit, isFalse);
      });

      test('should allow submit when all conditions are met', () {
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        
        expect(loginProvider.canSubmit, isTrue);
      });
    });

    group('Login Process', () {
      test('should not proceed with login if validation fails', () async {
        // Set invalid data
        loginProvider.emailController.text = '';
        loginProvider.passwordController.text = '';
        
        // Attempt login
        await loginProvider.login();
        
        // Verify use case was not called
        verifyNever(mockLoginUseCase.call(params: anyNamed('params')));
        expect(loginProvider.emailError, isNotNull);
        expect(loginProvider.passwordError, isNotNull);
      });

      test('should set loading state during login', () async {
        // Set valid data
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        
        // Setup mock response with delay
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return DataSuccess(AuthFixtures.createTestLoginResponse());
        });
        
        // Start login
        final Future<void> loginFuture = loginProvider.login();
        
        // Check loading state immediately
        expect(loginProvider.isLoading, isTrue);
        expect(loginProvider.loginState, isA<DataLoading>());
        
        // Wait for completion
        await loginFuture;
        
        // Check loading state after completion
        expect(loginProvider.isLoading, isFalse);
      });

      test('should handle successful API login', () async {
        // Set valid data
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        
        // Setup mock response
        final LoginResponseEntity successResponse = AuthFixtures.createTestLoginResponse();
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async => DataSuccess(successResponse));
        
        // Perform login
        await loginProvider.login();
        
        // Verify state
        expect(loginProvider.loginState, isA<DataSuccess>());
        expect(loginProvider.isLoading, isFalse);
        expect(loginProvider.emailError, isNull);
        expect(loginProvider.passwordError, isNull);
        
        // Verify use case was called with correct params
        final LoginParams capturedParams = verify(
          mockLoginUseCase.call(params: captureAnyNamed('params'))
        ).captured.single as LoginParams;
        
        expect(capturedParams.email, equals('user@example.com'));
        expect(capturedParams.password, equals('123456'));
        expect(capturedParams.rememberMe, isFalse);
      });

      test('should handle login with remember me', () async {
        // Set valid data
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        loginProvider.toggleRememberMe(); // Enable remember me
        
        // Setup mock response
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async => DataSuccess(AuthFixtures.createTestLoginResponse()));
        
        // Perform login
        await loginProvider.login();
        
        // Verify use case was called with rememberMe = true
        final LoginParams capturedParams = verify(
          mockLoginUseCase.call(params: captureAnyNamed('params'))
        ).captured.single as LoginParams;
        
        expect(capturedParams.rememberMe, isTrue);
      });

      test('should handle login failure with error codes', () async {
        // Set valid data
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = 'wrong_password';
        
        // Setup mock response with failure
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async => const DataFailed<LoginResponseEntity>(
          error: 'Invalid credentials',
          errorCode: 'INVALID_CREDENTIALS',
        ));
        
        // Perform login
        await loginProvider.login();
        
        // Verify state
        expect(loginProvider.loginState, isA<DataFailed>());
        expect(loginProvider.isLoading, isFalse);
        expect(loginProvider.emailError, equals('Invalid email or password'));
        expect(loginProvider.passwordError, equals('Invalid email or password'));
      });

      test('should handle specific error codes', () async {
        final List<Map<String, String?>> testCases = <Map<String, String?>>[
          <String, String?>{'code': 'INVALID_EMAIL', 'expectedEmailError': 'Invalid email', 'expectedPasswordError': null},
          <String, String?>{'code': 'EMAIL_REQUIRED', 'expectedEmailError': 'Email required', 'expectedPasswordError': null},
          <String, String?>{'code': 'PASSWORD_REQUIRED', 'expectedEmailError': null, 'expectedPasswordError': 'Password required'},
          <String, String?>{'code': 'PASSWORD_TOO_SHORT', 'expectedEmailError': null, 'expectedPasswordError': 'Password too short'},
          <String, String?>{'code': 'ACCOUNT_DISABLED', 'expectedEmailError': 'Account disabled', 'expectedPasswordError': null},
          <String, String?>{'code': 'ACCOUNT_LOCKED', 'expectedEmailError': 'Account locked', 'expectedPasswordError': null},
        ];
        
        for (final Map<String, String?> testCase in testCases) {
          // Reset provider
          loginProvider.clearErrors();
          loginProvider.emailController.text = 'user@example.com';
          loginProvider.passwordController.text = '123456';
          
          // Setup mock response
          when(mockLoginUseCase.call(params: anyNamed('params')))
              .thenAnswer((_) async => DataFailed<LoginResponseEntity>(
            error: testCase['code'] as String,
            errorCode: testCase['code'] as String,
          ));
          
          // Perform login
          await loginProvider.login();
          
          // Verify error handling
          if (testCase['expectedEmailError'] != null) {
            expect(loginProvider.emailError, equals(testCase['expectedEmailError']));
          } else {
            expect(loginProvider.emailError, isNull);
          }
          
          if (testCase['expectedPasswordError'] != null) {
            expect(loginProvider.passwordError, equals(testCase['expectedPasswordError']));
          } else {
            expect(loginProvider.passwordError, isNull);
          }
        }
      });

      test('should handle unexpected exceptions', () async {
        // Set valid data
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        
        // Setup mock to throw exception
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenThrow(Exception('Network error'));
        
        // Perform login
        await loginProvider.login();
        
        // Verify state
        expect(loginProvider.loginState, isA<DataFailed>());
        expect((loginProvider.loginState as DataFailed).errorCode, equals('UNEXPECTED_ERROR'));
        expect(loginProvider.isLoading, isFalse);
      });
    });

    group('loginWithSavedCredentials', () {
      test('should populate fields and perform login', () async {
        // Setup mock response
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async => DataSuccess(AuthFixtures.createTestLoginResponse()));
        
        // Call with saved credentials
        await loginProvider.loginWithSavedCredentials('saved@example.com', 'savedPassword');
        
        // Verify fields were populated
        expect(loginProvider.emailController.text, equals('saved@example.com'));
        expect(loginProvider.passwordController.text, equals('savedPassword'));
        expect(loginProvider.rememberMe, isTrue);
        
        // Verify login was called
        verify(mockLoginUseCase.call(params: anyNamed('params'))).called(1);
      });
    });

    group('clearLoginState', () {
      test('should clear login state', () async {
        // Set some state
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async => DataSuccess(AuthFixtures.createTestLoginResponse()));
        
        await loginProvider.login();
        expect(loginProvider.loginState, isNotNull);
        
        // Clear state
        loginProvider.clearLoginState();
        expect(loginProvider.loginState, isNull);
      });
    });

    group('resetForm', () {
      test('should reset all form values to initial state', () async {
        // Set various states
        loginProvider.emailController.text = 'user@example.com';
        loginProvider.passwordController.text = '123456';
        loginProvider.toggleRememberMe();
        loginProvider.togglePasswordVisibility();
        loginProvider.setEmailError('Some error');
        loginProvider.setPasswordError('Some error');
        
        // Perform login to set login state
        when(mockLoginUseCase.call(params: anyNamed('params')))
            .thenAnswer((_) async => DataSuccess(AuthFixtures.createTestLoginResponse()));
        await loginProvider.login();
        
        // Reset form
        loginProvider.resetForm();
        
        // Verify all values are reset
        expect(loginProvider.emailController.text, isEmpty);
        expect(loginProvider.passwordController.text, isEmpty);
        expect(loginProvider.rememberMe, isFalse);
        expect(loginProvider.isPasswordVisible, isFalse);
        expect(loginProvider.emailError, isNull);
        expect(loginProvider.passwordError, isNull);
        expect(loginProvider.loginState, isNull);
        expect(loginProvider.isLoading, isFalse);
      });
    });
  });
}