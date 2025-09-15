import 'package:equatable/equatable.dart';

/// User entity representing the authenticated user
class UserEntity extends Equatable {
  const UserEntity({
    required this.userId,
    required this.email,
    required this.name,
    this.phone,
    this.avatarUrl,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.lastLoginAt,
    this.twoFactorEnabled = false,
    this.preferredLanguage = 'en',
    this.timezone = 'UTC',
    this.status = 'active',
    this.businessUsers = const [],
    this.currentBusinessId,
    this.currentBranchId,
    this.permissions = const [],
  });

  final String userId;
  final String email;
  final String name;
  final String? phone;
  final String? avatarUrl;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime? lastLoginAt;
  final bool twoFactorEnabled;
  final String preferredLanguage;
  final String timezone;
  final String status;
  
  // Business-related fields
  final List<BusinessUserEntity> businessUsers;
  final String? currentBusinessId;
  final String? currentBranchId;
  final List<String> permissions;

  bool get isActive => status == 'active';
  bool get hasBusinessAccess => businessUsers.isNotEmpty;
  
  BusinessUserEntity? get currentBusinessUser {
    if (currentBusinessId == null) return null;
    try {
      return businessUsers.firstWhere(
        (businessUser) => businessUser.businessId == currentBusinessId,
      );
    } catch (_) {
      return null;
    }
  }

  UserEntity copyWith({
    String? userId,
    String? email,
    String? name,
    String? phone,
    String? avatarUrl,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? lastLoginAt,
    bool? twoFactorEnabled,
    String? preferredLanguage,
    String? timezone,
    String? status,
    List<BusinessUserEntity>? businessUsers,
    String? currentBusinessId,
    String? currentBranchId,
    List<String>? permissions,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      timezone: timezone ?? this.timezone,
      status: status ?? this.status,
      businessUsers: businessUsers ?? this.businessUsers,
      currentBusinessId: currentBusinessId ?? this.currentBusinessId,
      currentBranchId: currentBranchId ?? this.currentBranchId,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        name,
        phone,
        avatarUrl,
        isEmailVerified,
        isPhoneVerified,
        lastLoginAt,
        twoFactorEnabled,
        preferredLanguage,
        timezone,
        status,
        businessUsers,
        currentBusinessId,
        currentBranchId,
        permissions,
      ];
}

/// BusinessUser entity representing user's relationship with a business
class BusinessUserEntity extends Equatable {
  const BusinessUserEntity({
    required this.businessUserId,
    required this.businessId,
    required this.userId,
    required this.roleId,
    required this.roleName,
    this.businessName,
    this.assignedBranches = const [],
    this.customPermissions = const [],
    this.employmentStartDate,
    this.employmentEndDate,
    this.isPrimaryBusiness = false,
    this.status = 'active',
  });

  final String businessUserId;
  final String businessId;
  final String userId;
  final String roleId;
  final String roleName;
  final String? businessName;
  final List<String> assignedBranches;
  final List<String> customPermissions;
  final DateTime? employmentStartDate;
  final DateTime? employmentEndDate;
  final bool isPrimaryBusiness;
  final String status;

  bool get isActive => status == 'active';
  bool get hasFullAccess => assignedBranches.isEmpty;

  @override
  List<Object?> get props => [
        businessUserId,
        businessId,
        userId,
        roleId,
        roleName,
        businessName,
        assignedBranches,
        customPermissions,
        employmentStartDate,
        employmentEndDate,
        isPrimaryBusiness,
        status,
      ];
}

/// Auth token entity
class AuthTokenEntity extends Equatable {
  const AuthTokenEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    this.tokenType = 'Bearer',
  });

  final String accessToken;
  final String refreshToken;
  final int expiresIn; // in seconds
  final String tokenType;

  DateTime get expiresAt => DateTime.now().add(Duration(seconds: expiresIn));
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresIn, tokenType];
}

/// Login response entity
class LoginResponseEntity extends Equatable {
  const LoginResponseEntity({
    required this.user,
    required this.token,
    this.requiresTwoFactor = false,
    this.twoFactorMethod,
  });

  final UserEntity user;
  final AuthTokenEntity token;
  final bool requiresTwoFactor;
  final String? twoFactorMethod; // 'sms', 'email', 'authenticator'

  @override
  List<Object?> get props => [user, token, requiresTwoFactor, twoFactorMethod];
}