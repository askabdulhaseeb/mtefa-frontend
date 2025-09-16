import 'package:flutter/material.dart';

/// Provider for managing dashboard state and data
class DashboardProvider extends ChangeNotifier {
  DashboardProvider();

  // State variables
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();
  String _selectedPeriod = 'Today';
  
  // Dashboard statistics
  double _todaySales = 0.0;
  double _monthSales = 0.0;
  int _todayTransactions = 0;
  int _pendingOrders = 0;
  int _lowStockItems = 0;
  int _totalCustomers = 0;
  int _activeInventoryItems = 0;
  double _revenue = 0.0;

  // Quick action states
  bool _isProcessingSale = false;
  bool _isLoadingReports = false;

  // Getters
  bool get isLoading => _isLoading;
  DateTime get selectedDate => _selectedDate;
  String get selectedPeriod => _selectedPeriod;
  double get todaySales => _todaySales;
  double get monthSales => _monthSales;
  int get todayTransactions => _todayTransactions;
  int get pendingOrders => _pendingOrders;
  int get lowStockItems => _lowStockItems;
  int get totalCustomers => _totalCustomers;
  int get activeInventoryItems => _activeInventoryItems;
  double get revenue => _revenue;
  bool get isProcessingSale => _isProcessingSale;
  bool get isLoadingReports => _isLoadingReports;

  /// Initialize dashboard data
  Future<void> initializeDashboard() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate loading dashboard data
      // In production, this would fetch from API/Database
      await Future<void>.delayed(const Duration(seconds: 1));
      
      // Set mock data for demonstration
      _todaySales = 12543.50;
      _monthSales = 456789.25;
      _todayTransactions = 87;
      _pendingOrders = 12;
      _lowStockItems = 5;
      _totalCustomers = 1234;
      _activeInventoryItems = 567;
      _revenue = 98765.43;
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error initializing dashboard: $e');
    }
  }

  /// Refresh dashboard data
  Future<void> refreshDashboard() async {
    await initializeDashboard();
  }

  /// Update selected period
  void updateSelectedPeriod(String period) {
    _selectedPeriod = period;
    notifyListeners();
    // Trigger data refresh based on new period
    refreshDashboard();
  }

  /// Update selected date
  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
    // Trigger data refresh based on new date
    refreshDashboard();
  }

  /// Process quick sale
  Future<void> processQuickSale() async {
    _isProcessingSale = true;
    notifyListeners();

    try {
      // Simulate processing
      await Future<void>.delayed(const Duration(seconds: 2));
      
      _isProcessingSale = false;
      notifyListeners();
      
      // Refresh data after sale
      await refreshDashboard();
    } catch (e) {
      _isProcessingSale = false;
      notifyListeners();
      debugPrint('Error processing sale: $e');
    }
  }

  /// Load reports
  Future<void> loadReports() async {
    _isLoadingReports = true;
    notifyListeners();

    try {
      // Simulate loading reports
      await Future<void>.delayed(const Duration(seconds: 1));
      
      _isLoadingReports = false;
      notifyListeners();
    } catch (e) {
      _isLoadingReports = false;
      notifyListeners();
      debugPrint('Error loading reports: $e');
    }
  }

}