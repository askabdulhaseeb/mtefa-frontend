import '../../core/resources/data_state.dart';
import '../entities/inventory/supplier_entity.dart';

abstract class SupplierRepository {
  Future<DataState<List<SupplierEntity>>> getAllSuppliers();
  Future<DataState<SupplierEntity?>> getSupplierById(String supplierId);
  Future<DataState<List<SupplierEntity>>> getSuppliersByBusinessId(String businessId);
  Future<DataState<SupplierEntity>> createSupplier(SupplierEntity supplier);
  Future<DataState<SupplierEntity>> updateSupplier(SupplierEntity supplier);
  Future<DataState<void>> deleteSupplier(String supplierId);
  Future<DataState<List<SupplierEntity>>> getActiveSuppliers();
  Future<DataState<List<SupplierEntity>>> getPreferredSuppliers();
}