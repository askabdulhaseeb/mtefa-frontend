/// AuditAction enum representing audit log action types
enum AuditAction {
  create('create'),
  update('update'),
  delete('delete'),
  login('login'),
  logout('logout'),
  view('view'),
  export('export'),
  import('import');

  const AuditAction(this.value);
  final String value;

  /// Convert from string value to enum
  static AuditAction fromValue(String value) {
    return AuditAction.values.firstWhere(
      (AuditAction action) => action.value == value,
      orElse: () => AuditAction.view,
    );
  }

  /// Convert from string (alias for fromValue)
  static AuditAction fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Get display name for the audit action
  String get displayName {
    switch (this) {
      case AuditAction.create:
        return 'Create';
      case AuditAction.update:
        return 'Update';
      case AuditAction.delete:
        return 'Delete';
      case AuditAction.login:
        return 'Login';
      case AuditAction.logout:
        return 'Logout';
      case AuditAction.view:
        return 'View';
      case AuditAction.export:
        return 'Export';
      case AuditAction.import:
        return 'Import';
    }
  }

  /// Get icon name for the audit action
  String get iconName {
    switch (this) {
      case AuditAction.create:
        return 'add_circle';
      case AuditAction.update:
        return 'edit';
      case AuditAction.delete:
        return 'delete';
      case AuditAction.login:
        return 'login';
      case AuditAction.logout:
        return 'logout';
      case AuditAction.view:
        return 'visibility';
      case AuditAction.export:
        return 'file_download';
      case AuditAction.import:
        return 'file_upload';
    }
  }

  /// Get severity level for the audit action (1 = low, 5 = high)
  int get severityLevel {
    switch (this) {
      case AuditAction.view:
        return 1;
      case AuditAction.export:
        return 2;
      case AuditAction.create:
      case AuditAction.import:
        return 3;
      case AuditAction.update:
      case AuditAction.login:
      case AuditAction.logout:
        return 3;
      case AuditAction.delete:
        return 5;
    }
  }

  /// Get color for the audit action (as hex string)
  String get colorHex {
    switch (this) {
      case AuditAction.create:
        return '#4CAF50'; // Green
      case AuditAction.update:
        return '#2196F3'; // Blue
      case AuditAction.delete:
        return '#F44336'; // Red
      case AuditAction.login:
        return '#00BCD4'; // Cyan
      case AuditAction.logout:
        return '#FF9800'; // Orange
      case AuditAction.view:
        return '#9E9E9E'; // Grey
      case AuditAction.export:
        return '#673AB7'; // Deep Purple
      case AuditAction.import:
        return '#3F51B5'; // Indigo
    }
  }

  /// Check if action is create
  bool get isCreate => this == AuditAction.create;

  /// Check if action is update
  bool get isUpdate => this == AuditAction.update;

  /// Check if action is delete
  bool get isDelete => this == AuditAction.delete;

  /// Check if action is login
  bool get isLogin => this == AuditAction.login;

  /// Check if action is logout
  bool get isLogout => this == AuditAction.logout;

  /// Check if action is view
  bool get isView => this == AuditAction.view;

  /// Check if action is export
  bool get isExport => this == AuditAction.export;

  /// Check if action is import
  bool get isImport => this == AuditAction.import;

  /// Check if action is a data modification (create, update, delete, import)
  bool get isDataModification => 
      this == AuditAction.create || 
      this == AuditAction.update || 
      this == AuditAction.delete ||
      this == AuditAction.import;

  /// Check if action is authentication related (login, logout)
  bool get isAuthentication => 
      this == AuditAction.login || 
      this == AuditAction.logout;

  /// Check if action is data access (view, export)
  bool get isDataAccess => 
      this == AuditAction.view || 
      this == AuditAction.export;

  /// Check if action is high risk (delete, export, import)
  bool get isHighRisk => 
      this == AuditAction.delete || 
      this == AuditAction.export || 
      this == AuditAction.import;
}

/// Extension methods for AuditAction
extension AuditActionExtension on String {
  AuditAction toAuditAction() => AuditAction.fromValue(this);
}