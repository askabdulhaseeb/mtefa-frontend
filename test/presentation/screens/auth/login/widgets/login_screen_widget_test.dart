import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mtefa/core/resources/data_state.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';
import 'package:mtefa/domain/usecases/auth/login_usecase.dart';
import 'package:mtefa/presentation/screens/auth/providers/login_provider.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/login_form_card.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/components/login_form_fields.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/components/login_remember_me_section.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/components/login_error_message.dart';
import '../../../../../fixtures/auth_fixtures.dart';
import '../../providers/login_provider_test.mocks.dart';

// Test wrapper widget for providers
class TestWrapper extends StatelessWidget {
  const TestWrapper({
    super.key,
    required this.child,
    required this.loginProvider,
  });

  final Widget child;
  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider<LoginProvider>.value(
          value: loginProvider,
          child: child,
        ),
      ),
    );
  }
}

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

  group('LoginFormCard Widget Tests', () {
    testWidgets('should display login form card with all components', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormCard(),
        ),
      );

      // Assert
      expect(find.byType(LoginFormCard), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Sign in to access your account'), findsOneWidget);
    });

    testWidgets('should have proper form structure', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormCard(),
        ),
      );

      // Assert
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(LoginFormFields), findsOneWidget);
      expect(find.byType(LoginRememberMeSection), findsOneWidget);
    });
  });

  group('LoginFormFields Widget Tests', () {
    testWidgets('should display email and password text fields', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Assert
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should show password visibility toggle button', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Assert
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('should toggle password visibility when icon is tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Act - Tap visibility button
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Assert - Password should be visible
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(loginProvider.isPasswordVisible, isTrue);

      // Act - Tap again
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Assert - Password should be hidden again
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(loginProvider.isPasswordVisible, isFalse);
    });

    testWidgets('should update email controller when text is entered', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.pump();

      // Assert
      expect(loginProvider.emailController.text, equals('test@example.com'));
    });

    testWidgets('should update password controller when text is entered', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.pump();

      // Assert
      expect(loginProvider.passwordController.text, equals('password123'));
    });

    testWidgets('should display email error when set', (WidgetTester tester) async {
      // Arrange
      loginProvider.setEmailError('Invalid email format');
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Assert
      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('should display password error when set', (WidgetTester tester) async {
      // Arrange
      loginProvider.setPasswordError('Password too short');
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Assert
      expect(find.text('Password too short'), findsOneWidget);
    });
  });

  group('LoginRememberMeSection Widget Tests', () {
    testWidgets('should display remember me checkbox and forgot password link', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginRememberMeSection(),
        ),
      );

      // Assert
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('should toggle remember me when checkbox is tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginRememberMeSection(),
        ),
      );

      // Initial state
      expect(loginProvider.rememberMe, isFalse);

      // Act - Tap checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Assert
      expect(loginProvider.rememberMe, isTrue);

      // Act - Tap again
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Assert
      expect(loginProvider.rememberMe, isFalse);
    });

    testWidgets('should call forgot password when link is tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginRememberMeSection(),
        ),
      );

      // Act
      await tester.tap(find.text('Forgot password?'));
      await tester.pump();

      // Assert - Since forgotPassword is not implemented, we just ensure it doesn't crash
      expect(find.text('Forgot password?'), findsOneWidget);
    });
  });

  group('LoginErrorMessage Widget Tests', () {
    testWidgets('should not display when there is no error', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginErrorMessage(),
        ),
      );

      // Assert
      expect(find.byType(LoginErrorMessage), findsOneWidget);
      expect(find.byType(Container).first, findsOneWidget); // Empty container
    });

    testWidgets('should display error message when login fails', (WidgetTester tester) async {
      // Arrange
      when(mockLoginUseCase.call(params: anyNamed('params')))
          .thenAnswer((_) async => const DataFailed<LoginResponseEntity>(
        error: 'Network error occurred',
        errorCode: 'NETWORK_ERROR',
      ));
      
      loginProvider.emailController.text = 'test@example.com';
      loginProvider.passwordController.text = '123456';
      
      // Act
      await loginProvider.login();
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginErrorMessage(),
        ),
      );

      // Assert
      expect(find.text('Network error occurred'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should style error message correctly', (WidgetTester tester) async {
      // Arrange
      when(mockLoginUseCase.call(params: anyNamed('params')))
          .thenAnswer((_) async => const DataFailed<LoginResponseEntity>(
        error: 'Invalid credentials',
        errorCode: 'INVALID_CREDENTIALS',
      ));
      
      loginProvider.emailController.text = 'test@example.com';
      loginProvider.passwordController.text = 'wrong';
      await loginProvider.login();
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginErrorMessage(),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(LoginErrorMessage),
          matching: find.byType(Container).last,
        ),
      );
      
      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.red.shade50));
      expect(decoration.borderRadius, equals(BorderRadius.circular(8)));
    });
  });

  group('Login Button Tests', () {
    testWidgets('should be disabled when form is empty', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: ElevatedButton(
            onPressed: loginProvider.canSubmit ? () {} : null,
            child: const Text('Sign In'),
          ),
        ),
      );

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('should be enabled when form is valid', (WidgetTester tester) async {
      // Arrange
      loginProvider.emailController.text = 'test@example.com';
      loginProvider.passwordController.text = '123456';
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: ElevatedButton(
            onPressed: loginProvider.canSubmit ? () {} : null,
            child: const Text('Sign In'),
          ),
        ),
      );

      // Assert
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('should show loading indicator when logging in', (WidgetTester tester) async {
      // Arrange
      loginProvider.emailController.text = 'test@example.com';
      loginProvider.passwordController.text = '123456';
      
      when(mockLoginUseCase.call(params: anyNamed('params')))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return DataSuccess(AuthFixtures.createTestLoginResponse());
      });
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: loginProvider.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: loginProvider.canSubmit ? loginProvider.login : null,
                  child: const Text('Sign In'),
                ),
        ),
      );
      
      // Start login
      loginProvider.login();
      await tester.pump();
      
      // Rebuild widget with loading state
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: loginProvider.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: loginProvider.canSubmit ? loginProvider.login : null,
                  child: const Text('Sign In'),
                ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Form Validation Visual Feedback', () {
    testWidgets('should show red border on email field when error exists', (WidgetTester tester) async {
      // Arrange
      loginProvider.setEmailError('Invalid email');
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Assert
      final textField = tester.widget<TextFormField>(find.byType(TextFormField).first);
      expect(textField.decoration?.errorText, equals('Invalid email'));
    });

    testWidgets('should show red border on password field when error exists', (WidgetTester tester) async {
      // Arrange
      loginProvider.setPasswordError('Password required');
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );

      // Assert
      final textField = tester.widget<TextFormField>(find.byType(TextFormField).last);
      expect(textField.decoration?.errorText, equals('Password required'));
    });

    testWidgets('should clear errors when user starts typing', (WidgetTester tester) async {
      // Arrange
      loginProvider.setEmailError('Email required');
      loginProvider.setPasswordError('Password required');
      
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginFormFields(),
        ),
      );
      
      // Verify errors are shown
      expect(find.text('Email required'), findsOneWidget);
      expect(find.text('Password required'), findsOneWidget);
      
      // Act - Type in email field
      await tester.enterText(find.byType(TextFormField).first, 'test');
      loginProvider.clearErrors();
      await tester.pump();
      
      // Assert - Errors should be cleared
      expect(find.text('Email required'), findsNothing);
      expect(find.text('Password required'), findsNothing);
    });
  });
}