import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/database/database.dart';
import 'core/utils/token_manager.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/category_repository_impl.dart';
import 'data/repositories/inventory_colors_repository_impl.dart';
import 'data/repositories/inventory_line_repository_impl.dart';
import 'data/repositories/inventory_locations_repository_impl.dart';
import 'data/repositories/inventory_sizes_repository_impl.dart';
import 'data/repositories/season_repository_impl.dart';
import 'data/repositories/sub_category_repository_impl.dart';
import 'data/repositories/supplier_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/inventory_colors_repository.dart';
import 'domain/repositories/inventory_line_repository.dart';
import 'domain/repositories/inventory_locations_repository.dart';
import 'domain/repositories/inventory_sizes_repository.dart';
import 'domain/repositories/season_repository.dart';
import 'domain/repositories/sub_category_repository.dart';
import 'domain/repositories/supplier_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/inventory/get_categories_usecase.dart';
import 'domain/usecases/inventory/get_colors_usecase.dart';
import 'domain/usecases/inventory/get_inventory_lines_usecase.dart';
import 'domain/usecases/inventory/get_sizes_usecase.dart';
import 'domain/usecases/inventory/get_sub_categories_usecase.dart';
import 'domain/usecases/inventory/get_suppliers_usecase.dart';
import 'presentation/screens/auth/providers/login_provider.dart';
import 'presentation/screens/dashboard/providers/dashboard_provider.dart';
import 'presentation/screens/inventory/add_inventory/providers/comprehensive_inventory_provider.dart';
import 'presentation/screens/inventory/add_inventory/providers/comprehensive_inventory_provider_refactored.dart';
import 'presentation/screens/inventory/add_inventory/providers/database_inventory_provider.dart';
import 'presentation/screens/inventory/add_inventory/providers/inventory_coordinator_provider.dart';
import 'presentation/screens/inventory/add_inventory/providers/inventory_form_provider.dart';
import 'presentation/screens/inventory/add_inventory/providers/inventory_data_provider.dart';
import 'presentation/screens/inventory/add_inventory/providers/inventory_validation_provider.dart';
import 'presentation/screens/inventory/add_inventory/providers/inventory_crud_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  
  // Initialize all dependencies
  _core();
  _auth();
  _inventory();
  _dashboard();
}

void _core() {
  // Core utilities
  sl.registerLazySingleton<TokenManager>(() => TokenManager(
    storage: sl<FlutterSecureStorage>(),
  ));
}

void _auth() {
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      tokenManager: sl<TokenManager>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );
  
  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  
  // Providers
  sl.registerFactory<LoginProvider>(
    () => LoginProvider(
      loginUseCase: sl<LoginUseCase>(),
    ),
  );
}

