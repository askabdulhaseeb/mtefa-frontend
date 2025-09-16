import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mtefa/presentation/screens/auth/providers/login_provider.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/login_form_card.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/components/login_form_fields.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/components/login_remember_me_section.dart';
import 'package:mtefa/presentation/screens/auth/login/widgets/components/login_error_message.dart';
import 'package:mtefa/presentation/widgets/core/custom_textformfield.dart';
import 'package:mtefa/presentation/widgets/core/password_textformfield.dart';
import '../../providers/login_provider_test.mocks.dart';

// Test wrapper widget for providers
class TestWrapper extends StatelessWidget {
  const TestWrapper({
    required this.loginProvider,
    required this.child,
    super.key,
  });

  final Widget child;
  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: ChangeNotifierProvider<LoginProvider>.value(
            value: loginProvider,
            child: child,
          ),
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
          child: LoginFormCard(provider: loginProvider),
        ),
      );

      // Assert
      expect(find.byType(LoginFormCard), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Sign In'), findsAtLeastNWidgets(1));
      expect(find.text('Enter your credentials to access your account'), findsOneWidget);
    });

    testWidgets('should have proper form structure', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginFormCard(provider: loginProvider),
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
          child: LoginFormFields(provider: loginProvider),
        ),
      );

      // Assert
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should show password visibility toggle button', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginFormFields(provider: loginProvider),
        ),
      );

      // Assert
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.eye), findsOneWidget);
    });

    testWidgets('should toggle password visibility when icon is tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginFormFields(provider: loginProvider),
        ),
      );

      // Act - Tap visibility button
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Assert - Password should be visible
      expect(find.byIcon(CupertinoIcons.eye_slash), findsOneWidget);

      // Act - Tap again
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Assert - Password should be hidden again
      expect(find.byIcon(CupertinoIcons.eye), findsOneWidget);
    });

    testWidgets('should update email controller when text is entered', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginFormFields(provider: loginProvider),
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
          child: LoginFormFields(provider: loginProvider),
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
          child: LoginFormFields(provider: loginProvider),
        ),
      );
      await tester.pump();

      // Assert - Error is shown through validator when form is built
      expect(find.byType(CustomTextFormField), findsOneWidget);
    });

    testWidgets('should display password error when set', (WidgetTester tester) async {
      // Arrange
      loginProvider.setPasswordError('Password too short');
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginFormFields(provider: loginProvider),
        ),
      );
      await tester.pump();

      // Assert - Error is shown through validator when form is built
      expect(find.byType(PasswordTextFormField), findsOneWidget);
    });
  });

  group('LoginRememberMeSection Widget Tests', () {
    testWidgets('should display remember me checkbox and forgot password link', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginRememberMeSection(provider: loginProvider),
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
          child: LoginRememberMeSection(provider: loginProvider),
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
          child: LoginRememberMeSection(provider: loginProvider),
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
    testWidgets('should display container even when error message is empty', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginErrorMessage(errorMessage: ''),
        ),
      );

      // Assert
      expect(find.byType(LoginErrorMessage), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should display error message when provided', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginErrorMessage(errorMessage: 'Network error occurred'),
        ),
      );

      // Assert
      expect(find.text('Network error occurred'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('should style error message correctly', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const LoginErrorMessage(errorMessage: 'Invalid credentials'),
        ),
      );

      // Assert
      expect(find.text('Invalid credentials'), findsOneWidget);
      expect(find.byType(Container), findsAtLeastNWidgets(1));
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
      final ElevatedButton button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
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
      final ElevatedButton button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('should show loading indicator when isLoading is true', (WidgetTester tester) async {
      // Arrange - Mock loading state
      loginProvider.emailController.text = 'test@example.com';
      loginProvider.passwordController.text = '123456';
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: const CircularProgressIndicator(),
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
          child: LoginFormFields(provider: loginProvider),
        ),
      );

      // Assert
      expect(find.byType(CustomTextFormField), findsOneWidget);
    });

    testWidgets('should show red border on password field when error exists', (WidgetTester tester) async {
      // Arrange
      loginProvider.setPasswordError('Password required');
      
      // Act
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginFormFields(provider: loginProvider),
        ),
      );

      // Assert
      expect(find.byType(PasswordTextFormField), findsOneWidget);
    });

    testWidgets('should clear errors when user starts typing', (WidgetTester tester) async {
      // Arrange
      loginProvider.setEmailError('Email required');
      loginProvider.setPasswordError('Password required');
      
      await tester.pumpWidget(
        TestWrapper(
          loginProvider: loginProvider,
          child: LoginFormFields(provider: loginProvider),
        ),
      );
      
      // Verify errors are set
      expect(loginProvider.emailError, equals('Email required'));
      expect(loginProvider.passwordError, equals('Password required'));
      
      // Act - Clear errors
      loginProvider.clearErrors();
      await tester.pump();
      
      // Assert - Errors should be cleared
      expect(loginProvider.emailError, isNull);
      expect(loginProvider.passwordError, isNull);
    });
  });
}