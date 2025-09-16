import 'package:equatable/equatable.dart';
import '../../../core/enums/status_type.dart';
import '../../../core/enums/user_role.dart';

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
    this.status = StatusType.active,
    this.businessUsers = const <BusinessUserEntity>[],
    this.currentBusinessId,
    this.currentBranchId,
    this.permissions = const <String>[],
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
  final StatusType status;
  
  // Business-related fields
  final List<BusinessUserEntity> businessUsers;
  final String? currentBusinessId;
  final String? currentBranchId;
  final List<String> permissions;

  bool get isActive => status.isActive;
  bool get hasBusinessAccess => businessUsers.isNotEmpty;
  
  BusinessUserEntity? get currentBusinessUser {
    if (currentBusinessId == null) return null;
    try {
      return businessUsers.firstWhere(
        (BusinessUserEntity businessUser) => businessUser.businessId == currentBusinessId,
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
    StatusType? status,
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
  List<Object?> get props => <Object?>[
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
    this.assignedBranches = const <String>[],
    this.customPermissions = const <String>[],
    this.employmentStartDate,
    this.employmentEndDate,
    this.isPrimaryBusiness = false,
    this.status = StatusType.active,
    this.userRole,
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
  final StatusType status;
  final UserRole? userRole;

  bool get isActive => status.isActive;
  bool get hasFullAccess => assignedBranches.isEmpty;

  @override
  List<Object?> get props => <Object?>[
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
        userRole,
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
  List<Object?> get props => <Object?>[accessToken, refreshToken, expiresIn, tokenType];
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
  List<Object?> get props => <Object?>[user, token, requiresTwoFactor, twoFactorMethod];
}