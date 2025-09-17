import '../../core/database/database.dart';
import '../../core/enums/status_type.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/inventory/supplier_entity.dart';
import '../../domain/repositories/supplier_repository.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  SupplierRepositoryImpl({required this.database});

  final AppDatabase database;

  @override
  Future<DataState<List<SupplierEntity>>> getAllSuppliers() async {
    try {
      final List<Supplier> suppliers = await database.select(database.suppliers).get();
      final List<SupplierEntity> entities = suppliers.map(_toEntity).toList();
      return DataSuccess<List<SupplierEntity>>(entities);
    } catch (e) {
      return DataFailed<List<SupplierEntity>>(
        error: 'Failed to get suppliers: ${e.toString()}',
        errorCode: 'GET_SUPPLIERS_FAILED',
      );
    }
  }

  @override
  Future<DataState<SupplierEntity?>> getSupplierById(String supplierId) async {
    // TODO: Implement
    return const DataFailed<SupplierEntity?>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<List<SupplierEntity>>> getSuppliersByBusinessId(String businessId) async {
    // TODO: Implement
    return const DataFailed<List<SupplierEntity>>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<SupplierEntity>> createSupplier(SupplierEntity supplier) async {
    // TODO: Implement
    return const DataFailed<SupplierEntity>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<SupplierEntity>> updateSupplier(SupplierEntity supplier) async {
    // TODO: Implement
    return const DataFailed<SupplierEntity>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<void>> deleteSupplier(String supplierId) async {
    // TODO: Implement
    return const DataFailed<void>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  @override
  Future<DataState<List<SupplierEntity>>> getActiveSuppliers() async {
    try {
      final List<Supplier> suppliers = await (database.select(database.suppliers)
            ..where((tbl) => tbl.status.equals(StatusType.active.value)))
          .get();
      
      final List<SupplierEntity> entities = suppliers.map(_toEntity).toList();
      return DataSuccess<List<SupplierEntity>>(entities);
    } catch (e) {
      return DataFailed<List<SupplierEntity>>(
        error: 'Failed to get active suppliers: ${e.toString()}',
        errorCode: 'GET_ACTIVE_SUPPLIERS_FAILED',
      );
    }
  }

  @override
  Future<DataState<List<SupplierEntity>>> getPreferredSuppliers() async {
    // TODO: Implement
    return const DataFailed<List<SupplierEntity>>(
      error: 'Not implemented',
      errorCode: 'NOT_IMPLEMENTED',
    );
  }

  SupplierEntity _toEntity(Supplier data) {
    return SupplierEntity(
      supplierId: data.supplierId,
      businessId: data.businessId,
      supplierCode: data.supplierCode,
      supplierName: data.supplierName,
      supplierType: data.supplierType,
      contactPerson: data.contactPerson,
      phone: data.phone,
      email: data.email,
      website: data.website,
      address: data.address,
      city: data.city,
      state: data.state,
      country: data.country,
      postalCode: data.postalCode,
      taxNumber: data.taxNumber,
      paymentTerms: data.paymentTerms,
      creditLimit: data.creditLimit,
      currency: data.currency,
      leadTimeDays: data.leadTimeDays,
      minimumOrderAmount: data.minimumOrderAmount,
      shippingMethods: data.shippingMethods?.split(',') ?? <String>[],
      qualityRating: data.qualityRating,
      deliveryRating: data.deliveryRating,
      priceRating: data.priceRating,
      preferredSupplier: data.preferredSupplier,
      contractStartDate: data.contractStartDate,
      contractEndDate: data.contractEndDate,
      notes: data.notes,
      status: data.status,
      createdBy: data.createdBy,
      updatedBy: data.updatedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
    );
  }
}