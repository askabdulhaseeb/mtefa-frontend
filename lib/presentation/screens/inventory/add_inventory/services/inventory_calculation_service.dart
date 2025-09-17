import 'package:flutter/material.dart';

/// Inventory calculation service for profit and pricing calculations
class InventoryCalculationService {
  /// Calculate profit margin percentage
  static double calculateProfitMargin({
    required double cost,
    required double price,
  }) {
    if (cost == 0 || price == 0) return 0;
    return ((price - cost) / price) * 100;
  }

  /// Calculate markup percentage
  static double calculateMarkupPercentage({
    required double cost,
    required double price,
  }) {
    if (cost == 0) return 0;
    return ((price - cost) / cost) * 100;
  }

  /// Calculate total cost with conversion factor
  static double calculateTotalCost({
    required double unitCost,
    required double conversionFactor,
  }) {
    return unitCost * conversionFactor;
  }

  /// Get profit health color based on margin
  static Color getProfitHealthColor(double margin) {
    if (margin >= 30) return Colors.green;
    if (margin >= 20) return Colors.blue;
    if (margin >= 10) return Colors.orange;
    return Colors.red;
  }

  /// Get profit health icon based on margin
  static IconData getProfitHealthIcon(double margin) {
    if (margin >= 30) return Icons.sentiment_very_satisfied;
    if (margin >= 20) return Icons.sentiment_satisfied;
    if (margin >= 10) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }

  /// Get profit health text based on margin
  static String getProfitHealthText(double margin) {
    if (margin >= 30) return 'Excellent profit margin';
    if (margin >= 20) return 'Good profit margin';
    if (margin >= 10) return 'Fair profit margin';
    return 'Low profit margin - consider adjusting price';
  }

  /// Parse double safely from text controller
  static double parseDouble(String value) {
    return double.tryParse(value) ?? 0;
  }

  /// Check if profit calculations should be shown
  static bool shouldShowProfitCalculations({
    required String costText,
    required String priceText,
  }) {
    return costText.isNotEmpty && priceText.isNotEmpty;
  }

  /// Check if purchase calculations should be shown
  static bool shouldShowPurchaseCalculations({
    required String factorText,
    required String costText,
  }) {
    return factorText.isNotEmpty && costText.isNotEmpty;
  }
}