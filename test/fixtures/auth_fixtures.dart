/// Test fixtures for authentication testing
/// Provides mock data for consistent testing across test files
library;

import 'package:mtefa/core/enums/status_type.dart';
import 'package:mtefa/core/enums/user_role.dart';
import 'package:mtefa/domain/entities/auth/user_entity.dart';

class AuthFixtures {
  // Valid test credentials
  static const String validEmail = 'test@example.com';
  static const String validPassword = 'Test123!@#';
  static const String invalidEmail = 'invalid-email';
  static const String shortPassword = '12345';
  static const String emptyString = '';
  
  // Test user data
  static const String testUserId = 'test_user_123';
  static const String testUserName = 'Test User';
  static const String testPhone = '+1234567890';
  static const String testBusinessId = 'business_123';
  static const String testBranchId = 'branch_123';
  static const String testRoleId = 'role_admin';
  
  // Test token data
  static const String testAccessToken = 'test_access_token_abc123';
  static const String testRefreshToken = 'test_refresh_token_xyz789';
  static const int testExpiresIn = 3600;
  
  /// Creates a basic test user entity
  static UserEntity createTestUser({
    String? userId,
    String? email,
    String? name,
    bool isEmailVerified = true,
    StatusType status = StatusType.active,
    List<BusinessUserEntity>? businessUsers,
  }) {
    return UserEntity(
      userId: userId ?? testUserId,
      email: email ?? validEmail,
      name: name ?? testUserName,
      phone: testPhone,
      isEmailVerified: isEmailVerified,
      isPhoneVerified: true,
      lastLoginAt: DateTime(2024, 1, 1),
      twoFactorEnabled: false,
      preferredLanguage: 'en',
      timezone: 'UTC',
      status: status,
      businessUsers: businessUsers ?? <BusinessUserEntity>[createTestBusinessUser()],
      currentBusinessId: testBusinessId,
      currentBranchId: testBranchId,
      permissions: <String>['pos.access', 'sales.create', 'sales.view'],
    );
  }
  
  /// Creates a test business user entity
  static BusinessUserEntity createTestBusinessUser({
    String? businessUserId,
    String? businessId,
    String? userId,
    String? roleId,
    String? roleName,
    bool isPrimaryBusiness = true,
    StatusType status = StatusType.active,
  }) {
    return BusinessUserEntity(
      businessUserId: businessUserId ?? 'bu_123',
      businessId: businessId ?? testBusinessId,
      userId: userId ?? testUserId,
      roleId: roleId ?? testRoleId,
      roleName: roleName ?? 'Admin',
      businessName: 'Test Business',
      assignedBranches: <String>[],
      customPermissions: <String>[],
      employmentStartDate: DateTime(2023, 1, 1),
      isPrimaryBusiness: isPrimaryBusiness,
      status: status,
      userRole: UserRole.businessAdmin,
    );
  }
  
  /// Creates a test auth token entity
  static AuthTokenEntity createTestAuthToken({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
  }) {
    return AuthTokenEntity(
      accessToken: accessToken ?? testAccessToken,
      refreshToken: refreshToken ?? testRefreshToken,
      expiresIn: expiresIn ?? testExpiresIn,
      tokenType: 'Bearer',
    );
  }
  
  /// Creates a test login response entity
  static LoginResponseEntity createTestLoginResponse({
    UserEntity? user,
    AuthTokenEntity? token,
    bool requiresTwoFactor = false,
  }) {
    return LoginResponseEntity(
      user: user ?? createTestUser(),
      token: token ?? createTestAuthToken(),
      requiresTwoFactor: requiresTwoFactor,
    );
  }
  
  /// Creates test user JSON for API mocking
  static Map<String, dynamic> createTestUserJson() {
    return <String, dynamic>{
      'userId': testUserId,
      'email': validEmail,
      'name': testUserName,
      'phone': testPhone,
      'avatarUrl': null,
      'isEmailVerified': true,
      'isPhoneVerified': true,
      'lastLoginAt': '2024-01-01T00:00:00.000Z',
      'twoFactorEnabled': false,
      'preferredLanguage': 'en',
      'timezone': 'UTC',
      'status': 'active',
      'businessUsers': <Map<String, dynamic>>[createTestBusinessUserJson()],
      'currentBusinessId': testBusinessId,
      'currentBranchId': testBranchId,
      'permissions': <String>['pos.access', 'sales.create', 'sales.view'],
    };
  }
  
  /// Creates test business user JSON for API mocking
  static Map<String, dynamic> createTestBusinessUserJson() {
    return <String, dynamic>{
      'businessUserId': 'bu_123',
      'businessId': testBusinessId,
      'userId': testUserId,
      'roleId': testRoleId,
      'roleName': 'Admin',
      'businessName': 'Test Business',
      'assignedBranches': <dynamic>[],
      'customPermissions': <dynamic>[],
      'employmentStartDate': '2023-01-01T00:00:00.000Z',
      'employmentEndDate': null,
      'isPrimaryBusiness': true,
      'status': 'active',
    };
  }
  
  /// Creates test auth token JSON for API mocking
  static Map<String, dynamic> createTestAuthTokenJson() {
    return <String, dynamic>{
      'accessToken': testAccessToken,
      'refreshToken': testRefreshToken,
      'expiresIn': testExpiresIn,
      'tokenType': 'Bearer',
    };
  }
  
  /// Creates test login response JSON for API mocking
  static Map<String, dynamic> createTestLoginResponseJson() {
    return <String, dynamic>{
      'user': createTestUserJson(),
      'token': createTestAuthTokenJson(),
      'requiresTwoFactor': false,
    };
  }
  
  /// Test error scenarios
  static const Map<String, String> testErrors = <String, String>{
    'invalid_credentials': 'Invalid email or password',
    'account_disabled': 'Your account has been disabled',
    'account_locked': 'Your account has been locked',
    'network_error': 'Network connection error',
    'server_error': 'Server error occurred',
    'validation_error': 'Validation error',
  };
}