void _inventory() {
  // Repositories
  sl.registerLazySingleton<InventoryLineRepository>(
    () => InventoryLineRepositoryImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<SubCategoryRepository>(
    () => SubCategoryRepositoryImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<SupplierRepository>(
    () => SupplierRepositoryImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<InventoryColorsRepository>(
    () => InventoryColorsRepositoryImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<InventorySizesRepository>(
    () => InventorySizesRepositoryImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<SeasonRepository>(
    () => SeasonRepositoryImpl(database: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<InventoryLocationsRepository>(
    () => InventoryLocationsRepositoryImpl(database: sl<AppDatabase>()),
  );
  
  // Use cases
  sl.registerLazySingleton<GetInventoryLinesUseCase>(
    () => GetInventoryLinesUseCase(sl<InventoryLineRepository>()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl<CategoryRepository>()),
  );
  sl.registerLazySingleton<GetCategoriesByParentUseCase>(
    () => GetCategoriesByParentUseCase(sl<CategoryRepository>()),
  );
  sl.registerLazySingleton<GetSubCategoriesUseCase>(
    () => GetSubCategoriesUseCase(sl<SubCategoryRepository>()),
  );
  sl.registerLazySingleton<GetSuppliersUseCase>(
    () => GetSuppliersUseCase(sl<SupplierRepository>()),
  );
  sl.registerLazySingleton<GetColorsUseCase>(
    () => GetColorsUseCase(sl<InventoryColorsRepository>()),
  );
  sl.registerLazySingleton<GetSizesUseCase>(
    () => GetSizesUseCase(sl<InventorySizesRepository>()),
  );
  
  // Providers - Both old and new for transition
  sl.registerFactory<ComprehensiveInventoryProvider>(
    () => ComprehensiveInventoryProvider(
      getInventoryLinesUseCase: sl<GetInventoryLinesUseCase>(),
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getCategoriesByParentUseCase: sl<GetCategoriesByParentUseCase>(),
      getSubCategoriesUseCase: sl<GetSubCategoriesUseCase>(),
      getSuppliersUseCase: sl<GetSuppliersUseCase>(),
      getColorsUseCase: sl<GetColorsUseCase>(),
      getSizesUseCase: sl<GetSizesUseCase>(),
    ),
  );
  
  // Refactored provider with full CRUD support
  sl.registerFactory<ComprehensiveInventoryProviderRefactored>(
    () => ComprehensiveInventoryProviderRefactored(
      database: sl<AppDatabase>(),
      getInventoryLinesUseCase: sl<GetInventoryLinesUseCase>(),
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getSubCategoriesUseCase: sl<GetSubCategoriesUseCase>(),
      getSuppliersUseCase: sl<GetSuppliersUseCase>(),
      inventoryLineRepository: sl<InventoryLineRepository>(),
      categoryRepository: sl<CategoryRepository>(),
      subCategoryRepository: sl<SubCategoryRepository>(),
      supplierRepository: sl<SupplierRepository>(),
      colorsRepository: sl<InventoryColorsRepository>(),
      sizesRepository: sl<InventorySizesRepository>(),
      seasonRepository: sl<SeasonRepository>(),
      locationsRepository: sl<InventoryLocationsRepository>(),
    ),
  );

  // New database-driven provider with NO hardcoded data
  sl.registerFactory<DatabaseInventoryProvider>(
    () => DatabaseInventoryProvider(
      database: sl<AppDatabase>(),
      getInventoryLinesUseCase: sl<GetInventoryLinesUseCase>(),
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getSubCategoriesUseCase: sl<GetSubCategoriesUseCase>(),
      getSuppliersUseCase: sl<GetSuppliersUseCase>(),
      inventoryLineRepository: sl<InventoryLineRepository>(),
      categoryRepository: sl<CategoryRepository>(),
      subCategoryRepository: sl<SubCategoryRepository>(),
      supplierRepository: sl<SupplierRepository>(),
      colorsRepository: sl<InventoryColorsRepository>(),
      sizesRepository: sl<InventorySizesRepository>(),
      seasonRepository: sl<SeasonRepository>(),
      locationsRepository: sl<InventoryLocationsRepository>(),
    ),
  );
  
  // New modular providers following clean architecture
  sl.registerFactory<InventoryFormProvider>(
    () => InventoryFormProvider(),
  );
  
  sl.registerFactory<InventoryDataProvider>(
    () => InventoryDataProvider(
      database: sl<AppDatabase>(),
      getInventoryLinesUseCase: sl<GetInventoryLinesUseCase>(),
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getSubCategoriesUseCase: sl<GetSubCategoriesUseCase>(),
      getSuppliersUseCase: sl<GetSuppliersUseCase>(),
      colorsRepository: sl<InventoryColorsRepository>(),
      sizesRepository: sl<InventorySizesRepository>(),
      seasonRepository: sl<SeasonRepository>(),
      locationsRepository: sl<InventoryLocationsRepository>(),
    ),
  );
  
  sl.registerFactory<InventoryValidationProvider>(
    () => InventoryValidationProvider(),
  );
  
  sl.registerFactory<InventoryCrudProvider>(
    () => InventoryCrudProvider(
      inventoryLineRepository: sl<InventoryLineRepository>(),
      categoryRepository: sl<CategoryRepository>(),
      subCategoryRepository: sl<SubCategoryRepository>(),
      supplierRepository: sl<SupplierRepository>(),
      colorsRepository: sl<InventoryColorsRepository>(),
      sizesRepository: sl<InventorySizesRepository>(),
    ),
  );
  
  sl.registerFactory<InventoryCoordinatorProvider>(
    () => InventoryCoordinatorProvider(
      database: sl<AppDatabase>(),
      getInventoryLinesUseCase: sl<GetInventoryLinesUseCase>(),
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      getSubCategoriesUseCase: sl<GetSubCategoriesUseCase>(),
      getSuppliersUseCase: sl<GetSuppliersUseCase>(),
      inventoryLineRepository: sl<InventoryLineRepository>(),
      categoryRepository: sl<CategoryRepository>(),
      subCategoryRepository: sl<SubCategoryRepository>(),
      supplierRepository: sl<SupplierRepository>(),
      colorsRepository: sl<InventoryColorsRepository>(),
      sizesRepository: sl<InventorySizesRepository>(),
      seasonRepository: sl<SeasonRepository>(),
      locationsRepository: sl<InventoryLocationsRepository>(),
    ),
  );
}

void _dashboard() {
  // Dashboard Provider
  sl.registerFactory<DashboardProvider>(
    () => DashboardProvider(),
  );
}
