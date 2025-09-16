/// SystemType enum representing POS terminal types
enum SystemType {
  mobile('mobile'),
  computer('computer'),
  tablet('tablet');

  const SystemType(this.value);
  final String value;

  /// Convert from string value to enum
  static SystemType fromValue(String value) {
    return SystemType.values.firstWhere(
      (SystemType type) => type.value == value,
      orElse: () => SystemType.computer,
    );
  }

  /// Convert from string (alias for fromValue)
  static SystemType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Check if system is mobile
  bool get isMobile => this == SystemType.mobile;

  /// Check if system is computer
  bool get isComputer => this == SystemType.computer;

  /// Check if system is tablet
  bool get isTablet => this == SystemType.tablet;

  /// Check if system is portable (mobile or tablet)
  bool get isPortable => this == SystemType.mobile || this == SystemType.tablet;
}

/// Extension methods for SystemType
extension SystemTypeExtension on String {
  SystemType toSystemType() => SystemType.fromValue(this);
}