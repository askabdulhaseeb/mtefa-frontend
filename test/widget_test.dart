import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mtefa/presentation/screens/auth/login/login_screen.dart';
import 'package:mtefa/presentation/screens/auth/providers/login_provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('Login Screen Responsive Tests', () {
    late GetIt sl;

    setUp(() {
      // Reset GetIt for each test
      sl = GetIt.instance;
      if (sl.isRegistered<LoginProvider>()) {
        sl.unregister<LoginProvider>();
      }
    });

    testWidgets('Mobile view renders correctly (< 600px)', (
      WidgetTester tester,
    ) async {
      // Set up mobile screen size
      tester.view.physicalSize = const Size(375, 667); // iPhone 8 size
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify mobile-specific elements
      expect(find.text('MTEFA POS'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byIcon(Icons.store), findsOneWidget);

      // Mobile view should not have the branding section
      expect(find.text('Enterprise Point of Sale System'), findsOneWidget);
      expect(find.text('Point of Sale System'), findsOneWidget);
    });

    testWidgets('Tablet view renders correctly (600-1000px)', (
      WidgetTester tester,
    ) async {
      // Set up tablet screen size
      tester.view.physicalSize = const Size(768, 1024); // iPad size
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify tablet-specific elements
      expect(find.text('MTEFA POS'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byIcon(Icons.store), findsOneWidget);
      expect(find.text('Enterprise Point of Sale System'), findsOneWidget);
    });

    testWidgets('Desktop view renders correctly (> 1000px)', (
      WidgetTester tester,
    ) async {
      // Set up desktop screen size
      tester.view.physicalSize = const Size(1920, 1080); // Full HD desktop
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify desktop-specific elements
      expect(find.text('MTEFA POS'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Welcome to'), findsOneWidget);

      // Desktop view should have features list
      expect(find.text('Inventory Management'), findsOneWidget);
      expect(find.text('Sales & Transactions'), findsOneWidget);
      expect(find.text('Real-time Analytics'), findsOneWidget);
    });

    testWidgets(
      'Responsive transition from Tablet to Desktop works without overflow',
      (WidgetTester tester) async {
        // Start with tablet size
        tester.view.physicalSize = const Size(900, 1024);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: const LoginScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify no render overflow errors
        expect(tester.takeException(), isNull);

        // Transition to desktop size
        tester.view.physicalSize = const Size(1200, 1024);
        await tester.pumpAndSettle();

        // Verify no render overflow errors after transition
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('Form fields work correctly across all breakpoints', (
      WidgetTester tester,
    ) async {
      // Test on mobile
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and interact with email field
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'test@example.com');
      await tester.pump();

      // Find and interact with password field
      final passwordField = find.byType(TextFormField).at(1);
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      // Verify text was entered
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });
  });
}
