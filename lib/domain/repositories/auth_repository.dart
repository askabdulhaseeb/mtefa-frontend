import '../../core/resources/data_state.dart';
import '../entities/auth/user_entity.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  Future<DataState<LoginResponseEntity>> login({
    required String email,
    required String password,
  });

  /// Verify two-factor authentication code
  Future<DataState<LoginResponseEntity>> verifyTwoFactor({
    required String code,
    required String method,
  });

  /// Logout the current user
  Future<DataState<void>> logout();

  /// Get the current authenticated user
  Future<DataState<UserEntity>> getCurrentUser();

  /// Refresh the authentication token
  Future<DataState<AuthTokenEntity>> refreshToken({
    required String refreshToken,
  });

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Get saved credentials (for auto-login)
  Future<Map<String, String>?> getSavedCredentials();

  /// Save credentials (for remember me)
  Future<void> saveCredentials({
    required String email,
    required String password,
  });

  /// Clear saved credentials
  Future<void> clearSavedCredentials();

  /// Change password
  Future<DataState<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Request password reset
  Future<DataState<void>> requestPasswordReset({
    required String email,
  });

  /// Reset password with token
  Future<DataState<void>> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Update user profile
  Future<DataState<UserEntity>> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? avatarUrl,
    String? preferredLanguage,
    String? timezone,
  });

  /// Switch business context
  Future<DataState<UserEntity>> switchBusiness({
    required String businessId,
  });

  /// Switch branch context
  Future<DataState<UserEntity>> switchBranch({
    required String branchId,
  });

  /// Enable two-factor authentication
  Future<DataState<Map<String, dynamic>>> enableTwoFactor({
    required String method,
  });

  /// Disable two-factor authentication
  Future<DataState<void>> disableTwoFactor({
    required String code,
  });

  /// Verify email
  Future<DataState<void>> verifyEmail({
    required String token,
  });

  /// Resend verification email
  Future<DataState<void>> resendVerificationEmail();

  /// Update FCM token for push notifications
  Future<DataState<void>> updateFcmToken({
    required String fcmToken,
  });
}