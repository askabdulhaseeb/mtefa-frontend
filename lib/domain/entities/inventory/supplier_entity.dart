import 'package:equatable/equatable.dart';

import '../../../core/enums/status_type.dart';

class SupplierEntity extends Equatable {

  const SupplierEntity({
    required this.supplierId,
    required this.businessId,
    required this.supplierCode,
    required this.supplierName,
    required this.createdAt, required this.updatedAt, this.supplierType,
    this.contactPerson,
    this.phone,
    this.email,
    this.website,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.taxNumber,
    this.paymentTerms,
    this.creditLimit,
    this.currency = 'PKR',
    this.leadTimeDays,
    this.minimumOrderAmount,
    this.shippingMethods,
    this.qualityRating,
    this.deliveryRating,
    this.priceRating,
    this.preferredSupplier = false,
    this.contractStartDate,
    this.contractEndDate,
    this.notes,
    this.status = StatusType.active,
    this.createdBy,
    this.updatedBy,
    this.syncStatus = 'pending',
  });
  final String supplierId;
  final String businessId;
  final String supplierCode;
  final String supplierName;
  final String? supplierType; // manufacturer, distributor, wholesaler
  final String? contactPerson;
  final String? phone;
  final String? email;
  final String? website;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? taxNumber;
  final String? paymentTerms; // Net 30, COD, 2/10 Net 30
  final double? creditLimit;
  final String currency;
  final int? leadTimeDays;
  final double? minimumOrderAmount;
  final List<String>? shippingMethods;
  final double? qualityRating; // 1.00 to 5.00
  final double? deliveryRating;
  final double? priceRating;
  final bool preferredSupplier;
  final DateTime? contractStartDate;
  final DateTime? contractEndDate;
  final String? notes;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  // Local sync fields
  final String? syncStatus;

  @override
  List<Object?> get props => <Object?>[
        supplierId,
        businessId,
        supplierCode,
        supplierName,
        supplierType,
        contactPerson,
        phone,
        email,
        website,
        address,
        city,
        state,
        country,
        postalCode,
        taxNumber,
        paymentTerms,
        creditLimit,
        currency,
        leadTimeDays,
        minimumOrderAmount,
        shippingMethods,
        qualityRating,
        deliveryRating,
        priceRating,
        preferredSupplier,
        contractStartDate,
        contractEndDate,
        notes,
        status,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        syncStatus,
      ];

  SupplierEntity copyWith({
    String? supplierId,
    String? businessId,
    String? supplierCode,
    String? supplierName,
    String? supplierType,
    String? contactPerson,
    String? phone,
    String? email,
    String? website,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? taxNumber,
    String? paymentTerms,
    double? creditLimit,
    String? currency,
    int? leadTimeDays,
    double? minimumOrderAmount,
    List<String>? shippingMethods,
    double? qualityRating,
    double? deliveryRating,
    double? priceRating,
    bool? preferredSupplier,
    DateTime? contractStartDate,
    DateTime? contractEndDate,
    String? notes,
    StatusType? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return SupplierEntity(
      supplierId: supplierId ?? this.supplierId,
      businessId: businessId ?? this.businessId,
      supplierCode: supplierCode ?? this.supplierCode,
      supplierName: supplierName ?? this.supplierName,
      supplierType: supplierType ?? this.supplierType,
      contactPerson: contactPerson ?? this.contactPerson,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      taxNumber: taxNumber ?? this.taxNumber,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      creditLimit: creditLimit ?? this.creditLimit,
      currency: currency ?? this.currency,
      leadTimeDays: leadTimeDays ?? this.leadTimeDays,
      minimumOrderAmount: minimumOrderAmount ?? this.minimumOrderAmount,
      shippingMethods: shippingMethods ?? this.shippingMethods,
      qualityRating: qualityRating ?? this.qualityRating,
      deliveryRating: deliveryRating ?? this.deliveryRating,
      priceRating: priceRating ?? this.priceRating,
      preferredSupplier: preferredSupplier ?? this.preferredSupplier,
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractEndDate: contractEndDate ?? this.contractEndDate,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}