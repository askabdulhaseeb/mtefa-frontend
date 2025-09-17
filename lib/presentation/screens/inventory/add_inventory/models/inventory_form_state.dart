import 'package:flutter/material.dart';

import '../../../../../domain/entities/inventory/category_entity.dart';
import '../../../../../domain/entities/inventory/inventory_line_entity.dart';
import '../../../../../domain/entities/inventory/sub_category_entity.dart';
import '../../../../../domain/entities/inventory/supplier_entity.dart';

/// Inventory form state model
class InventoryFormState {
  InventoryFormState();

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // REQUIRED FIELDS CONTROLLERS
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController averageCostController = TextEditingController();

  // BASIC DETAILS CONTROLLERS
  final TextEditingController shopQualityController = TextEditingController();
  final TextEditingController storeQualityController = TextEditingController();

  // PRICING & SALES CONTROLLERS
  final TextEditingController priceController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final TextEditingController userPriceController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();

  // INVENTORY MANAGEMENT CONTROLLERS
  final TextEditingController minimumLevelController = TextEditingController();
  final TextEditingController optimalLevelController = TextEditingController();
  final TextEditingController maximumLevelController = TextEditingController();

  // PURCHASE CONFIGURATION CONTROLLERS
  final TextEditingController purchaseConvFactorController = TextEditingController();

  // ADDITIONAL CONTROLLERS
  final TextEditingController commentsController = TextEditingController();

  // ENTITY SELECTIONS
  InventoryLineEntity? selectedLineItem;
  SupplierEntity? selectedSupplier;
  CategoryEntity? selectedCategory;
  SubCategoryEntity? selectedSubCategory;

  // SIZE & COLOR SELECTIONS
  List<String> selectedSizes = <String>[];
  List<String> selectedColors = <String>[];
  String? selectedDefaultSize;
  String? selectedDefaultColor;

  // PLACEHOLDER SELECTIONS
  String? selectedProductGroup;
  String? selectedAgeGroup;
  String? selectedPackagingType;
  String? selectedProductGender;
  String? selectedLifeType;

  // CONFIGURATION
  DateTime? selectedDate;
  String selectedCurrency = 'PKR';

  // STATE FLAGS
  bool isLoading = false;
  bool isSaving = false;
  bool isLoadingSubCategories = false;
  bool autoGenerateCode = true;

  /// Clear all form data
  void clearForm() {
    // Clear all controllers
    productCodeController.clear();
    productNameController.clear();
    averageCostController.clear();
    shopQualityController.clear();
    storeQualityController.clear();
    priceController.clear();
    vatController.clear();
    userPriceController.clear();
    productIdController.clear();
    minimumLevelController.clear();
    optimalLevelController.clear();
    maximumLevelController.clear();
    purchaseConvFactorController.clear();
    commentsController.clear();

    // Clear selections
    selectedLineItem = null;
    selectedSupplier = null;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedSizes.clear();
    selectedColors.clear();
    selectedDefaultSize = null;
    selectedDefaultColor = null;
    selectedProductGroup = null;
    selectedAgeGroup = null;
    selectedPackagingType = null;
    selectedProductGender = null;
    selectedLifeType = null;
    selectedDate = null;
    selectedCurrency = 'PKR';

    // Reset flags
    autoGenerateCode = true;
  }

  /// Dispose all controllers
  void dispose() {
    productCodeController.dispose();
    productNameController.dispose();
    averageCostController.dispose();
    shopQualityController.dispose();
    storeQualityController.dispose();
    priceController.dispose();
    vatController.dispose();
    userPriceController.dispose();
    productIdController.dispose();
    minimumLevelController.dispose();
    optimalLevelController.dispose();
    maximumLevelController.dispose();
    purchaseConvFactorController.dispose();
    commentsController.dispose();
  }
}