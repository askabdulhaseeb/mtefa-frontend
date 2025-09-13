import 'package:equatable/equatable.dart';

/// Pagination information for API responses and database queries
class PaginationInfo extends Equatable {

  /// Create from JSON
  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      currentPage: json['currentPage'] ?? json['page'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalItems: json['totalItems'] ?? json['total'] ?? 0,
      hasNext: json['hasNext'] ?? json['hasMore'] ?? false,
      hasPrev: json['hasPrev'] ?? false,
      limit: json['limit'] ?? 10,
    );
  }
  const PaginationInfo({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNext,
    required this.hasPrev,
    required this.limit,
  });

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNext;
  final bool hasPrev;
  final int limit;

  /// Check if there are more pages available
  bool get hasMorePages => hasNext;

  /// Calculate offset for database queries
  int get offset => (currentPage - 1) * limit;

  /// Create a copy with updated values
  PaginationInfo copyWith({
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? hasNext,
    bool? hasPrev,
    int? limit,
  }) {
    return PaginationInfo(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
      limit: limit ?? this.limit,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'hasNext': hasNext,
      'hasPrev': hasPrev,
      'limit': limit,
    };
  }

  @override
  List<Object?> get props => <Object?>[
        currentPage,
        totalPages,
        totalItems,
        hasNext,
        hasPrev,
        limit,
      ];

  @override
  String toString() {
    return 'PaginationInfo(currentPage: $currentPage, totalPages: $totalPages, totalItems: $totalItems, hasNext: $hasNext, hasPrev: $hasPrev, limit: $limit)';
  }
}
