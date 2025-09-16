/// BranchType enum representing branch location types
enum BranchType {
  shop('shop'),
  online('online'),
  store('store');

  const BranchType(this.value);
  final String value;

  /// Convert from string value to enum
  static BranchType fromValue(String value) {
    return BranchType.values.firstWhere(
      (BranchType type) => type.value == value,
      orElse: () => BranchType.shop,
    );
  }

  /// Convert from string (alias for fromValue)
  static BranchType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Check if branch is shop
  bool get isShop => this == BranchType.shop;

  /// Check if branch is online
  bool get isOnline => this == BranchType.online;

  /// Check if branch is store
  bool get isStore => this == BranchType.store;

  /// Check if branch is physical (shop or store)
  bool get isPhysical => this == BranchType.shop || this == BranchType.store;
}

/// Extension methods for BranchType
extension BranchTypeExtension on String {
  BranchType toBranchType() => BranchType.fromValue(this);
}