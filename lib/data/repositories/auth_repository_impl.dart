import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/enums/status_type.dart';
import '../../core/resources/data_state.dart';
import '../../core/utils/token_manager.dart';
import '../../domain/entities/auth/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.tokenManager,
    required this.secureStorage,
    required this.sharedPreferences,
  });

  final TokenManager tokenManager;
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  static const String _keyEmail = 'saved_email';
  static const String _keyPassword = 'saved_password';
  static const String _keyRememberMe = 'remember_me';
  static const String _keyCurrentUser = 'current_user';
  static const String _keyAuthToken = 'auth_token';

  @override
  Future<DataState<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement actual API call when backend is ready
      // For now, return mock data for UI development

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Create mock user
      final UserEntity mockUser = UserEntity(
        userId: 'user_123',
        email: email,
        name: 'Test User',
        phone: '+1234567890',
        isEmailVerified: true,
        lastLoginAt: DateTime.now(),
        businessUsers: <BusinessUserEntity>[
          const BusinessUserEntity(
            businessUserId: 'bu_123',
            businessId: 'business_123',
            userId: 'user_123',
            roleId: 'role_cashier',
            roleName: 'Cashier',
            businessName: 'Test Business',
            isPrimaryBusiness: true,
          ),
        ],
        currentBusinessId: 'business_123',
        permissions: <String>['pos.access', 'sales.create', 'sales.view'],
      );

      // Create mock token
      final AuthTokenEntity mockToken = const AuthTokenEntity(
        accessToken: 'mock_access_token_123',
        refreshToken: 'mock_refresh_token_123',
        expiresIn: 3600,
      );

      // Save user and token locally
      await _saveUserData(mockUser);
      await _saveAuthToken(mockToken);
      await tokenManager.saveTokens(
        accessToken: mockToken.accessToken,
        refreshToken: mockToken.refreshToken,
        expiresIn: mockToken.expiresIn,
      );

      // Create login response
      final LoginResponseEntity loginResponse = LoginResponseEntity(
        user: mockUser,
        token: mockToken,
        requiresTwoFactor: false,
      );

      return DataSuccess(loginResponse);
    } catch (e) {
      return DataFailed(
        error: 'Login failed: ${e.toString()}',
        errorCode: 'LOGIN_FAILED',
      );
    }
  }

  @override
  Future<DataState<LoginResponseEntity>> verifyTwoFactor({
    required String code,
    required String method,
  }) async {
    try {
      // TODO: Implement two-factor verification
      return const DataFailed(
        error: 'Two-factor authentication not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Two-factor verification failed: ${e.toString()}',
        errorCode: 'TWO_FACTOR_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      // Clear all stored data
      await tokenManager.clearTokens();
      await _clearUserData();
      await _clearAuthToken();

      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(
        error: 'Logout failed: ${e.toString()}',
        errorCode: 'LOGOUT_FAILED',
      );
    }
  }

  @override
  Future<DataState<UserEntity>> getCurrentUser() async {
    try {
      final UserEntity? userData = await _getUserData();
      if (userData == null) {
        return const DataFailed(
          error: 'No user data found',
          errorCode: 'NO_USER',
        );
      }
      return DataSuccess(userData);
    } catch (e) {
      return DataFailed(
        error: 'Failed to get current user: ${e.toString()}',
        errorCode: 'GET_USER_FAILED',
      );
    }
  }

  @override
  Future<DataState<AuthTokenEntity>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      // TODO: Implement token refresh
      return const DataFailed(
        error: 'Token refresh not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Token refresh failed: ${e.toString()}',
        errorCode: 'REFRESH_FAILED',
      );
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return await tokenManager.isAuthenticated();
  }

  @override
  Future<Map<String, String>?> getSavedCredentials() async {
    try {
      final bool rememberMe =
          sharedPreferences.getBool(_keyRememberMe) ?? false;
      if (!rememberMe) return null;

      final String? email = await secureStorage.read(key: _keyEmail);
      final String? password = await secureStorage.read(key: _keyPassword);

      if (email == null || password == null) return null;

      return <String, String>{'email': email, 'password': password};
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveCredentials({
    required String email,
    required String password,
  }) async {
    await secureStorage.write(key: _keyEmail, value: email);
    await secureStorage.write(key: _keyPassword, value: password);
    await sharedPreferences.setBool(_keyRememberMe, true);
  }

  @override
  Future<void> clearSavedCredentials() async {
    await secureStorage.delete(key: _keyEmail);
    await secureStorage.delete(key: _keyPassword);
    await sharedPreferences.remove(_keyRememberMe);
  }

  @override
  Future<DataState<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // TODO: Implement password change
      return const DataFailed(
        error: 'Password change not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Password change failed: ${e.toString()}',
        errorCode: 'CHANGE_PASSWORD_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> requestPasswordReset({required String email}) async {
    try {
      // TODO: Implement password reset request
      return const DataFailed(
        error: 'Password reset not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Password reset request failed: ${e.toString()}',
        errorCode: 'RESET_REQUEST_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      // TODO: Implement password reset
      return const DataFailed(
        error: 'Password reset not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Password reset failed: ${e.toString()}',
        errorCode: 'RESET_FAILED',
      );
    }
  }

  @override
  Future<DataState<UserEntity>> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? avatarUrl,
    String? preferredLanguage,
    String? timezone,
  }) async {
    try {
      // TODO: Implement profile update
      return const DataFailed(
        error: 'Profile update not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Profile update failed: ${e.toString()}',
        errorCode: 'UPDATE_PROFILE_FAILED',
      );
    }
  }

  @override
  Future<DataState<UserEntity>> switchBusiness({
    required String businessId,
  }) async {
    try {
      final UserEntity? userData = await _getUserData();
      if (userData == null) {
        return const DataFailed(
          error: 'No user data found',
          errorCode: 'NO_USER',
        );
      }

      final UserEntity updatedUser = userData.copyWith(
        currentBusinessId: businessId,
      );
      await _saveUserData(updatedUser);

      return DataSuccess(updatedUser);
    } catch (e) {
      return DataFailed(
        error: 'Business switch failed: ${e.toString()}',
        errorCode: 'SWITCH_BUSINESS_FAILED',
      );
    }
  }

  @override
  Future<DataState<UserEntity>> switchBranch({required String branchId}) async {
    try {
      final UserEntity? userData = await _getUserData();
      if (userData == null) {
        return const DataFailed(
          error: 'No user data found',
          errorCode: 'NO_USER',
        );
      }

      final UserEntity updatedUser = userData.copyWith(
        currentBranchId: branchId,
      );
      await _saveUserData(updatedUser);

      return DataSuccess(updatedUser);
    } catch (e) {
      return DataFailed(
        error: 'Branch switch failed: ${e.toString()}',
        errorCode: 'SWITCH_BRANCH_FAILED',
      );
    }
  }

  @override
  Future<DataState<Map<String, dynamic>>> enableTwoFactor({
    required String method,
  }) async {
    try {
      // TODO: Implement two-factor enable
      return const DataFailed(
        error: 'Two-factor enable not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Two-factor enable failed: ${e.toString()}',
        errorCode: 'ENABLE_2FA_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> disableTwoFactor({required String code}) async {
    try {
      // TODO: Implement two-factor disable
      return const DataFailed(
        error: 'Two-factor disable not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Two-factor disable failed: ${e.toString()}',
        errorCode: 'DISABLE_2FA_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> verifyEmail({required String token}) async {
    try {
      // TODO: Implement email verification
      return const DataFailed(
        error: 'Email verification not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Email verification failed: ${e.toString()}',
        errorCode: 'VERIFY_EMAIL_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> resendVerificationEmail() async {
    try {
      // TODO: Implement resend verification
      return const DataFailed(
        error: 'Resend verification not implemented',
        errorCode: 'NOT_IMPLEMENTED',
      );
    } catch (e) {
      return DataFailed(
        error: 'Resend verification failed: ${e.toString()}',
        errorCode: 'RESEND_VERIFICATION_FAILED',
      );
    }
  }

  @override
  Future<DataState<void>> updateFcmToken({required String fcmToken}) async {
    try {
      // TODO: Implement FCM token update
      await sharedPreferences.setString('fcm_token', fcmToken);
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(
        error: 'FCM token update failed: ${e.toString()}',
        errorCode: 'UPDATE_FCM_FAILED',
      );
    }
  }

  // Helper methods for local storage
  Future<void> _saveUserData(UserEntity user) async {
    final Map<String, dynamic> userJson = _userToJson(user);
    await sharedPreferences.setString(_keyCurrentUser, jsonEncode(userJson));
  }

  Future<UserEntity?> _getUserData() async {
    final String? userString = sharedPreferences.getString(_keyCurrentUser);
    if (userString == null) return null;

    try {
      final Map<String, dynamic> userJson =
          jsonDecode(userString) as Map<String, dynamic>;
      return _userFromJson(userJson);
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearUserData() async {
    await sharedPreferences.remove(_keyCurrentUser);
  }

  Future<void> _saveAuthToken(AuthTokenEntity token) async {
    final Map<String, Object> tokenJson = <String, Object>{
      'accessToken': token.accessToken,
      'refreshToken': token.refreshToken,
      'expiresIn': token.expiresIn,
      'tokenType': token.tokenType,
    };
    await secureStorage.write(key: _keyAuthToken, value: jsonEncode(tokenJson));
  }

  Future<AuthTokenEntity?> _getAuthToken() async {
    final String? tokenString = await secureStorage.read(key: _keyAuthToken);
    if (tokenString == null) return null;

    try {
      final Map<String, dynamic> tokenJson =
          jsonDecode(tokenString) as Map<String, dynamic>;
      return AuthTokenEntity(
        accessToken: tokenJson['accessToken'] as String,
        refreshToken: tokenJson['refreshToken'] as String,
        expiresIn: tokenJson['expiresIn'] as int,
        tokenType: tokenJson['tokenType'] as String? ?? 'Bearer',
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearAuthToken() async {
    await secureStorage.delete(key: _keyAuthToken);
  }

  Map<String, dynamic> _userToJson(UserEntity user) {
    return <String, dynamic>{
      'userId': user.userId,
      'email': user.email,
      'name': user.name,
      'phone': user.phone,
      'avatarUrl': user.avatarUrl,
      'isEmailVerified': user.isEmailVerified,
      'isPhoneVerified': user.isPhoneVerified,
      'lastLoginAt': user.lastLoginAt?.toIso8601String(),
      'twoFactorEnabled': user.twoFactorEnabled,
      'preferredLanguage': user.preferredLanguage,
      'timezone': user.timezone,
      'status': user.status.value,
      'businessUsers': user.businessUsers.map(_businessUserToJson).toList(),
      'currentBusinessId': user.currentBusinessId,
      'currentBranchId': user.currentBranchId,
      'permissions': user.permissions,
    };
  }

  UserEntity _userFromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['userId'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
      timezone: json['timezone'] as String? ?? 'UTC',
      status: StatusType.fromString(json['status'] as String? ?? 'active'),
      businessUsers:
          (json['businessUsers'] as List<dynamic>?)
              ?.map((e) => _businessUserFromJson(e as Map<String, dynamic>))
              .toList() ??
          <BusinessUserEntity>[],
      currentBusinessId: json['currentBusinessId'] as String?,
      currentBranchId: json['currentBranchId'] as String?,
      permissions: List<String>.from(json['permissions'] ?? <dynamic>[]),
    );
  }

  Map<String, dynamic> _businessUserToJson(BusinessUserEntity businessUser) {
    return <String, dynamic>{
      'businessUserId': businessUser.businessUserId,
      'businessId': businessUser.businessId,
      'userId': businessUser.userId,
      'roleId': businessUser.roleId,
      'roleName': businessUser.roleName,
      'businessName': businessUser.businessName,
      'assignedBranches': businessUser.assignedBranches,
      'customPermissions': businessUser.customPermissions,
      'employmentStartDate': businessUser.employmentStartDate
          ?.toIso8601String(),
      'employmentEndDate': businessUser.employmentEndDate?.toIso8601String(),
      'isPrimaryBusiness': businessUser.isPrimaryBusiness,
      'status': businessUser.status.value,
    };
  }

  BusinessUserEntity _businessUserFromJson(Map<String, dynamic> json) {
    return BusinessUserEntity(
      businessUserId: json['businessUserId'] as String,
      businessId: json['businessId'] as String,
      userId: json['userId'] as String,
      roleId: json['roleId'] as String,
      roleName: json['roleName'] as String,
      businessName: json['businessName'] as String?,
      assignedBranches: List<String>.from(
        json['assignedBranches'] ?? <dynamic>[],
      ),
      customPermissions: List<String>.from(
        json['customPermissions'] ?? <dynamic>[],
      ),
      employmentStartDate: json['employmentStartDate'] != null
          ? DateTime.parse(json['employmentStartDate'] as String)
          : null,
      employmentEndDate: json['employmentEndDate'] != null
          ? DateTime.parse(json['employmentEndDate'] as String)
          : null,
      isPrimaryBusiness: json['isPrimaryBusiness'] as bool? ?? false,
      status: StatusType.fromString(json['status'] as String? ?? 'active'),
    );
  }
}
