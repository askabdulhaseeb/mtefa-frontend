import 'package:flutter_test/flutter_test.dart';
import 'package:mtefa/core/enums/status_type.dart';
import 'package:mtefa/core/enums/user_role.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';
import '../../../fixtures/auth_fixtures.dart';

void main() {
  group('UserEntity', () {
    test('should create a UserEntity with required fields', () {
      // Arrange & Act
      const UserEntity user = UserEntity(
        userId: 'user123',
        email: 'test@example.com',
        name: 'Test User',
      );

      // Assert
      expect(user.userId, equals('user123'));
      expect(user.email, equals('test@example.com'));
      expect(user.name, equals('Test User'));
      expect(user.isEmailVerified, isFalse);
      expect(user.status, equals(StatusType.active));
      expect(user.businessUsers, isEmpty);
    });

    test('should create a UserEntity with all fields', () {
      // Arrange
      final DateTime lastLogin = DateTime.now();
      final BusinessUserEntity businessUser = AuthFixtures.createTestBusinessUser();
      
      // Act
      final UserEntity user = UserEntity(
        userId: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        phone: '+1234567890',
        avatarUrl: 'https://example.com/avatar.jpg',
        isEmailVerified: true,
        isPhoneVerified: true,
        lastLoginAt: lastLogin,
        twoFactorEnabled: true,
        preferredLanguage: 'es',
        timezone: 'America/New_York',
        status: StatusType.blocked,
        businessUsers: <BusinessUserEntity>[businessUser],
        currentBusinessId: 'business123',
        currentBranchId: 'branch123',
        permissions: <String>['read', 'write'],
      );

      // Assert
      expect(user.phone, equals('+1234567890'));
      expect(user.avatarUrl, equals('https://example.com/avatar.jpg'));
      expect(user.isEmailVerified, isTrue);
      expect(user.isPhoneVerified, isTrue);
      expect(user.lastLoginAt, equals(lastLogin));
      expect(user.twoFactorEnabled, isTrue);
      expect(user.preferredLanguage, equals('es'));
      expect(user.timezone, equals('America/New_York'));
      expect(user.status, equals(StatusType.blocked));
      expect(user.businessUsers, hasLength(1));
      expect(user.currentBusinessId, equals('business123'));
      expect(user.currentBranchId, equals('branch123'));
      expect(user.permissions, equals(<String>['read', 'write']));
    });

    group('isActive', () {
      test('should return true when status is active', () {
        // Arrange
        final UserEntity user = AuthFixtures.createTestUser(status: StatusType.active);

        // Act & Assert
        expect(user.isActive, isTrue);
      });

      test('should return false when status is blocked', () {
        // Arrange
        final UserEntity user = AuthFixtures.createTestUser(status: StatusType.blocked);

        // Act & Assert
        expect(user.isActive, isFalse);
      });

      test('should return false when status is deleted', () {
        // Arrange
        final UserEntity user = AuthFixtures.createTestUser(status: StatusType.deleted);

        // Act & Assert
        expect(user.isActive, isFalse);
      });
    });

    group('hasBusinessAccess', () {
      test('should return true when user has business users', () {
        // Arrange
        final UserEntity user = AuthFixtures.createTestUser();

        // Act & Assert
        expect(user.hasBusinessAccess, isTrue);
      });

      test('should return false when user has no business users', () {
        // Arrange
        final UserEntity user = AuthFixtures.createTestUser(businessUsers: <BusinessUserEntity>[]);

        // Act & Assert
        expect(user.hasBusinessAccess, isFalse);
      });
    });

    group('currentBusinessUser', () {
      test('should return current business user when currentBusinessId matches', () {
        // Arrange
        final BusinessUserEntity businessUser1 = AuthFixtures.createTestBusinessUser(
          businessId: 'business1',
          businessUserId: 'bu1',
        );
        final BusinessUserEntity businessUser2 = AuthFixtures.createTestBusinessUser(
          businessId: 'business2',
          businessUserId: 'bu2',
        );
        final UserEntity user = UserEntity(
          userId: 'user123',
          email: 'test@example.com',
          name: 'Test User',
          businessUsers: <BusinessUserEntity>[businessUser1, businessUser2],
          currentBusinessId: 'business2',
        );

        // Act
        final BusinessUserEntity? currentBusiness = user.currentBusinessUser;

        // Assert
        expect(currentBusiness, isNotNull);
        expect(currentBusiness?.businessId, equals('business2'));
      });

      test('should return null when currentBusinessId is null', () {
        // Arrange
        final UserEntity user = AuthFixtures.createTestUser(businessUsers: <BusinessUserEntity>[]);
        
        // Act & Assert
        expect(user.currentBusinessUser, isNull);
      });

      test('should return null when currentBusinessId does not match any business', () {
        // Arrange
        final BusinessUserEntity businessUser = AuthFixtures.createTestBusinessUser(
          businessId: 'business1',
        );
        final UserEntity user = UserEntity(
          userId: 'user123',
          email: 'test@example.com',
          name: 'Test User',
          businessUsers: <BusinessUserEntity>[businessUser],
          currentBusinessId: 'nonexistent',
        );

        // Act & Assert
        expect(user.currentBusinessUser, isNull);
      });
    });

    group('copyWith', () {
      test('should create a new instance with updated values', () {
        // Arrange
        final UserEntity original = AuthFixtures.createTestUser();
        
        // Act
        final UserEntity updated = original.copyWith(
          email: 'newemail@example.com',
          name: 'Updated Name',
          isEmailVerified: false,
        );

        // Assert
        expect(updated.email, equals('newemail@example.com'));
        expect(updated.name, equals('Updated Name'));
        expect(updated.isEmailVerified, isFalse);
        // Unchanged fields should remain the same
        expect(updated.userId, equals(original.userId));
        expect(updated.phone, equals(original.phone));
      });

      test('should keep original values when no parameters are provided', () {
        // Arrange
        final UserEntity original = AuthFixtures.createTestUser();
        
        // Act
        final UserEntity copy = original.copyWith();

        // Assert
        expect(copy.userId, equals(original.userId));
        expect(copy.email, equals(original.email));
        expect(copy.name, equals(original.name));
        expect(copy.isEmailVerified, equals(original.isEmailVerified));
      });
    });

    group('Equatable', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final UserEntity user1 = AuthFixtures.createTestUser();
        final UserEntity user2 = AuthFixtures.createTestUser();

        // Act & Assert
        expect(user1, equals(user2));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final UserEntity user1 = AuthFixtures.createTestUser(email: 'user1@example.com');
        final UserEntity user2 = AuthFixtures.createTestUser(email: 'user2@example.com');

        // Act & Assert
        expect(user1, isNot(equals(user2)));
      });
    });
  });

  group('BusinessUserEntity', () {
    test('should create a BusinessUserEntity with required fields', () {
      // Arrange & Act
      const BusinessUserEntity businessUser = BusinessUserEntity(
        businessUserId: 'bu123',
        businessId: 'business123',
        userId: 'user123',
        roleId: 'role123',
        roleName: 'Manager',
      );

      // Assert
      expect(businessUser.businessUserId, equals('bu123'));
      expect(businessUser.businessId, equals('business123'));
      expect(businessUser.userId, equals('user123'));
      expect(businessUser.roleId, equals('role123'));
      expect(businessUser.roleName, equals('Manager'));
      expect(businessUser.assignedBranches, isEmpty);
      expect(businessUser.status, equals(StatusType.active));
    });

    test('should create a BusinessUserEntity with all fields', () {
      // Arrange
      final DateTime startDate = DateTime(2023, 1, 1);
      final DateTime endDate = DateTime(2024, 1, 1);
      
      // Act
      final BusinessUserEntity businessUser = BusinessUserEntity(
        businessUserId: 'bu123',
        businessId: 'business123',
        userId: 'user123',
        roleId: 'role123',
        roleName: 'Manager',
        businessName: 'Test Business',
        assignedBranches: <String>['branch1', 'branch2'],
        customPermissions: <String>['permission1', 'permission2'],
        employmentStartDate: startDate,
        employmentEndDate: endDate,
        isPrimaryBusiness: true,
        status: StatusType.deleted,
        userRole: UserRole.branchManager,
      );

      // Assert
      expect(businessUser.businessName, equals('Test Business'));
      expect(businessUser.assignedBranches, equals(<String>['branch1', 'branch2']));
      expect(businessUser.customPermissions, equals(<String>['permission1', 'permission2']));
      expect(businessUser.employmentStartDate, equals(startDate));
      expect(businessUser.employmentEndDate, equals(endDate));
      expect(businessUser.isPrimaryBusiness, isTrue);
      expect(businessUser.status, equals(StatusType.deleted));
      expect(businessUser.userRole, equals(UserRole.branchManager));
    });

    group('isActive', () {
      test('should return true when status is active', () {
        // Arrange
        final BusinessUserEntity businessUser = AuthFixtures.createTestBusinessUser(
          status: StatusType.active,
        );

        // Act & Assert
        expect(businessUser.isActive, isTrue);
      });

      test('should return false when status is not active', () {
        // Arrange
        final BusinessUserEntity businessUser = AuthFixtures.createTestBusinessUser(
          status: StatusType.blocked,
        );

        // Act & Assert
        expect(businessUser.isActive, isFalse);
      });
    });

    group('hasFullAccess', () {
      test('should return true when assignedBranches is empty', () {
        // Arrange
        const BusinessUserEntity businessUser = BusinessUserEntity(
          businessUserId: 'bu123',
          businessId: 'business123',
          userId: 'user123',
          roleId: 'role123',
          roleName: 'Manager',
          assignedBranches: <String>[],
        );

        // Act & Assert
        expect(businessUser.hasFullAccess, isTrue);
      });

      test('should return false when assignedBranches is not empty', () {
        // Arrange
        const BusinessUserEntity businessUser = BusinessUserEntity(
          businessUserId: 'bu123',
          businessId: 'business123',
          userId: 'user123',
          roleId: 'role123',
          roleName: 'Manager',
          assignedBranches: <String>['branch1'],
        );

        // Act & Assert
        expect(businessUser.hasFullAccess, isFalse);
      });
    });

    group('Equatable', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final BusinessUserEntity businessUser1 = AuthFixtures.createTestBusinessUser();
        final BusinessUserEntity businessUser2 = AuthFixtures.createTestBusinessUser();

        // Act & Assert
        expect(businessUser1, equals(businessUser2));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final BusinessUserEntity businessUser1 = AuthFixtures.createTestBusinessUser(
          businessUserId: 'bu1',
        );
        final BusinessUserEntity businessUser2 = AuthFixtures.createTestBusinessUser(
          businessUserId: 'bu2',
        );

        // Act & Assert
        expect(businessUser1, isNot(equals(businessUser2)));
      });
    });
  });
}