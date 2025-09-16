/// PlacementType enum representing code placement position
enum PlacementType {
  pre('pre'),
  post('post');

  const PlacementType(this.value);
  final String value;

  /// Convert from string value to enum
  static PlacementType fromValue(String value) {
    return PlacementType.values.firstWhere(
      (PlacementType type) => type.value == value,
      orElse: () => PlacementType.pre,
    );
  }

  /// Convert from string (alias for fromValue)
  static PlacementType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Check if placement is pre
  bool get isPre => this == PlacementType.pre;

  /// Check if placement is post
  bool get isPost => this == PlacementType.post;
}

/// Extension methods for PlacementType
extension PlacementTypeExtension on String {
  PlacementType toPlacementType() => PlacementType.fromValue(this);
}