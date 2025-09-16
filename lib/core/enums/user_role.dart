/// UserRole enum representing system user roles with hierarchical permissions
enum UserRole {
  superAdmin('super_admin', 1),
  businessOwner('business_owner', 2),
  businessAdmin('business_admin', 3),
  branchManager('branch_manager', 4),
  cashier('cashier', 5),
  inventoryManager('inventory_manager', 5),
  salesAssociate('sales_associate', 6),
  accountant('accountant', 5),
  viewer('viewer', 10);

  const UserRole(this.value, this.hierarchyLevel);
  final String value;
  final int hierarchyLevel; // 1 = highest, 10 = lowest

  /// Convert from string value to enum
  static UserRole fromValue(String value) {
    return UserRole.values.firstWhere(
      (UserRole role) => role.value == value,
      orElse: () => UserRole.viewer,
    );
  }

  /// Convert from string (alias for fromValue)
  static UserRole fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Get display name for the role
  String get displayName {
    switch (this) {
      case UserRole.superAdmin:
        return 'Super Admin';
      case UserRole.businessOwner:
        return 'Business Owner';
      case UserRole.businessAdmin:
        return 'Business Admin';
      case UserRole.branchManager:
        return 'Branch Manager';
      case UserRole.cashier:
        return 'Cashier';
      case UserRole.inventoryManager:
        return 'Inventory Manager';
      case UserRole.salesAssociate:
        return 'Sales Associate';
      case UserRole.accountant:
        return 'Accountant';
      case UserRole.viewer:
        return 'Viewer';
    }
  }

  /// Check if this role is higher than another role
  bool isHigherThan(UserRole other) => hierarchyLevel < other.hierarchyLevel;

  /// Check if this role is lower than another role
  bool isLowerThan(UserRole other) => hierarchyLevel > other.hierarchyLevel;

  /// Check if this role is equal to another role
  bool isEqualTo(UserRole other) => hierarchyLevel == other.hierarchyLevel;

  /// Check if this role is higher or equal to another role
  bool isHigherOrEqualTo(UserRole other) => hierarchyLevel <= other.hierarchyLevel;

  /// Check if role is super admin
  bool get isSuperAdmin => this == UserRole.superAdmin;

  /// Check if role is business owner
  bool get isBusinessOwner => this == UserRole.businessOwner;

  /// Check if role is business admin
  bool get isBusinessAdmin => this == UserRole.businessAdmin;

  /// Check if role is branch manager
  bool get isBranchManager => this == UserRole.branchManager;

  /// Check if role is cashier
  bool get isCashier => this == UserRole.cashier;

  /// Check if role is inventory manager
  bool get isInventoryManager => this == UserRole.inventoryManager;

  /// Check if role is sales associate
  bool get isSalesAssociate => this == UserRole.salesAssociate;

  /// Check if role is accountant
  bool get isAccountant => this == UserRole.accountant;

  /// Check if role is viewer
  bool get isViewer => this == UserRole.viewer;

  /// Check if role has admin privileges (super admin, business owner, or business admin)
  bool get hasAdminPrivileges => 
      this == UserRole.superAdmin || 
      this == UserRole.businessOwner || 
      this == UserRole.businessAdmin;

  /// Check if role has management privileges
  bool get hasManagementPrivileges => 
      hasAdminPrivileges || 
      this == UserRole.branchManager;

  /// Check if role can process sales
  bool get canProcessSales => 
      this != UserRole.viewer;

  /// Check if role can manage inventory
  bool get canManageInventory => 
      hasManagementPrivileges || 
      this == UserRole.inventoryManager;

  /// Check if role can view reports
  bool get canViewReports => 
      hasManagementPrivileges || 
      this == UserRole.accountant;

  /// Check if role can manage cash
  bool get canManageCash => 
      hasManagementPrivileges || 
      this == UserRole.cashier || 
      this == UserRole.accountant;
}

/// Extension methods for UserRole
extension UserRoleExtension on String {
  UserRole toUserRole() => UserRole.fromValue(this);
}