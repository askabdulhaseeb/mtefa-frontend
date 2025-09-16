/// LocationType enum representing inventory storage location types
enum LocationType {
  storage('storage'),
  display('display'),
  transit('transit'),
  damaged('damaged'),
  reserved('reserved');

  const LocationType(this.value);
  final String value;

  /// Convert from string value to enum
  static LocationType fromValue(String value) {
    return LocationType.values.firstWhere(
      (LocationType type) => type.value == value,
      orElse: () => LocationType.storage,
    );
  }

  /// Convert from string (alias for fromValue)
  static LocationType fromString(String value) => fromValue(value);

  /// Convert to string value
  String toValue() => value;

  /// Override toString to return the value
  @override
  String toString() => value;

  /// Get display name for the location type
  String get displayName {
    switch (this) {
      case LocationType.storage:
        return 'Storage';
      case LocationType.display:
        return 'Display';
      case LocationType.transit:
        return 'In Transit';
      case LocationType.damaged:
        return 'Damaged';
      case LocationType.reserved:
        return 'Reserved';
    }
  }

  /// Get icon name for the location type
  String get iconName {
    switch (this) {
      case LocationType.storage:
        return 'inventory_2';
      case LocationType.display:
        return 'storefront';
      case LocationType.transit:
        return 'local_shipping';
      case LocationType.damaged:
        return 'broken_image';
      case LocationType.reserved:
        return 'lock';
    }
  }

  /// Get color for the location type (as hex string)
  String get colorHex {
    switch (this) {
      case LocationType.storage:
        return '#2196F3'; // Blue
      case LocationType.display:
        return '#4CAF50'; // Green
      case LocationType.transit:
        return '#FF9800'; // Orange
      case LocationType.damaged:
        return '#F44336'; // Red
      case LocationType.reserved:
        return '#9C27B0'; // Purple
    }
  }

  /// Check if location is storage
  bool get isStorage => this == LocationType.storage;

  /// Check if location is display
  bool get isDisplay => this == LocationType.display;

  /// Check if location is transit
  bool get isTransit => this == LocationType.transit;

  /// Check if location is damaged
  bool get isDamaged => this == LocationType.damaged;

  /// Check if location is reserved
  bool get isReserved => this == LocationType.reserved;

  /// Check if location is sellable (storage or display)
  bool get isSellable => 
      this == LocationType.storage || 
      this == LocationType.display;

  /// Check if location is available for sale
  bool get isAvailableForSale => 
      isSellable && !isReserved;

  /// Check if location requires special handling (damaged or transit)
  bool get requiresSpecialHandling => 
      this == LocationType.damaged || 
      this == LocationType.transit;

  /// Check if location counts towards available inventory
  bool get countsAsAvailable => 
      this == LocationType.storage || 
      this == LocationType.display ||
      this == LocationType.reserved;
}

/// Extension methods for LocationType
extension LocationTypeExtension on String {
  LocationType toLocationType() => LocationType.fromValue(this);
}