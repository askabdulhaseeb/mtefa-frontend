import 'package:flutter_test/flutter_test.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';
import '../../../fixtures/auth_fixtures.dart';

void main() {
  group('AuthTokenEntity', () {
    test('should create an AuthTokenEntity with required fields', () {
      // Arrange & Act
      const token = AuthTokenEntity(
        accessToken: 'access123',
        refreshToken: 'refresh123',
        expiresIn: 3600,
      );

      // Assert
      expect(token.accessToken, equals('access123'));
      expect(token.refreshToken, equals('refresh123'));
      expect(token.expiresIn, equals(3600));
      expect(token.tokenType, equals('Bearer'));
    });

    test('should create an AuthTokenEntity with custom token type', () {
      // Arrange & Act
      const token = AuthTokenEntity(
        accessToken: 'access123',
        refreshToken: 'refresh123',
        expiresIn: 7200,
        tokenType: 'CustomBearer',
      );

      // Assert
      expect(token.tokenType, equals('CustomBearer'));
    });

    group('expiresAt', () {
      test('should calculate expiration time correctly', () {
        // Arrange
        final beforeCreation = DateTime.now();
        const token = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 3600, // 1 hour
        );
        final afterCreation = DateTime.now();

        // Act
        final expiresAt = token.expiresAt;

        // Assert
        final expectedMinTime = beforeCreation.add(const Duration(seconds: 3600));
        final expectedMaxTime = afterCreation.add(const Duration(seconds: 3600));
        
        expect(expiresAt.isAfter(expectedMinTime.subtract(const Duration(seconds: 1))), isTrue);
        expect(expiresAt.isBefore(expectedMaxTime.add(const Duration(seconds: 1))), isTrue);
      });
    });

    group('isExpired', () {
      test('should return false for a non-expired token', () {
        // Arrange
        const token = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 3600, // 1 hour from now
        );

        // Act & Assert
        expect(token.isExpired, isFalse);
      });

      test('should return true for an expired token', () {
        // Arrange
        const token = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 0, // Already expired
        );

        // Act & Assert
        expect(token.isExpired, isTrue);
      });

      test('should return true for a token with negative expiration', () {
        // Arrange
        const token = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: -3600, // Expired 1 hour ago
        );

        // Act & Assert
        expect(token.isExpired, isTrue);
      });
    });

    group('Equatable', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        const token1 = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 3600,
          tokenType: 'Bearer',
        );
        const token2 = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 3600,
          tokenType: 'Bearer',
        );

        // Act & Assert
        expect(token1, equals(token2));
      });

      test('should not be equal when accessToken differs', () {
        // Arrange
        const token1 = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 3600,
        );
        const token2 = AuthTokenEntity(
          accessToken: 'access456',
          refreshToken: 'refresh123',
          expiresIn: 3600,
        );

        // Act & Assert
        expect(token1, isNot(equals(token2)));
      });

      test('should not be equal when refreshToken differs', () {
        // Arrange
        const token1 = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 3600,
        );
        const token2 = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh456',
          expiresIn: 3600,
        );

        // Act & Assert
        expect(token1, isNot(equals(token2)));
      });

      test('should not be equal when expiresIn differs', () {
        // Arrange
        const token1 = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 3600,
        );
        const token2 = AuthTokenEntity(
          accessToken: 'access123',
          refreshToken: 'refresh123',
          expiresIn: 7200,
        );

        // Act & Assert
        expect(token1, isNot(equals(token2)));
      });
    });

    test('should create token from fixture', () {
      // Arrange & Act
      final token = AuthFixtures.createTestAuthToken();

      // Assert
      expect(token.accessToken, equals(AuthFixtures.testAccessToken));
      expect(token.refreshToken, equals(AuthFixtures.testRefreshToken));
      expect(token.expiresIn, equals(AuthFixtures.testExpiresIn));
    });
  });

  group('LoginResponseEntity', () {
    test('should create a LoginResponseEntity with required fields', () {
      // Arrange
      final user = AuthFixtures.createTestUser();
      final token = AuthFixtures.createTestAuthToken();
      
      // Act
      final loginResponse = LoginResponseEntity(
        user: user,
        token: token,
      );

      // Assert
      expect(loginResponse.user, equals(user));
      expect(loginResponse.token, equals(token));
      expect(loginResponse.requiresTwoFactor, isFalse);
      expect(loginResponse.twoFactorMethod, isNull);
    });

    test('should create a LoginResponseEntity with two-factor authentication', () {
      // Arrange
      final user = AuthFixtures.createTestUser();
      final token = AuthFixtures.createTestAuthToken();
      
      // Act
      final loginResponse = LoginResponseEntity(
        user: user,
        token: token,
        requiresTwoFactor: true,
        twoFactorMethod: 'sms',
      );

      // Assert
      expect(loginResponse.requiresTwoFactor, isTrue);
      expect(loginResponse.twoFactorMethod, equals('sms'));
    });

    test('should handle different two-factor methods', () {
      // Arrange
      final user = AuthFixtures.createTestUser();
      final token = AuthFixtures.createTestAuthToken();
      final methods = ['sms', 'email', 'authenticator'];
      
      // Act & Assert
      for (final method in methods) {
        final loginResponse = LoginResponseEntity(
          user: user,
          token: token,
          requiresTwoFactor: true,
          twoFactorMethod: method,
        );
        expect(loginResponse.twoFactorMethod, equals(method));
      }
    });

    group('Equatable', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final user = AuthFixtures.createTestUser();
        final token = AuthFixtures.createTestAuthToken();
        
        final loginResponse1 = LoginResponseEntity(
          user: user,
          token: token,
          requiresTwoFactor: true,
          twoFactorMethod: 'sms',
        );
        final loginResponse2 = LoginResponseEntity(
          user: user,
          token: token,
          requiresTwoFactor: true,
          twoFactorMethod: 'sms',
        );

        // Act & Assert
        expect(loginResponse1, equals(loginResponse2));
      });

      test('should not be equal when user differs', () {
        // Arrange
        final user1 = AuthFixtures.createTestUser(userId: 'user1');
        final user2 = AuthFixtures.createTestUser(userId: 'user2');
        final token = AuthFixtures.createTestAuthToken();
        
        final loginResponse1 = LoginResponseEntity(user: user1, token: token);
        final loginResponse2 = LoginResponseEntity(user: user2, token: token);

        // Act & Assert
        expect(loginResponse1, isNot(equals(loginResponse2)));
      });

      test('should not be equal when token differs', () {
        // Arrange
        final user = AuthFixtures.createTestUser();
        final token1 = AuthFixtures.createTestAuthToken(accessToken: 'token1');
        final token2 = AuthFixtures.createTestAuthToken(accessToken: 'token2');
        
        final loginResponse1 = LoginResponseEntity(user: user, token: token1);
        final loginResponse2 = LoginResponseEntity(user: user, token: token2);

        // Act & Assert
        expect(loginResponse1, isNot(equals(loginResponse2)));
      });

      test('should not be equal when requiresTwoFactor differs', () {
        // Arrange
        final user = AuthFixtures.createTestUser();
        final token = AuthFixtures.createTestAuthToken();
        
        final loginResponse1 = LoginResponseEntity(
          user: user,
          token: token,
          requiresTwoFactor: true,
        );
        final loginResponse2 = LoginResponseEntity(
          user: user,
          token: token,
          requiresTwoFactor: false,
        );

        // Act & Assert
        expect(loginResponse1, isNot(equals(loginResponse2)));
      });

      test('should not be equal when twoFactorMethod differs', () {
        // Arrange
        final user = AuthFixtures.createTestUser();
        final token = AuthFixtures.createTestAuthToken();
        
        final loginResponse1 = LoginResponseEntity(
          user: user,
          token: token,
          requiresTwoFactor: true,
          twoFactorMethod: 'sms',
        );
        final loginResponse2 = LoginResponseEntity(
          user: user,
          token: token,
          requiresTwoFactor: true,
          twoFactorMethod: 'email',
        );

        // Act & Assert
        expect(loginResponse1, isNot(equals(loginResponse2)));
      });
    });

    test('should create login response from fixture', () {
      // Arrange & Act
      final loginResponse = AuthFixtures.createTestLoginResponse();

      // Assert
      expect(loginResponse.user.userId, equals(AuthFixtures.testUserId));
      expect(loginResponse.token.accessToken, equals(AuthFixtures.testAccessToken));
      expect(loginResponse.requiresTwoFactor, isFalse);
    });

    test('should create login response with two-factor from fixture', () {
      // Arrange & Act
      final loginResponse = AuthFixtures.createTestLoginResponse(
        requiresTwoFactor: true,
      );

      // Assert
      expect(loginResponse.requiresTwoFactor, isTrue);
    });
  });
}