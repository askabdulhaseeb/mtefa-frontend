// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    password,
    name,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final int id;
  final String email;
  final String password;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalUser({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      password: Value(password),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalUser copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalUser(
    id: id ?? this.id,
    email: email ?? this.email,
    password: password ?? this.password,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalUser copyWithCompanion(UsersCompanion data) {
    return LocalUser(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, email, password, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String password,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : email = Value(email),
       password = Value(password),
       name = Value(name);
  static Insertable<LocalUser> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? email,
    Value<String>? password,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierCodeMeta = const VerificationMeta(
    'supplierCode',
  );
  @override
  late final GeneratedColumn<String> supplierCode = GeneratedColumn<String>(
    'supplier_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierTypeMeta = const VerificationMeta(
    'supplierType',
  );
  @override
  late final GeneratedColumn<String> supplierType = GeneratedColumn<String>(
    'supplier_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactPersonMeta = const VerificationMeta(
    'contactPerson',
  );
  @override
  late final GeneratedColumn<String> contactPerson = GeneratedColumn<String>(
    'contact_person',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxNumberMeta = const VerificationMeta(
    'taxNumber',
  );
  @override
  late final GeneratedColumn<String> taxNumber = GeneratedColumn<String>(
    'tax_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentTermsMeta = const VerificationMeta(
    'paymentTerms',
  );
  @override
  late final GeneratedColumn<String> paymentTerms = GeneratedColumn<String>(
    'payment_terms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta(
    'creditLimit',
  );
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
    'credit_limit',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('PKR'),
  );
  static const VerificationMeta _leadTimeDaysMeta = const VerificationMeta(
    'leadTimeDays',
  );
  @override
  late final GeneratedColumn<int> leadTimeDays = GeneratedColumn<int>(
    'lead_time_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minimumOrderAmountMeta =
      const VerificationMeta('minimumOrderAmount');
  @override
  late final GeneratedColumn<double> minimumOrderAmount =
      GeneratedColumn<double>(
        'minimum_order_amount',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _shippingMethodsMeta = const VerificationMeta(
    'shippingMethods',
  );
  @override
  late final GeneratedColumn<String> shippingMethods = GeneratedColumn<String>(
    'shipping_methods',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qualityRatingMeta = const VerificationMeta(
    'qualityRating',
  );
  @override
  late final GeneratedColumn<double> qualityRating = GeneratedColumn<double>(
    'quality_rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deliveryRatingMeta = const VerificationMeta(
    'deliveryRating',
  );
  @override
  late final GeneratedColumn<double> deliveryRating = GeneratedColumn<double>(
    'delivery_rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceRatingMeta = const VerificationMeta(
    'priceRating',
  );
  @override
  late final GeneratedColumn<double> priceRating = GeneratedColumn<double>(
    'price_rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredSupplierMeta = const VerificationMeta(
    'preferredSupplier',
  );
  @override
  late final GeneratedColumn<bool> preferredSupplier = GeneratedColumn<bool>(
    'preferred_supplier',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("preferred_supplier" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(false),
  );
  static const VerificationMeta _contractStartDateMeta = const VerificationMeta(
    'contractStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> contractStartDate =
      GeneratedColumn<DateTime>(
        'contract_start_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _contractEndDateMeta = const VerificationMeta(
    'contractEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> contractEndDate =
      GeneratedColumn<DateTime>(
        'contract_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($SuppliersTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('supplier_code')) {
      context.handle(
        _supplierCodeMeta,
        supplierCode.isAcceptableOrUnknown(
          data['supplier_code']!,
          _supplierCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_supplierCodeMeta);
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_supplierNameMeta);
    }
    if (data.containsKey('supplier_type')) {
      context.handle(
        _supplierTypeMeta,
        supplierType.isAcceptableOrUnknown(
          data['supplier_type']!,
          _supplierTypeMeta,
        ),
      );
    }
    if (data.containsKey('contact_person')) {
      context.handle(
        _contactPersonMeta,
        contactPerson.isAcceptableOrUnknown(
          data['contact_person']!,
          _contactPersonMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('tax_number')) {
      context.handle(
        _taxNumberMeta,
        taxNumber.isAcceptableOrUnknown(data['tax_number']!, _taxNumberMeta),
      );
    }
    if (data.containsKey('payment_terms')) {
      context.handle(
        _paymentTermsMeta,
        paymentTerms.isAcceptableOrUnknown(
          data['payment_terms']!,
          _paymentTermsMeta,
        ),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(
          data['credit_limit']!,
          _creditLimitMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('lead_time_days')) {
      context.handle(
        _leadTimeDaysMeta,
        leadTimeDays.isAcceptableOrUnknown(
          data['lead_time_days']!,
          _leadTimeDaysMeta,
        ),
      );
    }
    if (data.containsKey('minimum_order_amount')) {
      context.handle(
        _minimumOrderAmountMeta,
        minimumOrderAmount.isAcceptableOrUnknown(
          data['minimum_order_amount']!,
          _minimumOrderAmountMeta,
        ),
      );
    }
    if (data.containsKey('shipping_methods')) {
      context.handle(
        _shippingMethodsMeta,
        shippingMethods.isAcceptableOrUnknown(
          data['shipping_methods']!,
          _shippingMethodsMeta,
        ),
      );
    }
    if (data.containsKey('quality_rating')) {
      context.handle(
        _qualityRatingMeta,
        qualityRating.isAcceptableOrUnknown(
          data['quality_rating']!,
          _qualityRatingMeta,
        ),
      );
    }
    if (data.containsKey('delivery_rating')) {
      context.handle(
        _deliveryRatingMeta,
        deliveryRating.isAcceptableOrUnknown(
          data['delivery_rating']!,
          _deliveryRatingMeta,
        ),
      );
    }
    if (data.containsKey('price_rating')) {
      context.handle(
        _priceRatingMeta,
        priceRating.isAcceptableOrUnknown(
          data['price_rating']!,
          _priceRatingMeta,
        ),
      );
    }
    if (data.containsKey('preferred_supplier')) {
      context.handle(
        _preferredSupplierMeta,
        preferredSupplier.isAcceptableOrUnknown(
          data['preferred_supplier']!,
          _preferredSupplierMeta,
        ),
      );
    }
    if (data.containsKey('contract_start_date')) {
      context.handle(
        _contractStartDateMeta,
        contractStartDate.isAcceptableOrUnknown(
          data['contract_start_date']!,
          _contractStartDateMeta,
        ),
      );
    }
    if (data.containsKey('contract_end_date')) {
      context.handle(
        _contractEndDateMeta,
        contractEndDate.isAcceptableOrUnknown(
          data['contract_end_date']!,
          _contractEndDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {supplierId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {businessId, supplierCode},
  ];
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      supplierCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_code'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      )!,
      supplierType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_type'],
      ),
      contactPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_person'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      ),
      taxNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_number'],
      ),
      paymentTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_terms'],
      ),
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_limit'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      leadTimeDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lead_time_days'],
      ),
      minimumOrderAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}minimum_order_amount'],
      ),
      shippingMethods: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shipping_methods'],
      ),
      qualityRating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quality_rating'],
      ),
      deliveryRating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delivery_rating'],
      ),
      priceRating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_rating'],
      ),
      preferredSupplier: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}preferred_supplier'],
      )!,
      contractStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}contract_start_date'],
      ),
      contractEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}contract_end_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: $SuppliersTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final String supplierId;
  final String businessId;
  final String supplierCode;
  final String supplierName;
  final String? supplierType;
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
  final String? paymentTerms;
  final double? creditLimit;
  final String currency;
  final int? leadTimeDays;
  final double? minimumOrderAmount;
  final String? shippingMethods;
  final double? qualityRating;
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
  final String syncStatus;
  const Supplier({
    required this.supplierId,
    required this.businessId,
    required this.supplierCode,
    required this.supplierName,
    this.supplierType,
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
    required this.currency,
    this.leadTimeDays,
    this.minimumOrderAmount,
    this.shippingMethods,
    this.qualityRating,
    this.deliveryRating,
    this.priceRating,
    required this.preferredSupplier,
    this.contractStartDate,
    this.contractEndDate,
    this.notes,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['supplier_id'] = Variable<String>(supplierId);
    map['business_id'] = Variable<String>(businessId);
    map['supplier_code'] = Variable<String>(supplierCode);
    map['supplier_name'] = Variable<String>(supplierName);
    if (!nullToAbsent || supplierType != null) {
      map['supplier_type'] = Variable<String>(supplierType);
    }
    if (!nullToAbsent || contactPerson != null) {
      map['contact_person'] = Variable<String>(contactPerson);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String>(postalCode);
    }
    if (!nullToAbsent || taxNumber != null) {
      map['tax_number'] = Variable<String>(taxNumber);
    }
    if (!nullToAbsent || paymentTerms != null) {
      map['payment_terms'] = Variable<String>(paymentTerms);
    }
    if (!nullToAbsent || creditLimit != null) {
      map['credit_limit'] = Variable<double>(creditLimit);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || leadTimeDays != null) {
      map['lead_time_days'] = Variable<int>(leadTimeDays);
    }
    if (!nullToAbsent || minimumOrderAmount != null) {
      map['minimum_order_amount'] = Variable<double>(minimumOrderAmount);
    }
    if (!nullToAbsent || shippingMethods != null) {
      map['shipping_methods'] = Variable<String>(shippingMethods);
    }
    if (!nullToAbsent || qualityRating != null) {
      map['quality_rating'] = Variable<double>(qualityRating);
    }
    if (!nullToAbsent || deliveryRating != null) {
      map['delivery_rating'] = Variable<double>(deliveryRating);
    }
    if (!nullToAbsent || priceRating != null) {
      map['price_rating'] = Variable<double>(priceRating);
    }
    map['preferred_supplier'] = Variable<bool>(preferredSupplier);
    if (!nullToAbsent || contractStartDate != null) {
      map['contract_start_date'] = Variable<DateTime>(contractStartDate);
    }
    if (!nullToAbsent || contractEndDate != null) {
      map['contract_end_date'] = Variable<DateTime>(contractEndDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['status'] = Variable<String>(
        $SuppliersTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      supplierId: Value(supplierId),
      businessId: Value(businessId),
      supplierCode: Value(supplierCode),
      supplierName: Value(supplierName),
      supplierType: supplierType == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierType),
      contactPerson: contactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPerson),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
      taxNumber: taxNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(taxNumber),
      paymentTerms: paymentTerms == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentTerms),
      creditLimit: creditLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimit),
      currency: Value(currency),
      leadTimeDays: leadTimeDays == null && nullToAbsent
          ? const Value.absent()
          : Value(leadTimeDays),
      minimumOrderAmount: minimumOrderAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumOrderAmount),
      shippingMethods: shippingMethods == null && nullToAbsent
          ? const Value.absent()
          : Value(shippingMethods),
      qualityRating: qualityRating == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityRating),
      deliveryRating: deliveryRating == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryRating),
      priceRating: priceRating == null && nullToAbsent
          ? const Value.absent()
          : Value(priceRating),
      preferredSupplier: Value(preferredSupplier),
      contractStartDate: contractStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(contractStartDate),
      contractEndDate: contractEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(contractEndDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      supplierId: serializer.fromJson<String>(json['supplierId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      supplierCode: serializer.fromJson<String>(json['supplierCode']),
      supplierName: serializer.fromJson<String>(json['supplierName']),
      supplierType: serializer.fromJson<String?>(json['supplierType']),
      contactPerson: serializer.fromJson<String?>(json['contactPerson']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      website: serializer.fromJson<String?>(json['website']),
      address: serializer.fromJson<String?>(json['address']),
      city: serializer.fromJson<String?>(json['city']),
      state: serializer.fromJson<String?>(json['state']),
      country: serializer.fromJson<String?>(json['country']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
      taxNumber: serializer.fromJson<String?>(json['taxNumber']),
      paymentTerms: serializer.fromJson<String?>(json['paymentTerms']),
      creditLimit: serializer.fromJson<double?>(json['creditLimit']),
      currency: serializer.fromJson<String>(json['currency']),
      leadTimeDays: serializer.fromJson<int?>(json['leadTimeDays']),
      minimumOrderAmount: serializer.fromJson<double?>(
        json['minimumOrderAmount'],
      ),
      shippingMethods: serializer.fromJson<String?>(json['shippingMethods']),
      qualityRating: serializer.fromJson<double?>(json['qualityRating']),
      deliveryRating: serializer.fromJson<double?>(json['deliveryRating']),
      priceRating: serializer.fromJson<double?>(json['priceRating']),
      preferredSupplier: serializer.fromJson<bool>(json['preferredSupplier']),
      contractStartDate: serializer.fromJson<DateTime?>(
        json['contractStartDate'],
      ),
      contractEndDate: serializer.fromJson<DateTime?>(json['contractEndDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: $SuppliersTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'supplierId': serializer.toJson<String>(supplierId),
      'businessId': serializer.toJson<String>(businessId),
      'supplierCode': serializer.toJson<String>(supplierCode),
      'supplierName': serializer.toJson<String>(supplierName),
      'supplierType': serializer.toJson<String?>(supplierType),
      'contactPerson': serializer.toJson<String?>(contactPerson),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'website': serializer.toJson<String?>(website),
      'address': serializer.toJson<String?>(address),
      'city': serializer.toJson<String?>(city),
      'state': serializer.toJson<String?>(state),
      'country': serializer.toJson<String?>(country),
      'postalCode': serializer.toJson<String?>(postalCode),
      'taxNumber': serializer.toJson<String?>(taxNumber),
      'paymentTerms': serializer.toJson<String?>(paymentTerms),
      'creditLimit': serializer.toJson<double?>(creditLimit),
      'currency': serializer.toJson<String>(currency),
      'leadTimeDays': serializer.toJson<int?>(leadTimeDays),
      'minimumOrderAmount': serializer.toJson<double?>(minimumOrderAmount),
      'shippingMethods': serializer.toJson<String?>(shippingMethods),
      'qualityRating': serializer.toJson<double?>(qualityRating),
      'deliveryRating': serializer.toJson<double?>(deliveryRating),
      'priceRating': serializer.toJson<double?>(priceRating),
      'preferredSupplier': serializer.toJson<bool>(preferredSupplier),
      'contractStartDate': serializer.toJson<DateTime?>(contractStartDate),
      'contractEndDate': serializer.toJson<DateTime?>(contractEndDate),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(
        $SuppliersTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Supplier copyWith({
    String? supplierId,
    String? businessId,
    String? supplierCode,
    String? supplierName,
    Value<String?> supplierType = const Value.absent(),
    Value<String?> contactPerson = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> website = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> state = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> postalCode = const Value.absent(),
    Value<String?> taxNumber = const Value.absent(),
    Value<String?> paymentTerms = const Value.absent(),
    Value<double?> creditLimit = const Value.absent(),
    String? currency,
    Value<int?> leadTimeDays = const Value.absent(),
    Value<double?> minimumOrderAmount = const Value.absent(),
    Value<String?> shippingMethods = const Value.absent(),
    Value<double?> qualityRating = const Value.absent(),
    Value<double?> deliveryRating = const Value.absent(),
    Value<double?> priceRating = const Value.absent(),
    bool? preferredSupplier,
    Value<DateTime?> contractStartDate = const Value.absent(),
    Value<DateTime?> contractEndDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => Supplier(
    supplierId: supplierId ?? this.supplierId,
    businessId: businessId ?? this.businessId,
    supplierCode: supplierCode ?? this.supplierCode,
    supplierName: supplierName ?? this.supplierName,
    supplierType: supplierType.present ? supplierType.value : this.supplierType,
    contactPerson: contactPerson.present
        ? contactPerson.value
        : this.contactPerson,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    website: website.present ? website.value : this.website,
    address: address.present ? address.value : this.address,
    city: city.present ? city.value : this.city,
    state: state.present ? state.value : this.state,
    country: country.present ? country.value : this.country,
    postalCode: postalCode.present ? postalCode.value : this.postalCode,
    taxNumber: taxNumber.present ? taxNumber.value : this.taxNumber,
    paymentTerms: paymentTerms.present ? paymentTerms.value : this.paymentTerms,
    creditLimit: creditLimit.present ? creditLimit.value : this.creditLimit,
    currency: currency ?? this.currency,
    leadTimeDays: leadTimeDays.present ? leadTimeDays.value : this.leadTimeDays,
    minimumOrderAmount: minimumOrderAmount.present
        ? minimumOrderAmount.value
        : this.minimumOrderAmount,
    shippingMethods: shippingMethods.present
        ? shippingMethods.value
        : this.shippingMethods,
    qualityRating: qualityRating.present
        ? qualityRating.value
        : this.qualityRating,
    deliveryRating: deliveryRating.present
        ? deliveryRating.value
        : this.deliveryRating,
    priceRating: priceRating.present ? priceRating.value : this.priceRating,
    preferredSupplier: preferredSupplier ?? this.preferredSupplier,
    contractStartDate: contractStartDate.present
        ? contractStartDate.value
        : this.contractStartDate,
    contractEndDate: contractEndDate.present
        ? contractEndDate.value
        : this.contractEndDate,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      supplierCode: data.supplierCode.present
          ? data.supplierCode.value
          : this.supplierCode,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      supplierType: data.supplierType.present
          ? data.supplierType.value
          : this.supplierType,
      contactPerson: data.contactPerson.present
          ? data.contactPerson.value
          : this.contactPerson,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      website: data.website.present ? data.website.value : this.website,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      country: data.country.present ? data.country.value : this.country,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      taxNumber: data.taxNumber.present ? data.taxNumber.value : this.taxNumber,
      paymentTerms: data.paymentTerms.present
          ? data.paymentTerms.value
          : this.paymentTerms,
      creditLimit: data.creditLimit.present
          ? data.creditLimit.value
          : this.creditLimit,
      currency: data.currency.present ? data.currency.value : this.currency,
      leadTimeDays: data.leadTimeDays.present
          ? data.leadTimeDays.value
          : this.leadTimeDays,
      minimumOrderAmount: data.minimumOrderAmount.present
          ? data.minimumOrderAmount.value
          : this.minimumOrderAmount,
      shippingMethods: data.shippingMethods.present
          ? data.shippingMethods.value
          : this.shippingMethods,
      qualityRating: data.qualityRating.present
          ? data.qualityRating.value
          : this.qualityRating,
      deliveryRating: data.deliveryRating.present
          ? data.deliveryRating.value
          : this.deliveryRating,
      priceRating: data.priceRating.present
          ? data.priceRating.value
          : this.priceRating,
      preferredSupplier: data.preferredSupplier.present
          ? data.preferredSupplier.value
          : this.preferredSupplier,
      contractStartDate: data.contractStartDate.present
          ? data.contractStartDate.value
          : this.contractStartDate,
      contractEndDate: data.contractEndDate.present
          ? data.contractEndDate.value
          : this.contractEndDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('supplierId: $supplierId, ')
          ..write('businessId: $businessId, ')
          ..write('supplierCode: $supplierCode, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierType: $supplierType, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('postalCode: $postalCode, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('currency: $currency, ')
          ..write('leadTimeDays: $leadTimeDays, ')
          ..write('minimumOrderAmount: $minimumOrderAmount, ')
          ..write('shippingMethods: $shippingMethods, ')
          ..write('qualityRating: $qualityRating, ')
          ..write('deliveryRating: $deliveryRating, ')
          ..write('priceRating: $priceRating, ')
          ..write('preferredSupplier: $preferredSupplier, ')
          ..write('contractStartDate: $contractStartDate, ')
          ..write('contractEndDate: $contractEndDate, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.supplierId == this.supplierId &&
          other.businessId == this.businessId &&
          other.supplierCode == this.supplierCode &&
          other.supplierName == this.supplierName &&
          other.supplierType == this.supplierType &&
          other.contactPerson == this.contactPerson &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.website == this.website &&
          other.address == this.address &&
          other.city == this.city &&
          other.state == this.state &&
          other.country == this.country &&
          other.postalCode == this.postalCode &&
          other.taxNumber == this.taxNumber &&
          other.paymentTerms == this.paymentTerms &&
          other.creditLimit == this.creditLimit &&
          other.currency == this.currency &&
          other.leadTimeDays == this.leadTimeDays &&
          other.minimumOrderAmount == this.minimumOrderAmount &&
          other.shippingMethods == this.shippingMethods &&
          other.qualityRating == this.qualityRating &&
          other.deliveryRating == this.deliveryRating &&
          other.priceRating == this.priceRating &&
          other.preferredSupplier == this.preferredSupplier &&
          other.contractStartDate == this.contractStartDate &&
          other.contractEndDate == this.contractEndDate &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<String> supplierId;
  final Value<String> businessId;
  final Value<String> supplierCode;
  final Value<String> supplierName;
  final Value<String?> supplierType;
  final Value<String?> contactPerson;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> website;
  final Value<String?> address;
  final Value<String?> city;
  final Value<String?> state;
  final Value<String?> country;
  final Value<String?> postalCode;
  final Value<String?> taxNumber;
  final Value<String?> paymentTerms;
  final Value<double?> creditLimit;
  final Value<String> currency;
  final Value<int?> leadTimeDays;
  final Value<double?> minimumOrderAmount;
  final Value<String?> shippingMethods;
  final Value<double?> qualityRating;
  final Value<double?> deliveryRating;
  final Value<double?> priceRating;
  final Value<bool> preferredSupplier;
  final Value<DateTime?> contractStartDate;
  final Value<DateTime?> contractEndDate;
  final Value<String?> notes;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.supplierId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.supplierCode = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierType = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.currency = const Value.absent(),
    this.leadTimeDays = const Value.absent(),
    this.minimumOrderAmount = const Value.absent(),
    this.shippingMethods = const Value.absent(),
    this.qualityRating = const Value.absent(),
    this.deliveryRating = const Value.absent(),
    this.priceRating = const Value.absent(),
    this.preferredSupplier = const Value.absent(),
    this.contractStartDate = const Value.absent(),
    this.contractEndDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    required String supplierId,
    required String businessId,
    required String supplierCode,
    required String supplierName,
    this.supplierType = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.currency = const Value.absent(),
    this.leadTimeDays = const Value.absent(),
    this.minimumOrderAmount = const Value.absent(),
    this.shippingMethods = const Value.absent(),
    this.qualityRating = const Value.absent(),
    this.deliveryRating = const Value.absent(),
    this.priceRating = const Value.absent(),
    this.preferredSupplier = const Value.absent(),
    this.contractStartDate = const Value.absent(),
    this.contractEndDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : supplierId = Value(supplierId),
       businessId = Value(businessId),
       supplierCode = Value(supplierCode),
       supplierName = Value(supplierName);
  static Insertable<Supplier> custom({
    Expression<String>? supplierId,
    Expression<String>? businessId,
    Expression<String>? supplierCode,
    Expression<String>? supplierName,
    Expression<String>? supplierType,
    Expression<String>? contactPerson,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? website,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? country,
    Expression<String>? postalCode,
    Expression<String>? taxNumber,
    Expression<String>? paymentTerms,
    Expression<double>? creditLimit,
    Expression<String>? currency,
    Expression<int>? leadTimeDays,
    Expression<double>? minimumOrderAmount,
    Expression<String>? shippingMethods,
    Expression<double>? qualityRating,
    Expression<double>? deliveryRating,
    Expression<double>? priceRating,
    Expression<bool>? preferredSupplier,
    Expression<DateTime>? contractStartDate,
    Expression<DateTime>? contractEndDate,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (supplierId != null) 'supplier_id': supplierId,
      if (businessId != null) 'business_id': businessId,
      if (supplierCode != null) 'supplier_code': supplierCode,
      if (supplierName != null) 'supplier_name': supplierName,
      if (supplierType != null) 'supplier_type': supplierType,
      if (contactPerson != null) 'contact_person': contactPerson,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (postalCode != null) 'postal_code': postalCode,
      if (taxNumber != null) 'tax_number': taxNumber,
      if (paymentTerms != null) 'payment_terms': paymentTerms,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (currency != null) 'currency': currency,
      if (leadTimeDays != null) 'lead_time_days': leadTimeDays,
      if (minimumOrderAmount != null)
        'minimum_order_amount': minimumOrderAmount,
      if (shippingMethods != null) 'shipping_methods': shippingMethods,
      if (qualityRating != null) 'quality_rating': qualityRating,
      if (deliveryRating != null) 'delivery_rating': deliveryRating,
      if (priceRating != null) 'price_rating': priceRating,
      if (preferredSupplier != null) 'preferred_supplier': preferredSupplier,
      if (contractStartDate != null) 'contract_start_date': contractStartDate,
      if (contractEndDate != null) 'contract_end_date': contractEndDate,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith({
    Value<String>? supplierId,
    Value<String>? businessId,
    Value<String>? supplierCode,
    Value<String>? supplierName,
    Value<String?>? supplierType,
    Value<String?>? contactPerson,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? website,
    Value<String?>? address,
    Value<String?>? city,
    Value<String?>? state,
    Value<String?>? country,
    Value<String?>? postalCode,
    Value<String?>? taxNumber,
    Value<String?>? paymentTerms,
    Value<double?>? creditLimit,
    Value<String>? currency,
    Value<int?>? leadTimeDays,
    Value<double?>? minimumOrderAmount,
    Value<String?>? shippingMethods,
    Value<double?>? qualityRating,
    Value<double?>? deliveryRating,
    Value<double?>? priceRating,
    Value<bool>? preferredSupplier,
    Value<DateTime?>? contractStartDate,
    Value<DateTime?>? contractEndDate,
    Value<String?>? notes,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return SuppliersCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (supplierCode.present) {
      map['supplier_code'] = Variable<String>(supplierCode.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (supplierType.present) {
      map['supplier_type'] = Variable<String>(supplierType.value);
    }
    if (contactPerson.present) {
      map['contact_person'] = Variable<String>(contactPerson.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (taxNumber.present) {
      map['tax_number'] = Variable<String>(taxNumber.value);
    }
    if (paymentTerms.present) {
      map['payment_terms'] = Variable<String>(paymentTerms.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (leadTimeDays.present) {
      map['lead_time_days'] = Variable<int>(leadTimeDays.value);
    }
    if (minimumOrderAmount.present) {
      map['minimum_order_amount'] = Variable<double>(minimumOrderAmount.value);
    }
    if (shippingMethods.present) {
      map['shipping_methods'] = Variable<String>(shippingMethods.value);
    }
    if (qualityRating.present) {
      map['quality_rating'] = Variable<double>(qualityRating.value);
    }
    if (deliveryRating.present) {
      map['delivery_rating'] = Variable<double>(deliveryRating.value);
    }
    if (priceRating.present) {
      map['price_rating'] = Variable<double>(priceRating.value);
    }
    if (preferredSupplier.present) {
      map['preferred_supplier'] = Variable<bool>(preferredSupplier.value);
    }
    if (contractStartDate.present) {
      map['contract_start_date'] = Variable<DateTime>(contractStartDate.value);
    }
    if (contractEndDate.present) {
      map['contract_end_date'] = Variable<DateTime>(contractEndDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SuppliersTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('supplierId: $supplierId, ')
          ..write('businessId: $businessId, ')
          ..write('supplierCode: $supplierCode, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierType: $supplierType, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('postalCode: $postalCode, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('currency: $currency, ')
          ..write('leadTimeDays: $leadTimeDays, ')
          ..write('minimumOrderAmount: $minimumOrderAmount, ')
          ..write('shippingMethods: $shippingMethods, ')
          ..write('qualityRating: $qualityRating, ')
          ..write('deliveryRating: $deliveryRating, ')
          ..write('priceRating: $priceRating, ')
          ..write('preferredSupplier: $preferredSupplier, ')
          ..write('contractStartDate: $contractStartDate, ')
          ..write('contractEndDate: $contractEndDate, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryLineTable extends InventoryLine
    with TableInfo<$InventoryLineTable, InventoryLineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryLineTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _inventoryLineIdMeta = const VerificationMeta(
    'inventoryLineId',
  );
  @override
  late final GeneratedColumn<String> inventoryLineId = GeneratedColumn<String>(
    'inventory_line_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineCodeMeta = const VerificationMeta(
    'lineCode',
  );
  @override
  late final GeneratedColumn<String> lineCode = GeneratedColumn<String>(
    'line_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineNameMeta = const VerificationMeta(
    'lineName',
  );
  @override
  late final GeneratedColumn<String> lineName = GeneratedColumn<String>(
    'line_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineDescriptionMeta = const VerificationMeta(
    'lineDescription',
  );
  @override
  late final GeneratedColumn<String> lineDescription = GeneratedColumn<String>(
    'line_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlacementType, String>
  linePlacement = GeneratedColumn<String>(
    'line_placement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pre'),
  ).withConverter<PlacementType>($InventoryLineTable.$converterlinePlacement);
  static const VerificationMeta _parentLineIdMeta = const VerificationMeta(
    'parentLineId',
  );
  @override
  late final GeneratedColumn<String> parentLineId = GeneratedColumn<String>(
    'parent_line_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($InventoryLineTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    inventoryLineId,
    businessId,
    lineCode,
    lineName,
    lineDescription,
    linePlacement,
    parentLineId,
    sortOrder,
    isActive,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_line';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryLineData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('inventory_line_id')) {
      context.handle(
        _inventoryLineIdMeta,
        inventoryLineId.isAcceptableOrUnknown(
          data['inventory_line_id']!,
          _inventoryLineIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inventoryLineIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('line_code')) {
      context.handle(
        _lineCodeMeta,
        lineCode.isAcceptableOrUnknown(data['line_code']!, _lineCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_lineCodeMeta);
    }
    if (data.containsKey('line_name')) {
      context.handle(
        _lineNameMeta,
        lineName.isAcceptableOrUnknown(data['line_name']!, _lineNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lineNameMeta);
    }
    if (data.containsKey('line_description')) {
      context.handle(
        _lineDescriptionMeta,
        lineDescription.isAcceptableOrUnknown(
          data['line_description']!,
          _lineDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('parent_line_id')) {
      context.handle(
        _parentLineIdMeta,
        parentLineId.isAcceptableOrUnknown(
          data['parent_line_id']!,
          _parentLineIdMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {inventoryLineId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {businessId, lineCode},
  ];
  @override
  InventoryLineData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryLineData(
      inventoryLineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inventory_line_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      lineCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_code'],
      )!,
      lineName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_name'],
      )!,
      lineDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_description'],
      ),
      linePlacement: $InventoryLineTable.$converterlinePlacement.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}line_placement'],
        )!,
      ),
      parentLineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_line_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      status: $InventoryLineTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $InventoryLineTable createAlias(String alias) {
    return $InventoryLineTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlacementType, String, String>
  $converterlinePlacement = const EnumNameConverter<PlacementType>(
    PlacementType.values,
  );
  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class InventoryLineData extends DataClass
    implements Insertable<InventoryLineData> {
  final String inventoryLineId;
  final String businessId;
  final String lineCode;
  final String lineName;
  final String? lineDescription;
  final PlacementType linePlacement;
  final String? parentLineId;
  final int sortOrder;
  final bool isActive;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const InventoryLineData({
    required this.inventoryLineId,
    required this.businessId,
    required this.lineCode,
    required this.lineName,
    this.lineDescription,
    required this.linePlacement,
    this.parentLineId,
    required this.sortOrder,
    required this.isActive,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['inventory_line_id'] = Variable<String>(inventoryLineId);
    map['business_id'] = Variable<String>(businessId);
    map['line_code'] = Variable<String>(lineCode);
    map['line_name'] = Variable<String>(lineName);
    if (!nullToAbsent || lineDescription != null) {
      map['line_description'] = Variable<String>(lineDescription);
    }
    {
      map['line_placement'] = Variable<String>(
        $InventoryLineTable.$converterlinePlacement.toSql(linePlacement),
      );
    }
    if (!nullToAbsent || parentLineId != null) {
      map['parent_line_id'] = Variable<String>(parentLineId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    {
      map['status'] = Variable<String>(
        $InventoryLineTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  InventoryLineCompanion toCompanion(bool nullToAbsent) {
    return InventoryLineCompanion(
      inventoryLineId: Value(inventoryLineId),
      businessId: Value(businessId),
      lineCode: Value(lineCode),
      lineName: Value(lineName),
      lineDescription: lineDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(lineDescription),
      linePlacement: Value(linePlacement),
      parentLineId: parentLineId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentLineId),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory InventoryLineData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryLineData(
      inventoryLineId: serializer.fromJson<String>(json['inventoryLineId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      lineCode: serializer.fromJson<String>(json['lineCode']),
      lineName: serializer.fromJson<String>(json['lineName']),
      lineDescription: serializer.fromJson<String?>(json['lineDescription']),
      linePlacement: $InventoryLineTable.$converterlinePlacement.fromJson(
        serializer.fromJson<String>(json['linePlacement']),
      ),
      parentLineId: serializer.fromJson<String?>(json['parentLineId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      status: $InventoryLineTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'inventoryLineId': serializer.toJson<String>(inventoryLineId),
      'businessId': serializer.toJson<String>(businessId),
      'lineCode': serializer.toJson<String>(lineCode),
      'lineName': serializer.toJson<String>(lineName),
      'lineDescription': serializer.toJson<String?>(lineDescription),
      'linePlacement': serializer.toJson<String>(
        $InventoryLineTable.$converterlinePlacement.toJson(linePlacement),
      ),
      'parentLineId': serializer.toJson<String?>(parentLineId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'status': serializer.toJson<String>(
        $InventoryLineTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  InventoryLineData copyWith({
    String? inventoryLineId,
    String? businessId,
    String? lineCode,
    String? lineName,
    Value<String?> lineDescription = const Value.absent(),
    PlacementType? linePlacement,
    Value<String?> parentLineId = const Value.absent(),
    int? sortOrder,
    bool? isActive,
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => InventoryLineData(
    inventoryLineId: inventoryLineId ?? this.inventoryLineId,
    businessId: businessId ?? this.businessId,
    lineCode: lineCode ?? this.lineCode,
    lineName: lineName ?? this.lineName,
    lineDescription: lineDescription.present
        ? lineDescription.value
        : this.lineDescription,
    linePlacement: linePlacement ?? this.linePlacement,
    parentLineId: parentLineId.present ? parentLineId.value : this.parentLineId,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  InventoryLineData copyWithCompanion(InventoryLineCompanion data) {
    return InventoryLineData(
      inventoryLineId: data.inventoryLineId.present
          ? data.inventoryLineId.value
          : this.inventoryLineId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      lineCode: data.lineCode.present ? data.lineCode.value : this.lineCode,
      lineName: data.lineName.present ? data.lineName.value : this.lineName,
      lineDescription: data.lineDescription.present
          ? data.lineDescription.value
          : this.lineDescription,
      linePlacement: data.linePlacement.present
          ? data.linePlacement.value
          : this.linePlacement,
      parentLineId: data.parentLineId.present
          ? data.parentLineId.value
          : this.parentLineId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLineData(')
          ..write('inventoryLineId: $inventoryLineId, ')
          ..write('businessId: $businessId, ')
          ..write('lineCode: $lineCode, ')
          ..write('lineName: $lineName, ')
          ..write('lineDescription: $lineDescription, ')
          ..write('linePlacement: $linePlacement, ')
          ..write('parentLineId: $parentLineId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    inventoryLineId,
    businessId,
    lineCode,
    lineName,
    lineDescription,
    linePlacement,
    parentLineId,
    sortOrder,
    isActive,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryLineData &&
          other.inventoryLineId == this.inventoryLineId &&
          other.businessId == this.businessId &&
          other.lineCode == this.lineCode &&
          other.lineName == this.lineName &&
          other.lineDescription == this.lineDescription &&
          other.linePlacement == this.linePlacement &&
          other.parentLineId == this.parentLineId &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class InventoryLineCompanion extends UpdateCompanion<InventoryLineData> {
  final Value<String> inventoryLineId;
  final Value<String> businessId;
  final Value<String> lineCode;
  final Value<String> lineName;
  final Value<String?> lineDescription;
  final Value<PlacementType> linePlacement;
  final Value<String?> parentLineId;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const InventoryLineCompanion({
    this.inventoryLineId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.lineCode = const Value.absent(),
    this.lineName = const Value.absent(),
    this.lineDescription = const Value.absent(),
    this.linePlacement = const Value.absent(),
    this.parentLineId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryLineCompanion.insert({
    required String inventoryLineId,
    required String businessId,
    required String lineCode,
    required String lineName,
    this.lineDescription = const Value.absent(),
    this.linePlacement = const Value.absent(),
    this.parentLineId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : inventoryLineId = Value(inventoryLineId),
       businessId = Value(businessId),
       lineCode = Value(lineCode),
       lineName = Value(lineName);
  static Insertable<InventoryLineData> custom({
    Expression<String>? inventoryLineId,
    Expression<String>? businessId,
    Expression<String>? lineCode,
    Expression<String>? lineName,
    Expression<String>? lineDescription,
    Expression<String>? linePlacement,
    Expression<String>? parentLineId,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (inventoryLineId != null) 'inventory_line_id': inventoryLineId,
      if (businessId != null) 'business_id': businessId,
      if (lineCode != null) 'line_code': lineCode,
      if (lineName != null) 'line_name': lineName,
      if (lineDescription != null) 'line_description': lineDescription,
      if (linePlacement != null) 'line_placement': linePlacement,
      if (parentLineId != null) 'parent_line_id': parentLineId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryLineCompanion copyWith({
    Value<String>? inventoryLineId,
    Value<String>? businessId,
    Value<String>? lineCode,
    Value<String>? lineName,
    Value<String?>? lineDescription,
    Value<PlacementType>? linePlacement,
    Value<String?>? parentLineId,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return InventoryLineCompanion(
      inventoryLineId: inventoryLineId ?? this.inventoryLineId,
      businessId: businessId ?? this.businessId,
      lineCode: lineCode ?? this.lineCode,
      lineName: lineName ?? this.lineName,
      lineDescription: lineDescription ?? this.lineDescription,
      linePlacement: linePlacement ?? this.linePlacement,
      parentLineId: parentLineId ?? this.parentLineId,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (inventoryLineId.present) {
      map['inventory_line_id'] = Variable<String>(inventoryLineId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (lineCode.present) {
      map['line_code'] = Variable<String>(lineCode.value);
    }
    if (lineName.present) {
      map['line_name'] = Variable<String>(lineName.value);
    }
    if (lineDescription.present) {
      map['line_description'] = Variable<String>(lineDescription.value);
    }
    if (linePlacement.present) {
      map['line_placement'] = Variable<String>(
        $InventoryLineTable.$converterlinePlacement.toSql(linePlacement.value),
      );
    }
    if (parentLineId.present) {
      map['parent_line_id'] = Variable<String>(parentLineId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InventoryLineTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLineCompanion(')
          ..write('inventoryLineId: $inventoryLineId, ')
          ..write('businessId: $businessId, ')
          ..write('lineCode: $lineCode, ')
          ..write('lineName: $lineName, ')
          ..write('lineDescription: $lineDescription, ')
          ..write('linePlacement: $linePlacement, ')
          ..write('parentLineId: $parentLineId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoryTableTable extends cat.CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryCodeMeta = const VerificationMeta(
    'categoryCode',
  );
  @override
  late final GeneratedColumn<String> categoryCode = GeneratedColumn<String>(
    'category_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryDescriptionMeta =
      const VerificationMeta('categoryDescription');
  @override
  late final GeneratedColumn<String> categoryDescription =
      GeneratedColumn<String>(
        'category_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _parentCategoryIdMeta = const VerificationMeta(
    'parentCategoryId',
  );
  @override
  late final GeneratedColumn<String> parentCategoryId = GeneratedColumn<String>(
    'parent_category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryImageUrlMeta = const VerificationMeta(
    'categoryImageUrl',
  );
  @override
  late final GeneratedColumn<String> categoryImageUrl = GeneratedColumn<String>(
    'category_image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seoSlugMeta = const VerificationMeta(
    'seoSlug',
  );
  @override
  late final GeneratedColumn<String> seoSlug = GeneratedColumn<String>(
    'seo_slug',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metaTitleMeta = const VerificationMeta(
    'metaTitle',
  );
  @override
  late final GeneratedColumn<String> metaTitle = GeneratedColumn<String>(
    'meta_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metaDescriptionMeta = const VerificationMeta(
    'metaDescription',
  );
  @override
  late final GeneratedColumn<String> metaDescription = GeneratedColumn<String>(
    'meta_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlacementType, String>
  codePlacement = GeneratedColumn<String>(
    'code_placement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pre'),
  ).withConverter<PlacementType>($CategoryTableTable.$convertercodePlacement);
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _isFeaturedMeta = const VerificationMeta(
    'isFeatured',
  );
  @override
  late final GeneratedColumn<bool> isFeatured = GeneratedColumn<bool>(
    'is_featured',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_featured" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(false),
  );
  static const VerificationMeta _commissionRateMeta = const VerificationMeta(
    'commissionRate',
  );
  @override
  late final GeneratedColumn<double> commissionRate = GeneratedColumn<double>(
    'commission_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($CategoryTableTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    categoryId,
    businessId,
    categoryCode,
    categoryName,
    categoryDescription,
    parentCategoryId,
    categoryImageUrl,
    seoSlug,
    metaTitle,
    metaDescription,
    codePlacement,
    sortOrder,
    isFeatured,
    commissionRate,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('category_code')) {
      context.handle(
        _categoryCodeMeta,
        categoryCode.isAcceptableOrUnknown(
          data['category_code']!,
          _categoryCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryCodeMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('category_description')) {
      context.handle(
        _categoryDescriptionMeta,
        categoryDescription.isAcceptableOrUnknown(
          data['category_description']!,
          _categoryDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('parent_category_id')) {
      context.handle(
        _parentCategoryIdMeta,
        parentCategoryId.isAcceptableOrUnknown(
          data['parent_category_id']!,
          _parentCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('category_image_url')) {
      context.handle(
        _categoryImageUrlMeta,
        categoryImageUrl.isAcceptableOrUnknown(
          data['category_image_url']!,
          _categoryImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('seo_slug')) {
      context.handle(
        _seoSlugMeta,
        seoSlug.isAcceptableOrUnknown(data['seo_slug']!, _seoSlugMeta),
      );
    }
    if (data.containsKey('meta_title')) {
      context.handle(
        _metaTitleMeta,
        metaTitle.isAcceptableOrUnknown(data['meta_title']!, _metaTitleMeta),
      );
    }
    if (data.containsKey('meta_description')) {
      context.handle(
        _metaDescriptionMeta,
        metaDescription.isAcceptableOrUnknown(
          data['meta_description']!,
          _metaDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_featured')) {
      context.handle(
        _isFeaturedMeta,
        isFeatured.isAcceptableOrUnknown(data['is_featured']!, _isFeaturedMeta),
      );
    }
    if (data.containsKey('commission_rate')) {
      context.handle(
        _commissionRateMeta,
        commissionRate.isAcceptableOrUnknown(
          data['commission_rate']!,
          _commissionRateMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {businessId, categoryCode},
    {businessId, seoSlug},
  ];
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      categoryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_code'],
      )!,
      categoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_name'],
      )!,
      categoryDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_description'],
      ),
      parentCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_category_id'],
      ),
      categoryImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_image_url'],
      ),
      seoSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seo_slug'],
      ),
      metaTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meta_title'],
      ),
      metaDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meta_description'],
      ),
      codePlacement: $CategoryTableTable.$convertercodePlacement.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}code_placement'],
        )!,
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isFeatured: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_featured'],
      )!,
      commissionRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_rate'],
      ),
      status: $CategoryTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlacementType, String, String>
  $convertercodePlacement = const EnumNameConverter<PlacementType>(
    PlacementType.values,
  );
  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final String categoryId;
  final String businessId;
  final String categoryCode;
  final String categoryName;
  final String? categoryDescription;
  final String? parentCategoryId;
  final String? categoryImageUrl;
  final String? seoSlug;
  final String? metaTitle;
  final String? metaDescription;
  final PlacementType codePlacement;
  final int sortOrder;
  final bool isFeatured;
  final double? commissionRate;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const CategoryTableData({
    required this.categoryId,
    required this.businessId,
    required this.categoryCode,
    required this.categoryName,
    this.categoryDescription,
    this.parentCategoryId,
    this.categoryImageUrl,
    this.seoSlug,
    this.metaTitle,
    this.metaDescription,
    required this.codePlacement,
    required this.sortOrder,
    required this.isFeatured,
    this.commissionRate,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category_id'] = Variable<String>(categoryId);
    map['business_id'] = Variable<String>(businessId);
    map['category_code'] = Variable<String>(categoryCode);
    map['category_name'] = Variable<String>(categoryName);
    if (!nullToAbsent || categoryDescription != null) {
      map['category_description'] = Variable<String>(categoryDescription);
    }
    if (!nullToAbsent || parentCategoryId != null) {
      map['parent_category_id'] = Variable<String>(parentCategoryId);
    }
    if (!nullToAbsent || categoryImageUrl != null) {
      map['category_image_url'] = Variable<String>(categoryImageUrl);
    }
    if (!nullToAbsent || seoSlug != null) {
      map['seo_slug'] = Variable<String>(seoSlug);
    }
    if (!nullToAbsent || metaTitle != null) {
      map['meta_title'] = Variable<String>(metaTitle);
    }
    if (!nullToAbsent || metaDescription != null) {
      map['meta_description'] = Variable<String>(metaDescription);
    }
    {
      map['code_placement'] = Variable<String>(
        $CategoryTableTable.$convertercodePlacement.toSql(codePlacement),
      );
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_featured'] = Variable<bool>(isFeatured);
    if (!nullToAbsent || commissionRate != null) {
      map['commission_rate'] = Variable<double>(commissionRate);
    }
    {
      map['status'] = Variable<String>(
        $CategoryTableTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      categoryId: Value(categoryId),
      businessId: Value(businessId),
      categoryCode: Value(categoryCode),
      categoryName: Value(categoryName),
      categoryDescription: categoryDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryDescription),
      parentCategoryId: parentCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentCategoryId),
      categoryImageUrl: categoryImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryImageUrl),
      seoSlug: seoSlug == null && nullToAbsent
          ? const Value.absent()
          : Value(seoSlug),
      metaTitle: metaTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(metaTitle),
      metaDescription: metaDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(metaDescription),
      codePlacement: Value(codePlacement),
      sortOrder: Value(sortOrder),
      isFeatured: Value(isFeatured),
      commissionRate: commissionRate == null && nullToAbsent
          ? const Value.absent()
          : Value(commissionRate),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory CategoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      categoryId: serializer.fromJson<String>(json['categoryId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      categoryCode: serializer.fromJson<String>(json['categoryCode']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      categoryDescription: serializer.fromJson<String?>(
        json['categoryDescription'],
      ),
      parentCategoryId: serializer.fromJson<String?>(json['parentCategoryId']),
      categoryImageUrl: serializer.fromJson<String?>(json['categoryImageUrl']),
      seoSlug: serializer.fromJson<String?>(json['seoSlug']),
      metaTitle: serializer.fromJson<String?>(json['metaTitle']),
      metaDescription: serializer.fromJson<String?>(json['metaDescription']),
      codePlacement: $CategoryTableTable.$convertercodePlacement.fromJson(
        serializer.fromJson<String>(json['codePlacement']),
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isFeatured: serializer.fromJson<bool>(json['isFeatured']),
      commissionRate: serializer.fromJson<double?>(json['commissionRate']),
      status: $CategoryTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryId': serializer.toJson<String>(categoryId),
      'businessId': serializer.toJson<String>(businessId),
      'categoryCode': serializer.toJson<String>(categoryCode),
      'categoryName': serializer.toJson<String>(categoryName),
      'categoryDescription': serializer.toJson<String?>(categoryDescription),
      'parentCategoryId': serializer.toJson<String?>(parentCategoryId),
      'categoryImageUrl': serializer.toJson<String?>(categoryImageUrl),
      'seoSlug': serializer.toJson<String?>(seoSlug),
      'metaTitle': serializer.toJson<String?>(metaTitle),
      'metaDescription': serializer.toJson<String?>(metaDescription),
      'codePlacement': serializer.toJson<String>(
        $CategoryTableTable.$convertercodePlacement.toJson(codePlacement),
      ),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isFeatured': serializer.toJson<bool>(isFeatured),
      'commissionRate': serializer.toJson<double?>(commissionRate),
      'status': serializer.toJson<String>(
        $CategoryTableTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  CategoryTableData copyWith({
    String? categoryId,
    String? businessId,
    String? categoryCode,
    String? categoryName,
    Value<String?> categoryDescription = const Value.absent(),
    Value<String?> parentCategoryId = const Value.absent(),
    Value<String?> categoryImageUrl = const Value.absent(),
    Value<String?> seoSlug = const Value.absent(),
    Value<String?> metaTitle = const Value.absent(),
    Value<String?> metaDescription = const Value.absent(),
    PlacementType? codePlacement,
    int? sortOrder,
    bool? isFeatured,
    Value<double?> commissionRate = const Value.absent(),
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => CategoryTableData(
    categoryId: categoryId ?? this.categoryId,
    businessId: businessId ?? this.businessId,
    categoryCode: categoryCode ?? this.categoryCode,
    categoryName: categoryName ?? this.categoryName,
    categoryDescription: categoryDescription.present
        ? categoryDescription.value
        : this.categoryDescription,
    parentCategoryId: parentCategoryId.present
        ? parentCategoryId.value
        : this.parentCategoryId,
    categoryImageUrl: categoryImageUrl.present
        ? categoryImageUrl.value
        : this.categoryImageUrl,
    seoSlug: seoSlug.present ? seoSlug.value : this.seoSlug,
    metaTitle: metaTitle.present ? metaTitle.value : this.metaTitle,
    metaDescription: metaDescription.present
        ? metaDescription.value
        : this.metaDescription,
    codePlacement: codePlacement ?? this.codePlacement,
    sortOrder: sortOrder ?? this.sortOrder,
    isFeatured: isFeatured ?? this.isFeatured,
    commissionRate: commissionRate.present
        ? commissionRate.value
        : this.commissionRate,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  CategoryTableData copyWithCompanion(CategoryTableCompanion data) {
    return CategoryTableData(
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      categoryCode: data.categoryCode.present
          ? data.categoryCode.value
          : this.categoryCode,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      categoryDescription: data.categoryDescription.present
          ? data.categoryDescription.value
          : this.categoryDescription,
      parentCategoryId: data.parentCategoryId.present
          ? data.parentCategoryId.value
          : this.parentCategoryId,
      categoryImageUrl: data.categoryImageUrl.present
          ? data.categoryImageUrl.value
          : this.categoryImageUrl,
      seoSlug: data.seoSlug.present ? data.seoSlug.value : this.seoSlug,
      metaTitle: data.metaTitle.present ? data.metaTitle.value : this.metaTitle,
      metaDescription: data.metaDescription.present
          ? data.metaDescription.value
          : this.metaDescription,
      codePlacement: data.codePlacement.present
          ? data.codePlacement.value
          : this.codePlacement,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isFeatured: data.isFeatured.present
          ? data.isFeatured.value
          : this.isFeatured,
      commissionRate: data.commissionRate.present
          ? data.commissionRate.value
          : this.commissionRate,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('categoryId: $categoryId, ')
          ..write('businessId: $businessId, ')
          ..write('categoryCode: $categoryCode, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryDescription: $categoryDescription, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('categoryImageUrl: $categoryImageUrl, ')
          ..write('seoSlug: $seoSlug, ')
          ..write('metaTitle: $metaTitle, ')
          ..write('metaDescription: $metaDescription, ')
          ..write('codePlacement: $codePlacement, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('commissionRate: $commissionRate, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    categoryId,
    businessId,
    categoryCode,
    categoryName,
    categoryDescription,
    parentCategoryId,
    categoryImageUrl,
    seoSlug,
    metaTitle,
    metaDescription,
    codePlacement,
    sortOrder,
    isFeatured,
    commissionRate,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.categoryId == this.categoryId &&
          other.businessId == this.businessId &&
          other.categoryCode == this.categoryCode &&
          other.categoryName == this.categoryName &&
          other.categoryDescription == this.categoryDescription &&
          other.parentCategoryId == this.parentCategoryId &&
          other.categoryImageUrl == this.categoryImageUrl &&
          other.seoSlug == this.seoSlug &&
          other.metaTitle == this.metaTitle &&
          other.metaDescription == this.metaDescription &&
          other.codePlacement == this.codePlacement &&
          other.sortOrder == this.sortOrder &&
          other.isFeatured == this.isFeatured &&
          other.commissionRate == this.commissionRate &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<String> categoryId;
  final Value<String> businessId;
  final Value<String> categoryCode;
  final Value<String> categoryName;
  final Value<String?> categoryDescription;
  final Value<String?> parentCategoryId;
  final Value<String?> categoryImageUrl;
  final Value<String?> seoSlug;
  final Value<String?> metaTitle;
  final Value<String?> metaDescription;
  final Value<PlacementType> codePlacement;
  final Value<int> sortOrder;
  final Value<bool> isFeatured;
  final Value<double?> commissionRate;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const CategoryTableCompanion({
    this.categoryId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.categoryCode = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryDescription = const Value.absent(),
    this.parentCategoryId = const Value.absent(),
    this.categoryImageUrl = const Value.absent(),
    this.seoSlug = const Value.absent(),
    this.metaTitle = const Value.absent(),
    this.metaDescription = const Value.absent(),
    this.codePlacement = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.commissionRate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    required String categoryId,
    required String businessId,
    required String categoryCode,
    required String categoryName,
    this.categoryDescription = const Value.absent(),
    this.parentCategoryId = const Value.absent(),
    this.categoryImageUrl = const Value.absent(),
    this.seoSlug = const Value.absent(),
    this.metaTitle = const Value.absent(),
    this.metaDescription = const Value.absent(),
    this.codePlacement = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.commissionRate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : categoryId = Value(categoryId),
       businessId = Value(businessId),
       categoryCode = Value(categoryCode),
       categoryName = Value(categoryName);
  static Insertable<CategoryTableData> custom({
    Expression<String>? categoryId,
    Expression<String>? businessId,
    Expression<String>? categoryCode,
    Expression<String>? categoryName,
    Expression<String>? categoryDescription,
    Expression<String>? parentCategoryId,
    Expression<String>? categoryImageUrl,
    Expression<String>? seoSlug,
    Expression<String>? metaTitle,
    Expression<String>? metaDescription,
    Expression<String>? codePlacement,
    Expression<int>? sortOrder,
    Expression<bool>? isFeatured,
    Expression<double>? commissionRate,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (businessId != null) 'business_id': businessId,
      if (categoryCode != null) 'category_code': categoryCode,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryDescription != null)
        'category_description': categoryDescription,
      if (parentCategoryId != null) 'parent_category_id': parentCategoryId,
      if (categoryImageUrl != null) 'category_image_url': categoryImageUrl,
      if (seoSlug != null) 'seo_slug': seoSlug,
      if (metaTitle != null) 'meta_title': metaTitle,
      if (metaDescription != null) 'meta_description': metaDescription,
      if (codePlacement != null) 'code_placement': codePlacement,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isFeatured != null) 'is_featured': isFeatured,
      if (commissionRate != null) 'commission_rate': commissionRate,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryTableCompanion copyWith({
    Value<String>? categoryId,
    Value<String>? businessId,
    Value<String>? categoryCode,
    Value<String>? categoryName,
    Value<String?>? categoryDescription,
    Value<String?>? parentCategoryId,
    Value<String?>? categoryImageUrl,
    Value<String?>? seoSlug,
    Value<String?>? metaTitle,
    Value<String?>? metaDescription,
    Value<PlacementType>? codePlacement,
    Value<int>? sortOrder,
    Value<bool>? isFeatured,
    Value<double?>? commissionRate,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return CategoryTableCompanion(
      categoryId: categoryId ?? this.categoryId,
      businessId: businessId ?? this.businessId,
      categoryCode: categoryCode ?? this.categoryCode,
      categoryName: categoryName ?? this.categoryName,
      categoryDescription: categoryDescription ?? this.categoryDescription,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
      seoSlug: seoSlug ?? this.seoSlug,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      codePlacement: codePlacement ?? this.codePlacement,
      sortOrder: sortOrder ?? this.sortOrder,
      isFeatured: isFeatured ?? this.isFeatured,
      commissionRate: commissionRate ?? this.commissionRate,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (categoryCode.present) {
      map['category_code'] = Variable<String>(categoryCode.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryDescription.present) {
      map['category_description'] = Variable<String>(categoryDescription.value);
    }
    if (parentCategoryId.present) {
      map['parent_category_id'] = Variable<String>(parentCategoryId.value);
    }
    if (categoryImageUrl.present) {
      map['category_image_url'] = Variable<String>(categoryImageUrl.value);
    }
    if (seoSlug.present) {
      map['seo_slug'] = Variable<String>(seoSlug.value);
    }
    if (metaTitle.present) {
      map['meta_title'] = Variable<String>(metaTitle.value);
    }
    if (metaDescription.present) {
      map['meta_description'] = Variable<String>(metaDescription.value);
    }
    if (codePlacement.present) {
      map['code_placement'] = Variable<String>(
        $CategoryTableTable.$convertercodePlacement.toSql(codePlacement.value),
      );
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isFeatured.present) {
      map['is_featured'] = Variable<bool>(isFeatured.value);
    }
    if (commissionRate.present) {
      map['commission_rate'] = Variable<double>(commissionRate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $CategoryTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('businessId: $businessId, ')
          ..write('categoryCode: $categoryCode, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryDescription: $categoryDescription, ')
          ..write('parentCategoryId: $parentCategoryId, ')
          ..write('categoryImageUrl: $categoryImageUrl, ')
          ..write('seoSlug: $seoSlug, ')
          ..write('metaTitle: $metaTitle, ')
          ..write('metaDescription: $metaDescription, ')
          ..write('codePlacement: $codePlacement, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('commissionRate: $commissionRate, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubCategoryTable extends SubCategory
    with TableInfo<$SubCategoryTable, SubCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubCategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _subCategoryIdMeta = const VerificationMeta(
    'subCategoryId',
  );
  @override
  late final GeneratedColumn<String> subCategoryId = GeneratedColumn<String>(
    'sub_category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subCategoryCodeMeta = const VerificationMeta(
    'subCategoryCode',
  );
  @override
  late final GeneratedColumn<String> subCategoryCode = GeneratedColumn<String>(
    'sub_category_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subCategoryNameMeta = const VerificationMeta(
    'subCategoryName',
  );
  @override
  late final GeneratedColumn<String> subCategoryName = GeneratedColumn<String>(
    'sub_category_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subCategoryDescriptionMeta =
      const VerificationMeta('subCategoryDescription');
  @override
  late final GeneratedColumn<String> subCategoryDescription =
      GeneratedColumn<String>(
        'sub_category_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<PlacementType, String>
  codePlacement = GeneratedColumn<String>(
    'code_placement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pre'),
  ).withConverter<PlacementType>($SubCategoryTable.$convertercodePlacement);
  static const VerificationMeta _counterMeta = const VerificationMeta(
    'counter',
  );
  @override
  late final GeneratedColumn<int> counter = GeneratedColumn<int>(
    'counter',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _subCategoryImageUrlMeta =
      const VerificationMeta('subCategoryImageUrl');
  @override
  late final GeneratedColumn<String> subCategoryImageUrl =
      GeneratedColumn<String>(
        'sub_category_image_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sizeChartUrlMeta = const VerificationMeta(
    'sizeChartUrl',
  );
  @override
  late final GeneratedColumn<String> sizeChartUrl = GeneratedColumn<String>(
    'size_chart_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _careInstructionsMeta = const VerificationMeta(
    'careInstructions',
  );
  @override
  late final GeneratedColumn<String> careInstructions = GeneratedColumn<String>(
    'care_instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($SubCategoryTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    subCategoryId,
    categoryId,
    businessId,
    subCategoryCode,
    subCategoryName,
    subCategoryDescription,
    codePlacement,
    counter,
    sortOrder,
    subCategoryImageUrl,
    sizeChartUrl,
    careInstructions,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sub_category';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubCategoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sub_category_id')) {
      context.handle(
        _subCategoryIdMeta,
        subCategoryId.isAcceptableOrUnknown(
          data['sub_category_id']!,
          _subCategoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subCategoryIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('sub_category_code')) {
      context.handle(
        _subCategoryCodeMeta,
        subCategoryCode.isAcceptableOrUnknown(
          data['sub_category_code']!,
          _subCategoryCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subCategoryCodeMeta);
    }
    if (data.containsKey('sub_category_name')) {
      context.handle(
        _subCategoryNameMeta,
        subCategoryName.isAcceptableOrUnknown(
          data['sub_category_name']!,
          _subCategoryNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subCategoryNameMeta);
    }
    if (data.containsKey('sub_category_description')) {
      context.handle(
        _subCategoryDescriptionMeta,
        subCategoryDescription.isAcceptableOrUnknown(
          data['sub_category_description']!,
          _subCategoryDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('counter')) {
      context.handle(
        _counterMeta,
        counter.isAcceptableOrUnknown(data['counter']!, _counterMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('sub_category_image_url')) {
      context.handle(
        _subCategoryImageUrlMeta,
        subCategoryImageUrl.isAcceptableOrUnknown(
          data['sub_category_image_url']!,
          _subCategoryImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('size_chart_url')) {
      context.handle(
        _sizeChartUrlMeta,
        sizeChartUrl.isAcceptableOrUnknown(
          data['size_chart_url']!,
          _sizeChartUrlMeta,
        ),
      );
    }
    if (data.containsKey('care_instructions')) {
      context.handle(
        _careInstructionsMeta,
        careInstructions.isAcceptableOrUnknown(
          data['care_instructions']!,
          _careInstructionsMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {subCategoryId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {categoryId, subCategoryCode},
  ];
  @override
  SubCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubCategoryData(
      subCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_category_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      subCategoryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_category_code'],
      )!,
      subCategoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_category_name'],
      )!,
      subCategoryDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_category_description'],
      ),
      codePlacement: $SubCategoryTable.$convertercodePlacement.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}code_placement'],
        )!,
      ),
      counter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}counter'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      subCategoryImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_category_image_url'],
      ),
      sizeChartUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_chart_url'],
      ),
      careInstructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}care_instructions'],
      ),
      status: $SubCategoryTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $SubCategoryTable createAlias(String alias) {
    return $SubCategoryTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlacementType, String, String>
  $convertercodePlacement = const EnumNameConverter<PlacementType>(
    PlacementType.values,
  );
  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class SubCategoryData extends DataClass implements Insertable<SubCategoryData> {
  final String subCategoryId;
  final String categoryId;
  final String businessId;
  final String subCategoryCode;
  final String subCategoryName;
  final String? subCategoryDescription;
  final PlacementType codePlacement;
  final int? counter;
  final int sortOrder;
  final String? subCategoryImageUrl;
  final String? sizeChartUrl;
  final String? careInstructions;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const SubCategoryData({
    required this.subCategoryId,
    required this.categoryId,
    required this.businessId,
    required this.subCategoryCode,
    required this.subCategoryName,
    this.subCategoryDescription,
    required this.codePlacement,
    this.counter,
    required this.sortOrder,
    this.subCategoryImageUrl,
    this.sizeChartUrl,
    this.careInstructions,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sub_category_id'] = Variable<String>(subCategoryId);
    map['category_id'] = Variable<String>(categoryId);
    map['business_id'] = Variable<String>(businessId);
    map['sub_category_code'] = Variable<String>(subCategoryCode);
    map['sub_category_name'] = Variable<String>(subCategoryName);
    if (!nullToAbsent || subCategoryDescription != null) {
      map['sub_category_description'] = Variable<String>(
        subCategoryDescription,
      );
    }
    {
      map['code_placement'] = Variable<String>(
        $SubCategoryTable.$convertercodePlacement.toSql(codePlacement),
      );
    }
    if (!nullToAbsent || counter != null) {
      map['counter'] = Variable<int>(counter);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || subCategoryImageUrl != null) {
      map['sub_category_image_url'] = Variable<String>(subCategoryImageUrl);
    }
    if (!nullToAbsent || sizeChartUrl != null) {
      map['size_chart_url'] = Variable<String>(sizeChartUrl);
    }
    if (!nullToAbsent || careInstructions != null) {
      map['care_instructions'] = Variable<String>(careInstructions);
    }
    {
      map['status'] = Variable<String>(
        $SubCategoryTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  SubCategoryCompanion toCompanion(bool nullToAbsent) {
    return SubCategoryCompanion(
      subCategoryId: Value(subCategoryId),
      categoryId: Value(categoryId),
      businessId: Value(businessId),
      subCategoryCode: Value(subCategoryCode),
      subCategoryName: Value(subCategoryName),
      subCategoryDescription: subCategoryDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(subCategoryDescription),
      codePlacement: Value(codePlacement),
      counter: counter == null && nullToAbsent
          ? const Value.absent()
          : Value(counter),
      sortOrder: Value(sortOrder),
      subCategoryImageUrl: subCategoryImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(subCategoryImageUrl),
      sizeChartUrl: sizeChartUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeChartUrl),
      careInstructions: careInstructions == null && nullToAbsent
          ? const Value.absent()
          : Value(careInstructions),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory SubCategoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubCategoryData(
      subCategoryId: serializer.fromJson<String>(json['subCategoryId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      subCategoryCode: serializer.fromJson<String>(json['subCategoryCode']),
      subCategoryName: serializer.fromJson<String>(json['subCategoryName']),
      subCategoryDescription: serializer.fromJson<String?>(
        json['subCategoryDescription'],
      ),
      codePlacement: $SubCategoryTable.$convertercodePlacement.fromJson(
        serializer.fromJson<String>(json['codePlacement']),
      ),
      counter: serializer.fromJson<int?>(json['counter']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      subCategoryImageUrl: serializer.fromJson<String?>(
        json['subCategoryImageUrl'],
      ),
      sizeChartUrl: serializer.fromJson<String?>(json['sizeChartUrl']),
      careInstructions: serializer.fromJson<String?>(json['careInstructions']),
      status: $SubCategoryTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'subCategoryId': serializer.toJson<String>(subCategoryId),
      'categoryId': serializer.toJson<String>(categoryId),
      'businessId': serializer.toJson<String>(businessId),
      'subCategoryCode': serializer.toJson<String>(subCategoryCode),
      'subCategoryName': serializer.toJson<String>(subCategoryName),
      'subCategoryDescription': serializer.toJson<String?>(
        subCategoryDescription,
      ),
      'codePlacement': serializer.toJson<String>(
        $SubCategoryTable.$convertercodePlacement.toJson(codePlacement),
      ),
      'counter': serializer.toJson<int?>(counter),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'subCategoryImageUrl': serializer.toJson<String?>(subCategoryImageUrl),
      'sizeChartUrl': serializer.toJson<String?>(sizeChartUrl),
      'careInstructions': serializer.toJson<String?>(careInstructions),
      'status': serializer.toJson<String>(
        $SubCategoryTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  SubCategoryData copyWith({
    String? subCategoryId,
    String? categoryId,
    String? businessId,
    String? subCategoryCode,
    String? subCategoryName,
    Value<String?> subCategoryDescription = const Value.absent(),
    PlacementType? codePlacement,
    Value<int?> counter = const Value.absent(),
    int? sortOrder,
    Value<String?> subCategoryImageUrl = const Value.absent(),
    Value<String?> sizeChartUrl = const Value.absent(),
    Value<String?> careInstructions = const Value.absent(),
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => SubCategoryData(
    subCategoryId: subCategoryId ?? this.subCategoryId,
    categoryId: categoryId ?? this.categoryId,
    businessId: businessId ?? this.businessId,
    subCategoryCode: subCategoryCode ?? this.subCategoryCode,
    subCategoryName: subCategoryName ?? this.subCategoryName,
    subCategoryDescription: subCategoryDescription.present
        ? subCategoryDescription.value
        : this.subCategoryDescription,
    codePlacement: codePlacement ?? this.codePlacement,
    counter: counter.present ? counter.value : this.counter,
    sortOrder: sortOrder ?? this.sortOrder,
    subCategoryImageUrl: subCategoryImageUrl.present
        ? subCategoryImageUrl.value
        : this.subCategoryImageUrl,
    sizeChartUrl: sizeChartUrl.present ? sizeChartUrl.value : this.sizeChartUrl,
    careInstructions: careInstructions.present
        ? careInstructions.value
        : this.careInstructions,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  SubCategoryData copyWithCompanion(SubCategoryCompanion data) {
    return SubCategoryData(
      subCategoryId: data.subCategoryId.present
          ? data.subCategoryId.value
          : this.subCategoryId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      subCategoryCode: data.subCategoryCode.present
          ? data.subCategoryCode.value
          : this.subCategoryCode,
      subCategoryName: data.subCategoryName.present
          ? data.subCategoryName.value
          : this.subCategoryName,
      subCategoryDescription: data.subCategoryDescription.present
          ? data.subCategoryDescription.value
          : this.subCategoryDescription,
      codePlacement: data.codePlacement.present
          ? data.codePlacement.value
          : this.codePlacement,
      counter: data.counter.present ? data.counter.value : this.counter,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      subCategoryImageUrl: data.subCategoryImageUrl.present
          ? data.subCategoryImageUrl.value
          : this.subCategoryImageUrl,
      sizeChartUrl: data.sizeChartUrl.present
          ? data.sizeChartUrl.value
          : this.sizeChartUrl,
      careInstructions: data.careInstructions.present
          ? data.careInstructions.value
          : this.careInstructions,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubCategoryData(')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('categoryId: $categoryId, ')
          ..write('businessId: $businessId, ')
          ..write('subCategoryCode: $subCategoryCode, ')
          ..write('subCategoryName: $subCategoryName, ')
          ..write('subCategoryDescription: $subCategoryDescription, ')
          ..write('codePlacement: $codePlacement, ')
          ..write('counter: $counter, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('subCategoryImageUrl: $subCategoryImageUrl, ')
          ..write('sizeChartUrl: $sizeChartUrl, ')
          ..write('careInstructions: $careInstructions, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    subCategoryId,
    categoryId,
    businessId,
    subCategoryCode,
    subCategoryName,
    subCategoryDescription,
    codePlacement,
    counter,
    sortOrder,
    subCategoryImageUrl,
    sizeChartUrl,
    careInstructions,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubCategoryData &&
          other.subCategoryId == this.subCategoryId &&
          other.categoryId == this.categoryId &&
          other.businessId == this.businessId &&
          other.subCategoryCode == this.subCategoryCode &&
          other.subCategoryName == this.subCategoryName &&
          other.subCategoryDescription == this.subCategoryDescription &&
          other.codePlacement == this.codePlacement &&
          other.counter == this.counter &&
          other.sortOrder == this.sortOrder &&
          other.subCategoryImageUrl == this.subCategoryImageUrl &&
          other.sizeChartUrl == this.sizeChartUrl &&
          other.careInstructions == this.careInstructions &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class SubCategoryCompanion extends UpdateCompanion<SubCategoryData> {
  final Value<String> subCategoryId;
  final Value<String> categoryId;
  final Value<String> businessId;
  final Value<String> subCategoryCode;
  final Value<String> subCategoryName;
  final Value<String?> subCategoryDescription;
  final Value<PlacementType> codePlacement;
  final Value<int?> counter;
  final Value<int> sortOrder;
  final Value<String?> subCategoryImageUrl;
  final Value<String?> sizeChartUrl;
  final Value<String?> careInstructions;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const SubCategoryCompanion({
    this.subCategoryId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.subCategoryCode = const Value.absent(),
    this.subCategoryName = const Value.absent(),
    this.subCategoryDescription = const Value.absent(),
    this.codePlacement = const Value.absent(),
    this.counter = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.subCategoryImageUrl = const Value.absent(),
    this.sizeChartUrl = const Value.absent(),
    this.careInstructions = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubCategoryCompanion.insert({
    required String subCategoryId,
    required String categoryId,
    required String businessId,
    required String subCategoryCode,
    required String subCategoryName,
    this.subCategoryDescription = const Value.absent(),
    this.codePlacement = const Value.absent(),
    this.counter = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.subCategoryImageUrl = const Value.absent(),
    this.sizeChartUrl = const Value.absent(),
    this.careInstructions = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : subCategoryId = Value(subCategoryId),
       categoryId = Value(categoryId),
       businessId = Value(businessId),
       subCategoryCode = Value(subCategoryCode),
       subCategoryName = Value(subCategoryName);
  static Insertable<SubCategoryData> custom({
    Expression<String>? subCategoryId,
    Expression<String>? categoryId,
    Expression<String>? businessId,
    Expression<String>? subCategoryCode,
    Expression<String>? subCategoryName,
    Expression<String>? subCategoryDescription,
    Expression<String>? codePlacement,
    Expression<int>? counter,
    Expression<int>? sortOrder,
    Expression<String>? subCategoryImageUrl,
    Expression<String>? sizeChartUrl,
    Expression<String>? careInstructions,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (subCategoryId != null) 'sub_category_id': subCategoryId,
      if (categoryId != null) 'category_id': categoryId,
      if (businessId != null) 'business_id': businessId,
      if (subCategoryCode != null) 'sub_category_code': subCategoryCode,
      if (subCategoryName != null) 'sub_category_name': subCategoryName,
      if (subCategoryDescription != null)
        'sub_category_description': subCategoryDescription,
      if (codePlacement != null) 'code_placement': codePlacement,
      if (counter != null) 'counter': counter,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (subCategoryImageUrl != null)
        'sub_category_image_url': subCategoryImageUrl,
      if (sizeChartUrl != null) 'size_chart_url': sizeChartUrl,
      if (careInstructions != null) 'care_instructions': careInstructions,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubCategoryCompanion copyWith({
    Value<String>? subCategoryId,
    Value<String>? categoryId,
    Value<String>? businessId,
    Value<String>? subCategoryCode,
    Value<String>? subCategoryName,
    Value<String?>? subCategoryDescription,
    Value<PlacementType>? codePlacement,
    Value<int?>? counter,
    Value<int>? sortOrder,
    Value<String?>? subCategoryImageUrl,
    Value<String?>? sizeChartUrl,
    Value<String?>? careInstructions,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return SubCategoryCompanion(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      categoryId: categoryId ?? this.categoryId,
      businessId: businessId ?? this.businessId,
      subCategoryCode: subCategoryCode ?? this.subCategoryCode,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      subCategoryDescription:
          subCategoryDescription ?? this.subCategoryDescription,
      codePlacement: codePlacement ?? this.codePlacement,
      counter: counter ?? this.counter,
      sortOrder: sortOrder ?? this.sortOrder,
      subCategoryImageUrl: subCategoryImageUrl ?? this.subCategoryImageUrl,
      sizeChartUrl: sizeChartUrl ?? this.sizeChartUrl,
      careInstructions: careInstructions ?? this.careInstructions,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (subCategoryId.present) {
      map['sub_category_id'] = Variable<String>(subCategoryId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (subCategoryCode.present) {
      map['sub_category_code'] = Variable<String>(subCategoryCode.value);
    }
    if (subCategoryName.present) {
      map['sub_category_name'] = Variable<String>(subCategoryName.value);
    }
    if (subCategoryDescription.present) {
      map['sub_category_description'] = Variable<String>(
        subCategoryDescription.value,
      );
    }
    if (codePlacement.present) {
      map['code_placement'] = Variable<String>(
        $SubCategoryTable.$convertercodePlacement.toSql(codePlacement.value),
      );
    }
    if (counter.present) {
      map['counter'] = Variable<int>(counter.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (subCategoryImageUrl.present) {
      map['sub_category_image_url'] = Variable<String>(
        subCategoryImageUrl.value,
      );
    }
    if (sizeChartUrl.present) {
      map['size_chart_url'] = Variable<String>(sizeChartUrl.value);
    }
    if (careInstructions.present) {
      map['care_instructions'] = Variable<String>(careInstructions.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SubCategoryTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubCategoryCompanion(')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('categoryId: $categoryId, ')
          ..write('businessId: $businessId, ')
          ..write('subCategoryCode: $subCategoryCode, ')
          ..write('subCategoryName: $subCategoryName, ')
          ..write('subCategoryDescription: $subCategoryDescription, ')
          ..write('codePlacement: $codePlacement, ')
          ..write('counter: $counter, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('subCategoryImageUrl: $subCategoryImageUrl, ')
          ..write('sizeChartUrl: $sizeChartUrl, ')
          ..write('careInstructions: $careInstructions, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryColorsTable extends InventoryColors
    with TableInfo<$InventoryColorsTable, InventoryColor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryColorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _colorIdMeta = const VerificationMeta(
    'colorId',
  );
  @override
  late final GeneratedColumn<String> colorId = GeneratedColumn<String>(
    'color_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorNameMeta = const VerificationMeta(
    'colorName',
  );
  @override
  late final GeneratedColumn<String> colorName = GeneratedColumn<String>(
    'color_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorCodeMeta = const VerificationMeta(
    'colorCode',
  );
  @override
  late final GeneratedColumn<String> colorCode = GeneratedColumn<String>(
    'color_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hexColorMeta = const VerificationMeta(
    'hexColor',
  );
  @override
  late final GeneratedColumn<String> hexColor = GeneratedColumn<String>(
    'hex_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rgbColorMeta = const VerificationMeta(
    'rgbColor',
  );
  @override
  late final GeneratedColumn<String> rgbColor = GeneratedColumn<String>(
    'rgb_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pantoneCodeMeta = const VerificationMeta(
    'pantoneCode',
  );
  @override
  late final GeneratedColumn<String> pantoneCode = GeneratedColumn<String>(
    'pantone_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierColorCodeMeta = const VerificationMeta(
    'supplierColorCode',
  );
  @override
  late final GeneratedColumn<String> supplierColorCode =
      GeneratedColumn<String>(
        'supplier_color_code',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _colorFamilyMeta = const VerificationMeta(
    'colorFamily',
  );
  @override
  late final GeneratedColumn<String> colorFamily = GeneratedColumn<String>(
    'color_family',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSeasonalMeta = const VerificationMeta(
    'isSeasonal',
  );
  @override
  late final GeneratedColumn<bool> isSeasonal = GeneratedColumn<bool>(
    'is_seasonal',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_seasonal" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(false),
  );
  static const VerificationMeta _seasonIdsMeta = const VerificationMeta(
    'seasonIds',
  );
  @override
  late final GeneratedColumn<String> seasonIds = GeneratedColumn<String>(
    'season_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _colorImageUrlMeta = const VerificationMeta(
    'colorImageUrl',
  );
  @override
  late final GeneratedColumn<String> colorImageUrl = GeneratedColumn<String>(
    'color_image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($InventoryColorsTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    colorId,
    businessId,
    colorName,
    colorCode,
    hexColor,
    rgbColor,
    pantoneCode,
    supplierColorCode,
    colorFamily,
    isSeasonal,
    seasonIds,
    displayOrder,
    colorImageUrl,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_colors';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryColor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('color_id')) {
      context.handle(
        _colorIdMeta,
        colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_colorIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('color_name')) {
      context.handle(
        _colorNameMeta,
        colorName.isAcceptableOrUnknown(data['color_name']!, _colorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_colorNameMeta);
    }
    if (data.containsKey('color_code')) {
      context.handle(
        _colorCodeMeta,
        colorCode.isAcceptableOrUnknown(data['color_code']!, _colorCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_colorCodeMeta);
    }
    if (data.containsKey('hex_color')) {
      context.handle(
        _hexColorMeta,
        hexColor.isAcceptableOrUnknown(data['hex_color']!, _hexColorMeta),
      );
    }
    if (data.containsKey('rgb_color')) {
      context.handle(
        _rgbColorMeta,
        rgbColor.isAcceptableOrUnknown(data['rgb_color']!, _rgbColorMeta),
      );
    }
    if (data.containsKey('pantone_code')) {
      context.handle(
        _pantoneCodeMeta,
        pantoneCode.isAcceptableOrUnknown(
          data['pantone_code']!,
          _pantoneCodeMeta,
        ),
      );
    }
    if (data.containsKey('supplier_color_code')) {
      context.handle(
        _supplierColorCodeMeta,
        supplierColorCode.isAcceptableOrUnknown(
          data['supplier_color_code']!,
          _supplierColorCodeMeta,
        ),
      );
    }
    if (data.containsKey('color_family')) {
      context.handle(
        _colorFamilyMeta,
        colorFamily.isAcceptableOrUnknown(
          data['color_family']!,
          _colorFamilyMeta,
        ),
      );
    }
    if (data.containsKey('is_seasonal')) {
      context.handle(
        _isSeasonalMeta,
        isSeasonal.isAcceptableOrUnknown(data['is_seasonal']!, _isSeasonalMeta),
      );
    }
    if (data.containsKey('season_ids')) {
      context.handle(
        _seasonIdsMeta,
        seasonIds.isAcceptableOrUnknown(data['season_ids']!, _seasonIdsMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('color_image_url')) {
      context.handle(
        _colorImageUrlMeta,
        colorImageUrl.isAcceptableOrUnknown(
          data['color_image_url']!,
          _colorImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {colorId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {businessId, colorCode},
  ];
  @override
  InventoryColor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryColor(
      colorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      colorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_name'],
      )!,
      colorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_code'],
      )!,
      hexColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hex_color'],
      ),
      rgbColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rgb_color'],
      ),
      pantoneCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pantone_code'],
      ),
      supplierColorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_color_code'],
      ),
      colorFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_family'],
      ),
      isSeasonal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_seasonal'],
      )!,
      seasonIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_ids'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      colorImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_image_url'],
      ),
      status: $InventoryColorsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $InventoryColorsTable createAlias(String alias) {
    return $InventoryColorsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class InventoryColor extends DataClass implements Insertable<InventoryColor> {
  final String colorId;
  final String businessId;
  final String colorName;
  final String colorCode;
  final String? hexColor;
  final String? rgbColor;
  final String? pantoneCode;
  final String? supplierColorCode;
  final String? colorFamily;
  final bool isSeasonal;
  final String? seasonIds;
  final int displayOrder;
  final String? colorImageUrl;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const InventoryColor({
    required this.colorId,
    required this.businessId,
    required this.colorName,
    required this.colorCode,
    this.hexColor,
    this.rgbColor,
    this.pantoneCode,
    this.supplierColorCode,
    this.colorFamily,
    required this.isSeasonal,
    this.seasonIds,
    required this.displayOrder,
    this.colorImageUrl,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['color_id'] = Variable<String>(colorId);
    map['business_id'] = Variable<String>(businessId);
    map['color_name'] = Variable<String>(colorName);
    map['color_code'] = Variable<String>(colorCode);
    if (!nullToAbsent || hexColor != null) {
      map['hex_color'] = Variable<String>(hexColor);
    }
    if (!nullToAbsent || rgbColor != null) {
      map['rgb_color'] = Variable<String>(rgbColor);
    }
    if (!nullToAbsent || pantoneCode != null) {
      map['pantone_code'] = Variable<String>(pantoneCode);
    }
    if (!nullToAbsent || supplierColorCode != null) {
      map['supplier_color_code'] = Variable<String>(supplierColorCode);
    }
    if (!nullToAbsent || colorFamily != null) {
      map['color_family'] = Variable<String>(colorFamily);
    }
    map['is_seasonal'] = Variable<bool>(isSeasonal);
    if (!nullToAbsent || seasonIds != null) {
      map['season_ids'] = Variable<String>(seasonIds);
    }
    map['display_order'] = Variable<int>(displayOrder);
    if (!nullToAbsent || colorImageUrl != null) {
      map['color_image_url'] = Variable<String>(colorImageUrl);
    }
    {
      map['status'] = Variable<String>(
        $InventoryColorsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  InventoryColorsCompanion toCompanion(bool nullToAbsent) {
    return InventoryColorsCompanion(
      colorId: Value(colorId),
      businessId: Value(businessId),
      colorName: Value(colorName),
      colorCode: Value(colorCode),
      hexColor: hexColor == null && nullToAbsent
          ? const Value.absent()
          : Value(hexColor),
      rgbColor: rgbColor == null && nullToAbsent
          ? const Value.absent()
          : Value(rgbColor),
      pantoneCode: pantoneCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pantoneCode),
      supplierColorCode: supplierColorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierColorCode),
      colorFamily: colorFamily == null && nullToAbsent
          ? const Value.absent()
          : Value(colorFamily),
      isSeasonal: Value(isSeasonal),
      seasonIds: seasonIds == null && nullToAbsent
          ? const Value.absent()
          : Value(seasonIds),
      displayOrder: Value(displayOrder),
      colorImageUrl: colorImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(colorImageUrl),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory InventoryColor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryColor(
      colorId: serializer.fromJson<String>(json['colorId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      colorName: serializer.fromJson<String>(json['colorName']),
      colorCode: serializer.fromJson<String>(json['colorCode']),
      hexColor: serializer.fromJson<String?>(json['hexColor']),
      rgbColor: serializer.fromJson<String?>(json['rgbColor']),
      pantoneCode: serializer.fromJson<String?>(json['pantoneCode']),
      supplierColorCode: serializer.fromJson<String?>(
        json['supplierColorCode'],
      ),
      colorFamily: serializer.fromJson<String?>(json['colorFamily']),
      isSeasonal: serializer.fromJson<bool>(json['isSeasonal']),
      seasonIds: serializer.fromJson<String?>(json['seasonIds']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      colorImageUrl: serializer.fromJson<String?>(json['colorImageUrl']),
      status: $InventoryColorsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'colorId': serializer.toJson<String>(colorId),
      'businessId': serializer.toJson<String>(businessId),
      'colorName': serializer.toJson<String>(colorName),
      'colorCode': serializer.toJson<String>(colorCode),
      'hexColor': serializer.toJson<String?>(hexColor),
      'rgbColor': serializer.toJson<String?>(rgbColor),
      'pantoneCode': serializer.toJson<String?>(pantoneCode),
      'supplierColorCode': serializer.toJson<String?>(supplierColorCode),
      'colorFamily': serializer.toJson<String?>(colorFamily),
      'isSeasonal': serializer.toJson<bool>(isSeasonal),
      'seasonIds': serializer.toJson<String?>(seasonIds),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'colorImageUrl': serializer.toJson<String?>(colorImageUrl),
      'status': serializer.toJson<String>(
        $InventoryColorsTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  InventoryColor copyWith({
    String? colorId,
    String? businessId,
    String? colorName,
    String? colorCode,
    Value<String?> hexColor = const Value.absent(),
    Value<String?> rgbColor = const Value.absent(),
    Value<String?> pantoneCode = const Value.absent(),
    Value<String?> supplierColorCode = const Value.absent(),
    Value<String?> colorFamily = const Value.absent(),
    bool? isSeasonal,
    Value<String?> seasonIds = const Value.absent(),
    int? displayOrder,
    Value<String?> colorImageUrl = const Value.absent(),
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => InventoryColor(
    colorId: colorId ?? this.colorId,
    businessId: businessId ?? this.businessId,
    colorName: colorName ?? this.colorName,
    colorCode: colorCode ?? this.colorCode,
    hexColor: hexColor.present ? hexColor.value : this.hexColor,
    rgbColor: rgbColor.present ? rgbColor.value : this.rgbColor,
    pantoneCode: pantoneCode.present ? pantoneCode.value : this.pantoneCode,
    supplierColorCode: supplierColorCode.present
        ? supplierColorCode.value
        : this.supplierColorCode,
    colorFamily: colorFamily.present ? colorFamily.value : this.colorFamily,
    isSeasonal: isSeasonal ?? this.isSeasonal,
    seasonIds: seasonIds.present ? seasonIds.value : this.seasonIds,
    displayOrder: displayOrder ?? this.displayOrder,
    colorImageUrl: colorImageUrl.present
        ? colorImageUrl.value
        : this.colorImageUrl,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  InventoryColor copyWithCompanion(InventoryColorsCompanion data) {
    return InventoryColor(
      colorId: data.colorId.present ? data.colorId.value : this.colorId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      colorName: data.colorName.present ? data.colorName.value : this.colorName,
      colorCode: data.colorCode.present ? data.colorCode.value : this.colorCode,
      hexColor: data.hexColor.present ? data.hexColor.value : this.hexColor,
      rgbColor: data.rgbColor.present ? data.rgbColor.value : this.rgbColor,
      pantoneCode: data.pantoneCode.present
          ? data.pantoneCode.value
          : this.pantoneCode,
      supplierColorCode: data.supplierColorCode.present
          ? data.supplierColorCode.value
          : this.supplierColorCode,
      colorFamily: data.colorFamily.present
          ? data.colorFamily.value
          : this.colorFamily,
      isSeasonal: data.isSeasonal.present
          ? data.isSeasonal.value
          : this.isSeasonal,
      seasonIds: data.seasonIds.present ? data.seasonIds.value : this.seasonIds,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      colorImageUrl: data.colorImageUrl.present
          ? data.colorImageUrl.value
          : this.colorImageUrl,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryColor(')
          ..write('colorId: $colorId, ')
          ..write('businessId: $businessId, ')
          ..write('colorName: $colorName, ')
          ..write('colorCode: $colorCode, ')
          ..write('hexColor: $hexColor, ')
          ..write('rgbColor: $rgbColor, ')
          ..write('pantoneCode: $pantoneCode, ')
          ..write('supplierColorCode: $supplierColorCode, ')
          ..write('colorFamily: $colorFamily, ')
          ..write('isSeasonal: $isSeasonal, ')
          ..write('seasonIds: $seasonIds, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('colorImageUrl: $colorImageUrl, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    colorId,
    businessId,
    colorName,
    colorCode,
    hexColor,
    rgbColor,
    pantoneCode,
    supplierColorCode,
    colorFamily,
    isSeasonal,
    seasonIds,
    displayOrder,
    colorImageUrl,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryColor &&
          other.colorId == this.colorId &&
          other.businessId == this.businessId &&
          other.colorName == this.colorName &&
          other.colorCode == this.colorCode &&
          other.hexColor == this.hexColor &&
          other.rgbColor == this.rgbColor &&
          other.pantoneCode == this.pantoneCode &&
          other.supplierColorCode == this.supplierColorCode &&
          other.colorFamily == this.colorFamily &&
          other.isSeasonal == this.isSeasonal &&
          other.seasonIds == this.seasonIds &&
          other.displayOrder == this.displayOrder &&
          other.colorImageUrl == this.colorImageUrl &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class InventoryColorsCompanion extends UpdateCompanion<InventoryColor> {
  final Value<String> colorId;
  final Value<String> businessId;
  final Value<String> colorName;
  final Value<String> colorCode;
  final Value<String?> hexColor;
  final Value<String?> rgbColor;
  final Value<String?> pantoneCode;
  final Value<String?> supplierColorCode;
  final Value<String?> colorFamily;
  final Value<bool> isSeasonal;
  final Value<String?> seasonIds;
  final Value<int> displayOrder;
  final Value<String?> colorImageUrl;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const InventoryColorsCompanion({
    this.colorId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.colorName = const Value.absent(),
    this.colorCode = const Value.absent(),
    this.hexColor = const Value.absent(),
    this.rgbColor = const Value.absent(),
    this.pantoneCode = const Value.absent(),
    this.supplierColorCode = const Value.absent(),
    this.colorFamily = const Value.absent(),
    this.isSeasonal = const Value.absent(),
    this.seasonIds = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.colorImageUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryColorsCompanion.insert({
    required String colorId,
    required String businessId,
    required String colorName,
    required String colorCode,
    this.hexColor = const Value.absent(),
    this.rgbColor = const Value.absent(),
    this.pantoneCode = const Value.absent(),
    this.supplierColorCode = const Value.absent(),
    this.colorFamily = const Value.absent(),
    this.isSeasonal = const Value.absent(),
    this.seasonIds = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.colorImageUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : colorId = Value(colorId),
       businessId = Value(businessId),
       colorName = Value(colorName),
       colorCode = Value(colorCode);
  static Insertable<InventoryColor> custom({
    Expression<String>? colorId,
    Expression<String>? businessId,
    Expression<String>? colorName,
    Expression<String>? colorCode,
    Expression<String>? hexColor,
    Expression<String>? rgbColor,
    Expression<String>? pantoneCode,
    Expression<String>? supplierColorCode,
    Expression<String>? colorFamily,
    Expression<bool>? isSeasonal,
    Expression<String>? seasonIds,
    Expression<int>? displayOrder,
    Expression<String>? colorImageUrl,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (colorId != null) 'color_id': colorId,
      if (businessId != null) 'business_id': businessId,
      if (colorName != null) 'color_name': colorName,
      if (colorCode != null) 'color_code': colorCode,
      if (hexColor != null) 'hex_color': hexColor,
      if (rgbColor != null) 'rgb_color': rgbColor,
      if (pantoneCode != null) 'pantone_code': pantoneCode,
      if (supplierColorCode != null) 'supplier_color_code': supplierColorCode,
      if (colorFamily != null) 'color_family': colorFamily,
      if (isSeasonal != null) 'is_seasonal': isSeasonal,
      if (seasonIds != null) 'season_ids': seasonIds,
      if (displayOrder != null) 'display_order': displayOrder,
      if (colorImageUrl != null) 'color_image_url': colorImageUrl,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryColorsCompanion copyWith({
    Value<String>? colorId,
    Value<String>? businessId,
    Value<String>? colorName,
    Value<String>? colorCode,
    Value<String?>? hexColor,
    Value<String?>? rgbColor,
    Value<String?>? pantoneCode,
    Value<String?>? supplierColorCode,
    Value<String?>? colorFamily,
    Value<bool>? isSeasonal,
    Value<String?>? seasonIds,
    Value<int>? displayOrder,
    Value<String?>? colorImageUrl,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return InventoryColorsCompanion(
      colorId: colorId ?? this.colorId,
      businessId: businessId ?? this.businessId,
      colorName: colorName ?? this.colorName,
      colorCode: colorCode ?? this.colorCode,
      hexColor: hexColor ?? this.hexColor,
      rgbColor: rgbColor ?? this.rgbColor,
      pantoneCode: pantoneCode ?? this.pantoneCode,
      supplierColorCode: supplierColorCode ?? this.supplierColorCode,
      colorFamily: colorFamily ?? this.colorFamily,
      isSeasonal: isSeasonal ?? this.isSeasonal,
      seasonIds: seasonIds ?? this.seasonIds,
      displayOrder: displayOrder ?? this.displayOrder,
      colorImageUrl: colorImageUrl ?? this.colorImageUrl,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (colorId.present) {
      map['color_id'] = Variable<String>(colorId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (colorName.present) {
      map['color_name'] = Variable<String>(colorName.value);
    }
    if (colorCode.present) {
      map['color_code'] = Variable<String>(colorCode.value);
    }
    if (hexColor.present) {
      map['hex_color'] = Variable<String>(hexColor.value);
    }
    if (rgbColor.present) {
      map['rgb_color'] = Variable<String>(rgbColor.value);
    }
    if (pantoneCode.present) {
      map['pantone_code'] = Variable<String>(pantoneCode.value);
    }
    if (supplierColorCode.present) {
      map['supplier_color_code'] = Variable<String>(supplierColorCode.value);
    }
    if (colorFamily.present) {
      map['color_family'] = Variable<String>(colorFamily.value);
    }
    if (isSeasonal.present) {
      map['is_seasonal'] = Variable<bool>(isSeasonal.value);
    }
    if (seasonIds.present) {
      map['season_ids'] = Variable<String>(seasonIds.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (colorImageUrl.present) {
      map['color_image_url'] = Variable<String>(colorImageUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InventoryColorsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryColorsCompanion(')
          ..write('colorId: $colorId, ')
          ..write('businessId: $businessId, ')
          ..write('colorName: $colorName, ')
          ..write('colorCode: $colorCode, ')
          ..write('hexColor: $hexColor, ')
          ..write('rgbColor: $rgbColor, ')
          ..write('pantoneCode: $pantoneCode, ')
          ..write('supplierColorCode: $supplierColorCode, ')
          ..write('colorFamily: $colorFamily, ')
          ..write('isSeasonal: $isSeasonal, ')
          ..write('seasonIds: $seasonIds, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('colorImageUrl: $colorImageUrl, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventorySizesTable extends InventorySizes
    with TableInfo<$InventorySizesTable, InventorySize> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventorySizesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sizeIdMeta = const VerificationMeta('sizeId');
  @override
  late final GeneratedColumn<String> sizeId = GeneratedColumn<String>(
    'size_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subCategoryIdMeta = const VerificationMeta(
    'subCategoryId',
  );
  @override
  late final GeneratedColumn<String> subCategoryId = GeneratedColumn<String>(
    'sub_category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeNameMeta = const VerificationMeta(
    'sizeName',
  );
  @override
  late final GeneratedColumn<String> sizeName = GeneratedColumn<String>(
    'size_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeCodeMeta = const VerificationMeta(
    'sizeCode',
  );
  @override
  late final GeneratedColumn<String> sizeCode = GeneratedColumn<String>(
    'size_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeTypeMeta = const VerificationMeta(
    'sizeType',
  );
  @override
  late final GeneratedColumn<String> sizeType = GeneratedColumn<String>(
    'size_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeSystemMeta = const VerificationMeta(
    'sizeSystem',
  );
  @override
  late final GeneratedColumn<String> sizeSystem = GeneratedColumn<String>(
    'size_system',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeasurementsMeta = const VerificationMeta(
    'sizeMeasurements',
  );
  @override
  late final GeneratedColumn<String> sizeMeasurements = GeneratedColumn<String>(
    'size_measurements',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeChartPositionMeta = const VerificationMeta(
    'sizeChartPosition',
  );
  @override
  late final GeneratedColumn<int> sizeChartPosition = GeneratedColumn<int>(
    'size_chart_position',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _equivalentSizesMeta = const VerificationMeta(
    'equivalentSizes',
  );
  @override
  late final GeneratedColumn<String> equivalentSizes = GeneratedColumn<String>(
    'equivalent_sizes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($InventorySizesTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    sizeId,
    businessId,
    subCategoryId,
    sizeName,
    sizeCode,
    sizeType,
    sizeSystem,
    sizeMeasurements,
    sizeChartPosition,
    displayOrder,
    equivalentSizes,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_sizes';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventorySize> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('size_id')) {
      context.handle(
        _sizeIdMeta,
        sizeId.isAcceptableOrUnknown(data['size_id']!, _sizeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('sub_category_id')) {
      context.handle(
        _subCategoryIdMeta,
        subCategoryId.isAcceptableOrUnknown(
          data['sub_category_id']!,
          _subCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('size_name')) {
      context.handle(
        _sizeNameMeta,
        sizeName.isAcceptableOrUnknown(data['size_name']!, _sizeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeNameMeta);
    }
    if (data.containsKey('size_code')) {
      context.handle(
        _sizeCodeMeta,
        sizeCode.isAcceptableOrUnknown(data['size_code']!, _sizeCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeCodeMeta);
    }
    if (data.containsKey('size_type')) {
      context.handle(
        _sizeTypeMeta,
        sizeType.isAcceptableOrUnknown(data['size_type']!, _sizeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeTypeMeta);
    }
    if (data.containsKey('size_system')) {
      context.handle(
        _sizeSystemMeta,
        sizeSystem.isAcceptableOrUnknown(data['size_system']!, _sizeSystemMeta),
      );
    }
    if (data.containsKey('size_measurements')) {
      context.handle(
        _sizeMeasurementsMeta,
        sizeMeasurements.isAcceptableOrUnknown(
          data['size_measurements']!,
          _sizeMeasurementsMeta,
        ),
      );
    }
    if (data.containsKey('size_chart_position')) {
      context.handle(
        _sizeChartPositionMeta,
        sizeChartPosition.isAcceptableOrUnknown(
          data['size_chart_position']!,
          _sizeChartPositionMeta,
        ),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('equivalent_sizes')) {
      context.handle(
        _equivalentSizesMeta,
        equivalentSizes.isAcceptableOrUnknown(
          data['equivalent_sizes']!,
          _equivalentSizesMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sizeId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {businessId, subCategoryId, sizeCode},
  ];
  @override
  InventorySize map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventorySize(
      sizeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      subCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_category_id'],
      ),
      sizeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_name'],
      )!,
      sizeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_code'],
      )!,
      sizeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_type'],
      )!,
      sizeSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_system'],
      ),
      sizeMeasurements: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_measurements'],
      ),
      sizeChartPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_chart_position'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      equivalentSizes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equivalent_sizes'],
      ),
      status: $InventorySizesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $InventorySizesTable createAlias(String alias) {
    return $InventorySizesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class InventorySize extends DataClass implements Insertable<InventorySize> {
  final String sizeId;
  final String businessId;
  final String? subCategoryId;
  final String sizeName;
  final String sizeCode;
  final String sizeType;
  final String? sizeSystem;
  final String? sizeMeasurements;
  final int? sizeChartPosition;
  final int displayOrder;
  final String? equivalentSizes;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const InventorySize({
    required this.sizeId,
    required this.businessId,
    this.subCategoryId,
    required this.sizeName,
    required this.sizeCode,
    required this.sizeType,
    this.sizeSystem,
    this.sizeMeasurements,
    this.sizeChartPosition,
    required this.displayOrder,
    this.equivalentSizes,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['size_id'] = Variable<String>(sizeId);
    map['business_id'] = Variable<String>(businessId);
    if (!nullToAbsent || subCategoryId != null) {
      map['sub_category_id'] = Variable<String>(subCategoryId);
    }
    map['size_name'] = Variable<String>(sizeName);
    map['size_code'] = Variable<String>(sizeCode);
    map['size_type'] = Variable<String>(sizeType);
    if (!nullToAbsent || sizeSystem != null) {
      map['size_system'] = Variable<String>(sizeSystem);
    }
    if (!nullToAbsent || sizeMeasurements != null) {
      map['size_measurements'] = Variable<String>(sizeMeasurements);
    }
    if (!nullToAbsent || sizeChartPosition != null) {
      map['size_chart_position'] = Variable<int>(sizeChartPosition);
    }
    map['display_order'] = Variable<int>(displayOrder);
    if (!nullToAbsent || equivalentSizes != null) {
      map['equivalent_sizes'] = Variable<String>(equivalentSizes);
    }
    {
      map['status'] = Variable<String>(
        $InventorySizesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  InventorySizesCompanion toCompanion(bool nullToAbsent) {
    return InventorySizesCompanion(
      sizeId: Value(sizeId),
      businessId: Value(businessId),
      subCategoryId: subCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(subCategoryId),
      sizeName: Value(sizeName),
      sizeCode: Value(sizeCode),
      sizeType: Value(sizeType),
      sizeSystem: sizeSystem == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeSystem),
      sizeMeasurements: sizeMeasurements == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeMeasurements),
      sizeChartPosition: sizeChartPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeChartPosition),
      displayOrder: Value(displayOrder),
      equivalentSizes: equivalentSizes == null && nullToAbsent
          ? const Value.absent()
          : Value(equivalentSizes),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory InventorySize.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventorySize(
      sizeId: serializer.fromJson<String>(json['sizeId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      subCategoryId: serializer.fromJson<String?>(json['subCategoryId']),
      sizeName: serializer.fromJson<String>(json['sizeName']),
      sizeCode: serializer.fromJson<String>(json['sizeCode']),
      sizeType: serializer.fromJson<String>(json['sizeType']),
      sizeSystem: serializer.fromJson<String?>(json['sizeSystem']),
      sizeMeasurements: serializer.fromJson<String?>(json['sizeMeasurements']),
      sizeChartPosition: serializer.fromJson<int?>(json['sizeChartPosition']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      equivalentSizes: serializer.fromJson<String?>(json['equivalentSizes']),
      status: $InventorySizesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sizeId': serializer.toJson<String>(sizeId),
      'businessId': serializer.toJson<String>(businessId),
      'subCategoryId': serializer.toJson<String?>(subCategoryId),
      'sizeName': serializer.toJson<String>(sizeName),
      'sizeCode': serializer.toJson<String>(sizeCode),
      'sizeType': serializer.toJson<String>(sizeType),
      'sizeSystem': serializer.toJson<String?>(sizeSystem),
      'sizeMeasurements': serializer.toJson<String?>(sizeMeasurements),
      'sizeChartPosition': serializer.toJson<int?>(sizeChartPosition),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'equivalentSizes': serializer.toJson<String?>(equivalentSizes),
      'status': serializer.toJson<String>(
        $InventorySizesTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  InventorySize copyWith({
    String? sizeId,
    String? businessId,
    Value<String?> subCategoryId = const Value.absent(),
    String? sizeName,
    String? sizeCode,
    String? sizeType,
    Value<String?> sizeSystem = const Value.absent(),
    Value<String?> sizeMeasurements = const Value.absent(),
    Value<int?> sizeChartPosition = const Value.absent(),
    int? displayOrder,
    Value<String?> equivalentSizes = const Value.absent(),
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => InventorySize(
    sizeId: sizeId ?? this.sizeId,
    businessId: businessId ?? this.businessId,
    subCategoryId: subCategoryId.present
        ? subCategoryId.value
        : this.subCategoryId,
    sizeName: sizeName ?? this.sizeName,
    sizeCode: sizeCode ?? this.sizeCode,
    sizeType: sizeType ?? this.sizeType,
    sizeSystem: sizeSystem.present ? sizeSystem.value : this.sizeSystem,
    sizeMeasurements: sizeMeasurements.present
        ? sizeMeasurements.value
        : this.sizeMeasurements,
    sizeChartPosition: sizeChartPosition.present
        ? sizeChartPosition.value
        : this.sizeChartPosition,
    displayOrder: displayOrder ?? this.displayOrder,
    equivalentSizes: equivalentSizes.present
        ? equivalentSizes.value
        : this.equivalentSizes,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  InventorySize copyWithCompanion(InventorySizesCompanion data) {
    return InventorySize(
      sizeId: data.sizeId.present ? data.sizeId.value : this.sizeId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      subCategoryId: data.subCategoryId.present
          ? data.subCategoryId.value
          : this.subCategoryId,
      sizeName: data.sizeName.present ? data.sizeName.value : this.sizeName,
      sizeCode: data.sizeCode.present ? data.sizeCode.value : this.sizeCode,
      sizeType: data.sizeType.present ? data.sizeType.value : this.sizeType,
      sizeSystem: data.sizeSystem.present
          ? data.sizeSystem.value
          : this.sizeSystem,
      sizeMeasurements: data.sizeMeasurements.present
          ? data.sizeMeasurements.value
          : this.sizeMeasurements,
      sizeChartPosition: data.sizeChartPosition.present
          ? data.sizeChartPosition.value
          : this.sizeChartPosition,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      equivalentSizes: data.equivalentSizes.present
          ? data.equivalentSizes.value
          : this.equivalentSizes,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventorySize(')
          ..write('sizeId: $sizeId, ')
          ..write('businessId: $businessId, ')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('sizeName: $sizeName, ')
          ..write('sizeCode: $sizeCode, ')
          ..write('sizeType: $sizeType, ')
          ..write('sizeSystem: $sizeSystem, ')
          ..write('sizeMeasurements: $sizeMeasurements, ')
          ..write('sizeChartPosition: $sizeChartPosition, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('equivalentSizes: $equivalentSizes, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sizeId,
    businessId,
    subCategoryId,
    sizeName,
    sizeCode,
    sizeType,
    sizeSystem,
    sizeMeasurements,
    sizeChartPosition,
    displayOrder,
    equivalentSizes,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventorySize &&
          other.sizeId == this.sizeId &&
          other.businessId == this.businessId &&
          other.subCategoryId == this.subCategoryId &&
          other.sizeName == this.sizeName &&
          other.sizeCode == this.sizeCode &&
          other.sizeType == this.sizeType &&
          other.sizeSystem == this.sizeSystem &&
          other.sizeMeasurements == this.sizeMeasurements &&
          other.sizeChartPosition == this.sizeChartPosition &&
          other.displayOrder == this.displayOrder &&
          other.equivalentSizes == this.equivalentSizes &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class InventorySizesCompanion extends UpdateCompanion<InventorySize> {
  final Value<String> sizeId;
  final Value<String> businessId;
  final Value<String?> subCategoryId;
  final Value<String> sizeName;
  final Value<String> sizeCode;
  final Value<String> sizeType;
  final Value<String?> sizeSystem;
  final Value<String?> sizeMeasurements;
  final Value<int?> sizeChartPosition;
  final Value<int> displayOrder;
  final Value<String?> equivalentSizes;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const InventorySizesCompanion({
    this.sizeId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.subCategoryId = const Value.absent(),
    this.sizeName = const Value.absent(),
    this.sizeCode = const Value.absent(),
    this.sizeType = const Value.absent(),
    this.sizeSystem = const Value.absent(),
    this.sizeMeasurements = const Value.absent(),
    this.sizeChartPosition = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.equivalentSizes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventorySizesCompanion.insert({
    required String sizeId,
    required String businessId,
    this.subCategoryId = const Value.absent(),
    required String sizeName,
    required String sizeCode,
    required String sizeType,
    this.sizeSystem = const Value.absent(),
    this.sizeMeasurements = const Value.absent(),
    this.sizeChartPosition = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.equivalentSizes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sizeId = Value(sizeId),
       businessId = Value(businessId),
       sizeName = Value(sizeName),
       sizeCode = Value(sizeCode),
       sizeType = Value(sizeType);
  static Insertable<InventorySize> custom({
    Expression<String>? sizeId,
    Expression<String>? businessId,
    Expression<String>? subCategoryId,
    Expression<String>? sizeName,
    Expression<String>? sizeCode,
    Expression<String>? sizeType,
    Expression<String>? sizeSystem,
    Expression<String>? sizeMeasurements,
    Expression<int>? sizeChartPosition,
    Expression<int>? displayOrder,
    Expression<String>? equivalentSizes,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sizeId != null) 'size_id': sizeId,
      if (businessId != null) 'business_id': businessId,
      if (subCategoryId != null) 'sub_category_id': subCategoryId,
      if (sizeName != null) 'size_name': sizeName,
      if (sizeCode != null) 'size_code': sizeCode,
      if (sizeType != null) 'size_type': sizeType,
      if (sizeSystem != null) 'size_system': sizeSystem,
      if (sizeMeasurements != null) 'size_measurements': sizeMeasurements,
      if (sizeChartPosition != null) 'size_chart_position': sizeChartPosition,
      if (displayOrder != null) 'display_order': displayOrder,
      if (equivalentSizes != null) 'equivalent_sizes': equivalentSizes,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventorySizesCompanion copyWith({
    Value<String>? sizeId,
    Value<String>? businessId,
    Value<String?>? subCategoryId,
    Value<String>? sizeName,
    Value<String>? sizeCode,
    Value<String>? sizeType,
    Value<String?>? sizeSystem,
    Value<String?>? sizeMeasurements,
    Value<int?>? sizeChartPosition,
    Value<int>? displayOrder,
    Value<String?>? equivalentSizes,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return InventorySizesCompanion(
      sizeId: sizeId ?? this.sizeId,
      businessId: businessId ?? this.businessId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      sizeName: sizeName ?? this.sizeName,
      sizeCode: sizeCode ?? this.sizeCode,
      sizeType: sizeType ?? this.sizeType,
      sizeSystem: sizeSystem ?? this.sizeSystem,
      sizeMeasurements: sizeMeasurements ?? this.sizeMeasurements,
      sizeChartPosition: sizeChartPosition ?? this.sizeChartPosition,
      displayOrder: displayOrder ?? this.displayOrder,
      equivalentSizes: equivalentSizes ?? this.equivalentSizes,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sizeId.present) {
      map['size_id'] = Variable<String>(sizeId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (subCategoryId.present) {
      map['sub_category_id'] = Variable<String>(subCategoryId.value);
    }
    if (sizeName.present) {
      map['size_name'] = Variable<String>(sizeName.value);
    }
    if (sizeCode.present) {
      map['size_code'] = Variable<String>(sizeCode.value);
    }
    if (sizeType.present) {
      map['size_type'] = Variable<String>(sizeType.value);
    }
    if (sizeSystem.present) {
      map['size_system'] = Variable<String>(sizeSystem.value);
    }
    if (sizeMeasurements.present) {
      map['size_measurements'] = Variable<String>(sizeMeasurements.value);
    }
    if (sizeChartPosition.present) {
      map['size_chart_position'] = Variable<int>(sizeChartPosition.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (equivalentSizes.present) {
      map['equivalent_sizes'] = Variable<String>(equivalentSizes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InventorySizesTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventorySizesCompanion(')
          ..write('sizeId: $sizeId, ')
          ..write('businessId: $businessId, ')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('sizeName: $sizeName, ')
          ..write('sizeCode: $sizeCode, ')
          ..write('sizeType: $sizeType, ')
          ..write('sizeSystem: $sizeSystem, ')
          ..write('sizeMeasurements: $sizeMeasurements, ')
          ..write('sizeChartPosition: $sizeChartPosition, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('equivalentSizes: $equivalentSizes, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeasonTable extends Season with TableInfo<$SeasonTable, SeasonData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeasonTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seasonIdMeta = const VerificationMeta(
    'seasonId',
  );
  @override
  late final GeneratedColumn<String> seasonId = GeneratedColumn<String>(
    'season_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonNameMeta = const VerificationMeta(
    'seasonName',
  );
  @override
  late final GeneratedColumn<String> seasonName = GeneratedColumn<String>(
    'season_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonCodeMeta = const VerificationMeta(
    'seasonCode',
  );
  @override
  late final GeneratedColumn<String> seasonCode = GeneratedColumn<String>(
    'season_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonDescriptionMeta = const VerificationMeta(
    'seasonDescription',
  );
  @override
  late final GeneratedColumn<String> seasonDescription =
      GeneratedColumn<String>(
        'season_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCurrentSeasonMeta = const VerificationMeta(
    'isCurrentSeason',
  );
  @override
  late final GeneratedColumn<bool> isCurrentSeason = GeneratedColumn<bool>(
    'is_current_season',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current_season" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(false),
  );
  static const VerificationMeta _marketingThemesMeta = const VerificationMeta(
    'marketingThemes',
  );
  @override
  late final GeneratedColumn<String> marketingThemes = GeneratedColumn<String>(
    'marketing_themes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetDemographicsMeta =
      const VerificationMeta('targetDemographics');
  @override
  late final GeneratedColumn<String> targetDemographics =
      GeneratedColumn<String>(
        'target_demographics',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _seasonalMarkupPercentageMeta =
      const VerificationMeta('seasonalMarkupPercentage');
  @override
  late final GeneratedColumn<double> seasonalMarkupPercentage =
      GeneratedColumn<double>(
        'seasonal_markup_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($SeasonTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    seasonId,
    businessId,
    seasonName,
    seasonCode,
    seasonDescription,
    startDate,
    endDate,
    isCurrentSeason,
    marketingThemes,
    targetDemographics,
    seasonalMarkupPercentage,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'season';
  @override
  VerificationContext validateIntegrity(
    Insertable<SeasonData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('season_id')) {
      context.handle(
        _seasonIdMeta,
        seasonId.isAcceptableOrUnknown(data['season_id']!, _seasonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_seasonIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('season_name')) {
      context.handle(
        _seasonNameMeta,
        seasonName.isAcceptableOrUnknown(data['season_name']!, _seasonNameMeta),
      );
    } else if (isInserting) {
      context.missing(_seasonNameMeta);
    }
    if (data.containsKey('season_code')) {
      context.handle(
        _seasonCodeMeta,
        seasonCode.isAcceptableOrUnknown(data['season_code']!, _seasonCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_seasonCodeMeta);
    }
    if (data.containsKey('season_description')) {
      context.handle(
        _seasonDescriptionMeta,
        seasonDescription.isAcceptableOrUnknown(
          data['season_description']!,
          _seasonDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('is_current_season')) {
      context.handle(
        _isCurrentSeasonMeta,
        isCurrentSeason.isAcceptableOrUnknown(
          data['is_current_season']!,
          _isCurrentSeasonMeta,
        ),
      );
    }
    if (data.containsKey('marketing_themes')) {
      context.handle(
        _marketingThemesMeta,
        marketingThemes.isAcceptableOrUnknown(
          data['marketing_themes']!,
          _marketingThemesMeta,
        ),
      );
    }
    if (data.containsKey('target_demographics')) {
      context.handle(
        _targetDemographicsMeta,
        targetDemographics.isAcceptableOrUnknown(
          data['target_demographics']!,
          _targetDemographicsMeta,
        ),
      );
    }
    if (data.containsKey('seasonal_markup_percentage')) {
      context.handle(
        _seasonalMarkupPercentageMeta,
        seasonalMarkupPercentage.isAcceptableOrUnknown(
          data['seasonal_markup_percentage']!,
          _seasonalMarkupPercentageMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {seasonId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {businessId, seasonCode},
  ];
  @override
  SeasonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeasonData(
      seasonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      seasonName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_name'],
      )!,
      seasonCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_code'],
      )!,
      seasonDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_description'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      isCurrentSeason: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current_season'],
      )!,
      marketingThemes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marketing_themes'],
      ),
      targetDemographics: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_demographics'],
      ),
      seasonalMarkupPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}seasonal_markup_percentage'],
      ),
      status: $SeasonTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $SeasonTable createAlias(String alias) {
    return $SeasonTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class SeasonData extends DataClass implements Insertable<SeasonData> {
  final String seasonId;
  final String businessId;
  final String seasonName;
  final String seasonCode;
  final String? seasonDescription;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentSeason;
  final String? marketingThemes;
  final String? targetDemographics;
  final double? seasonalMarkupPercentage;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const SeasonData({
    required this.seasonId,
    required this.businessId,
    required this.seasonName,
    required this.seasonCode,
    this.seasonDescription,
    this.startDate,
    this.endDate,
    required this.isCurrentSeason,
    this.marketingThemes,
    this.targetDemographics,
    this.seasonalMarkupPercentage,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['season_id'] = Variable<String>(seasonId);
    map['business_id'] = Variable<String>(businessId);
    map['season_name'] = Variable<String>(seasonName);
    map['season_code'] = Variable<String>(seasonCode);
    if (!nullToAbsent || seasonDescription != null) {
      map['season_description'] = Variable<String>(seasonDescription);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['is_current_season'] = Variable<bool>(isCurrentSeason);
    if (!nullToAbsent || marketingThemes != null) {
      map['marketing_themes'] = Variable<String>(marketingThemes);
    }
    if (!nullToAbsent || targetDemographics != null) {
      map['target_demographics'] = Variable<String>(targetDemographics);
    }
    if (!nullToAbsent || seasonalMarkupPercentage != null) {
      map['seasonal_markup_percentage'] = Variable<double>(
        seasonalMarkupPercentage,
      );
    }
    {
      map['status'] = Variable<String>(
        $SeasonTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  SeasonCompanion toCompanion(bool nullToAbsent) {
    return SeasonCompanion(
      seasonId: Value(seasonId),
      businessId: Value(businessId),
      seasonName: Value(seasonName),
      seasonCode: Value(seasonCode),
      seasonDescription: seasonDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(seasonDescription),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      isCurrentSeason: Value(isCurrentSeason),
      marketingThemes: marketingThemes == null && nullToAbsent
          ? const Value.absent()
          : Value(marketingThemes),
      targetDemographics: targetDemographics == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDemographics),
      seasonalMarkupPercentage: seasonalMarkupPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(seasonalMarkupPercentage),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory SeasonData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeasonData(
      seasonId: serializer.fromJson<String>(json['seasonId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      seasonName: serializer.fromJson<String>(json['seasonName']),
      seasonCode: serializer.fromJson<String>(json['seasonCode']),
      seasonDescription: serializer.fromJson<String?>(
        json['seasonDescription'],
      ),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      isCurrentSeason: serializer.fromJson<bool>(json['isCurrentSeason']),
      marketingThemes: serializer.fromJson<String?>(json['marketingThemes']),
      targetDemographics: serializer.fromJson<String?>(
        json['targetDemographics'],
      ),
      seasonalMarkupPercentage: serializer.fromJson<double?>(
        json['seasonalMarkupPercentage'],
      ),
      status: $SeasonTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seasonId': serializer.toJson<String>(seasonId),
      'businessId': serializer.toJson<String>(businessId),
      'seasonName': serializer.toJson<String>(seasonName),
      'seasonCode': serializer.toJson<String>(seasonCode),
      'seasonDescription': serializer.toJson<String?>(seasonDescription),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'isCurrentSeason': serializer.toJson<bool>(isCurrentSeason),
      'marketingThemes': serializer.toJson<String?>(marketingThemes),
      'targetDemographics': serializer.toJson<String?>(targetDemographics),
      'seasonalMarkupPercentage': serializer.toJson<double?>(
        seasonalMarkupPercentage,
      ),
      'status': serializer.toJson<String>(
        $SeasonTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  SeasonData copyWith({
    String? seasonId,
    String? businessId,
    String? seasonName,
    String? seasonCode,
    Value<String?> seasonDescription = const Value.absent(),
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    bool? isCurrentSeason,
    Value<String?> marketingThemes = const Value.absent(),
    Value<String?> targetDemographics = const Value.absent(),
    Value<double?> seasonalMarkupPercentage = const Value.absent(),
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => SeasonData(
    seasonId: seasonId ?? this.seasonId,
    businessId: businessId ?? this.businessId,
    seasonName: seasonName ?? this.seasonName,
    seasonCode: seasonCode ?? this.seasonCode,
    seasonDescription: seasonDescription.present
        ? seasonDescription.value
        : this.seasonDescription,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    isCurrentSeason: isCurrentSeason ?? this.isCurrentSeason,
    marketingThemes: marketingThemes.present
        ? marketingThemes.value
        : this.marketingThemes,
    targetDemographics: targetDemographics.present
        ? targetDemographics.value
        : this.targetDemographics,
    seasonalMarkupPercentage: seasonalMarkupPercentage.present
        ? seasonalMarkupPercentage.value
        : this.seasonalMarkupPercentage,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  SeasonData copyWithCompanion(SeasonCompanion data) {
    return SeasonData(
      seasonId: data.seasonId.present ? data.seasonId.value : this.seasonId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      seasonName: data.seasonName.present
          ? data.seasonName.value
          : this.seasonName,
      seasonCode: data.seasonCode.present
          ? data.seasonCode.value
          : this.seasonCode,
      seasonDescription: data.seasonDescription.present
          ? data.seasonDescription.value
          : this.seasonDescription,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isCurrentSeason: data.isCurrentSeason.present
          ? data.isCurrentSeason.value
          : this.isCurrentSeason,
      marketingThemes: data.marketingThemes.present
          ? data.marketingThemes.value
          : this.marketingThemes,
      targetDemographics: data.targetDemographics.present
          ? data.targetDemographics.value
          : this.targetDemographics,
      seasonalMarkupPercentage: data.seasonalMarkupPercentage.present
          ? data.seasonalMarkupPercentage.value
          : this.seasonalMarkupPercentage,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeasonData(')
          ..write('seasonId: $seasonId, ')
          ..write('businessId: $businessId, ')
          ..write('seasonName: $seasonName, ')
          ..write('seasonCode: $seasonCode, ')
          ..write('seasonDescription: $seasonDescription, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isCurrentSeason: $isCurrentSeason, ')
          ..write('marketingThemes: $marketingThemes, ')
          ..write('targetDemographics: $targetDemographics, ')
          ..write('seasonalMarkupPercentage: $seasonalMarkupPercentage, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    seasonId,
    businessId,
    seasonName,
    seasonCode,
    seasonDescription,
    startDate,
    endDate,
    isCurrentSeason,
    marketingThemes,
    targetDemographics,
    seasonalMarkupPercentage,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeasonData &&
          other.seasonId == this.seasonId &&
          other.businessId == this.businessId &&
          other.seasonName == this.seasonName &&
          other.seasonCode == this.seasonCode &&
          other.seasonDescription == this.seasonDescription &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isCurrentSeason == this.isCurrentSeason &&
          other.marketingThemes == this.marketingThemes &&
          other.targetDemographics == this.targetDemographics &&
          other.seasonalMarkupPercentage == this.seasonalMarkupPercentage &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class SeasonCompanion extends UpdateCompanion<SeasonData> {
  final Value<String> seasonId;
  final Value<String> businessId;
  final Value<String> seasonName;
  final Value<String> seasonCode;
  final Value<String?> seasonDescription;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<bool> isCurrentSeason;
  final Value<String?> marketingThemes;
  final Value<String?> targetDemographics;
  final Value<double?> seasonalMarkupPercentage;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const SeasonCompanion({
    this.seasonId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.seasonName = const Value.absent(),
    this.seasonCode = const Value.absent(),
    this.seasonDescription = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isCurrentSeason = const Value.absent(),
    this.marketingThemes = const Value.absent(),
    this.targetDemographics = const Value.absent(),
    this.seasonalMarkupPercentage = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeasonCompanion.insert({
    required String seasonId,
    required String businessId,
    required String seasonName,
    required String seasonCode,
    this.seasonDescription = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isCurrentSeason = const Value.absent(),
    this.marketingThemes = const Value.absent(),
    this.targetDemographics = const Value.absent(),
    this.seasonalMarkupPercentage = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : seasonId = Value(seasonId),
       businessId = Value(businessId),
       seasonName = Value(seasonName),
       seasonCode = Value(seasonCode);
  static Insertable<SeasonData> custom({
    Expression<String>? seasonId,
    Expression<String>? businessId,
    Expression<String>? seasonName,
    Expression<String>? seasonCode,
    Expression<String>? seasonDescription,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? isCurrentSeason,
    Expression<String>? marketingThemes,
    Expression<String>? targetDemographics,
    Expression<double>? seasonalMarkupPercentage,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (seasonId != null) 'season_id': seasonId,
      if (businessId != null) 'business_id': businessId,
      if (seasonName != null) 'season_name': seasonName,
      if (seasonCode != null) 'season_code': seasonCode,
      if (seasonDescription != null) 'season_description': seasonDescription,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isCurrentSeason != null) 'is_current_season': isCurrentSeason,
      if (marketingThemes != null) 'marketing_themes': marketingThemes,
      if (targetDemographics != null) 'target_demographics': targetDemographics,
      if (seasonalMarkupPercentage != null)
        'seasonal_markup_percentage': seasonalMarkupPercentage,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeasonCompanion copyWith({
    Value<String>? seasonId,
    Value<String>? businessId,
    Value<String>? seasonName,
    Value<String>? seasonCode,
    Value<String?>? seasonDescription,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<bool>? isCurrentSeason,
    Value<String?>? marketingThemes,
    Value<String?>? targetDemographics,
    Value<double?>? seasonalMarkupPercentage,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return SeasonCompanion(
      seasonId: seasonId ?? this.seasonId,
      businessId: businessId ?? this.businessId,
      seasonName: seasonName ?? this.seasonName,
      seasonCode: seasonCode ?? this.seasonCode,
      seasonDescription: seasonDescription ?? this.seasonDescription,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentSeason: isCurrentSeason ?? this.isCurrentSeason,
      marketingThemes: marketingThemes ?? this.marketingThemes,
      targetDemographics: targetDemographics ?? this.targetDemographics,
      seasonalMarkupPercentage:
          seasonalMarkupPercentage ?? this.seasonalMarkupPercentage,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seasonId.present) {
      map['season_id'] = Variable<String>(seasonId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (seasonName.present) {
      map['season_name'] = Variable<String>(seasonName.value);
    }
    if (seasonCode.present) {
      map['season_code'] = Variable<String>(seasonCode.value);
    }
    if (seasonDescription.present) {
      map['season_description'] = Variable<String>(seasonDescription.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (isCurrentSeason.present) {
      map['is_current_season'] = Variable<bool>(isCurrentSeason.value);
    }
    if (marketingThemes.present) {
      map['marketing_themes'] = Variable<String>(marketingThemes.value);
    }
    if (targetDemographics.present) {
      map['target_demographics'] = Variable<String>(targetDemographics.value);
    }
    if (seasonalMarkupPercentage.present) {
      map['seasonal_markup_percentage'] = Variable<double>(
        seasonalMarkupPercentage.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SeasonTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeasonCompanion(')
          ..write('seasonId: $seasonId, ')
          ..write('businessId: $businessId, ')
          ..write('seasonName: $seasonName, ')
          ..write('seasonCode: $seasonCode, ')
          ..write('seasonDescription: $seasonDescription, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isCurrentSeason: $isCurrentSeason, ')
          ..write('marketingThemes: $marketingThemes, ')
          ..write('targetDemographics: $targetDemographics, ')
          ..write('seasonalMarkupPercentage: $seasonalMarkupPercentage, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryLocationsTable extends InventoryLocations
    with TableInfo<$InventoryLocationsTable, InventoryLocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryLocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationCodeMeta = const VerificationMeta(
    'locationCode',
  );
  @override
  late final GeneratedColumn<String> locationCode = GeneratedColumn<String>(
    'location_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocationType, String>
  locationType =
      GeneratedColumn<String>(
        'location_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocationType>(
        $InventoryLocationsTable.$converterlocationType,
      );
  static const VerificationMeta _parentLocationIdMeta = const VerificationMeta(
    'parentLocationId',
  );
  @override
  late final GeneratedColumn<String> parentLocationId = GeneratedColumn<String>(
    'parent_location_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aisleMeta = const VerificationMeta('aisle');
  @override
  late final GeneratedColumn<String> aisle = GeneratedColumn<String>(
    'aisle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shelfMeta = const VerificationMeta('shelf');
  @override
  late final GeneratedColumn<String> shelf = GeneratedColumn<String>(
    'shelf',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _binMeta = const VerificationMeta('bin');
  @override
  late final GeneratedColumn<String> bin = GeneratedColumn<String>(
    'bin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxCapacityMeta = const VerificationMeta(
    'maxCapacity',
  );
  @override
  late final GeneratedColumn<int> maxCapacity = GeneratedColumn<int>(
    'max_capacity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentCapacityMeta = const VerificationMeta(
    'currentCapacity',
  );
  @override
  late final GeneratedColumn<int> currentCapacity = GeneratedColumn<int>(
    'current_capacity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _isSellableLocationMeta =
      const VerificationMeta('isSellableLocation');
  @override
  late final GeneratedColumn<bool> isSellableLocation = GeneratedColumn<bool>(
    'is_sellable_location',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sellable_location" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(true),
  );
  static const VerificationMeta _requiresCountingMeta = const VerificationMeta(
    'requiresCounting',
  );
  @override
  late final GeneratedColumn<bool> requiresCounting = GeneratedColumn<bool>(
    'requires_counting',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_counting" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(true),
  );
  static const VerificationMeta _temperatureControlledMeta =
      const VerificationMeta('temperatureControlled');
  @override
  late final GeneratedColumn<bool> temperatureControlled =
      GeneratedColumn<bool>(
        'temperature_controlled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("temperature_controlled" IN (0, 1))',
        ),
        defaultValue: const Constant<bool>(false),
      );
  static const VerificationMeta _securityLevelMeta = const VerificationMeta(
    'securityLevel',
  );
  @override
  late final GeneratedColumn<String> securityLevel = GeneratedColumn<String>(
    'security_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('standard'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($InventoryLocationsTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    locationId,
    businessId,
    branchId,
    locationName,
    locationCode,
    locationType,
    parentLocationId,
    aisle,
    shelf,
    bin,
    barcode,
    maxCapacity,
    currentCapacity,
    isSellableLocation,
    requiresCounting,
    temperatureControlled,
    securityLevel,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryLocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_locationNameMeta);
    }
    if (data.containsKey('location_code')) {
      context.handle(
        _locationCodeMeta,
        locationCode.isAcceptableOrUnknown(
          data['location_code']!,
          _locationCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_locationCodeMeta);
    }
    if (data.containsKey('parent_location_id')) {
      context.handle(
        _parentLocationIdMeta,
        parentLocationId.isAcceptableOrUnknown(
          data['parent_location_id']!,
          _parentLocationIdMeta,
        ),
      );
    }
    if (data.containsKey('aisle')) {
      context.handle(
        _aisleMeta,
        aisle.isAcceptableOrUnknown(data['aisle']!, _aisleMeta),
      );
    }
    if (data.containsKey('shelf')) {
      context.handle(
        _shelfMeta,
        shelf.isAcceptableOrUnknown(data['shelf']!, _shelfMeta),
      );
    }
    if (data.containsKey('bin')) {
      context.handle(
        _binMeta,
        bin.isAcceptableOrUnknown(data['bin']!, _binMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('max_capacity')) {
      context.handle(
        _maxCapacityMeta,
        maxCapacity.isAcceptableOrUnknown(
          data['max_capacity']!,
          _maxCapacityMeta,
        ),
      );
    }
    if (data.containsKey('current_capacity')) {
      context.handle(
        _currentCapacityMeta,
        currentCapacity.isAcceptableOrUnknown(
          data['current_capacity']!,
          _currentCapacityMeta,
        ),
      );
    }
    if (data.containsKey('is_sellable_location')) {
      context.handle(
        _isSellableLocationMeta,
        isSellableLocation.isAcceptableOrUnknown(
          data['is_sellable_location']!,
          _isSellableLocationMeta,
        ),
      );
    }
    if (data.containsKey('requires_counting')) {
      context.handle(
        _requiresCountingMeta,
        requiresCounting.isAcceptableOrUnknown(
          data['requires_counting']!,
          _requiresCountingMeta,
        ),
      );
    }
    if (data.containsKey('temperature_controlled')) {
      context.handle(
        _temperatureControlledMeta,
        temperatureControlled.isAcceptableOrUnknown(
          data['temperature_controlled']!,
          _temperatureControlledMeta,
        ),
      );
    }
    if (data.containsKey('security_level')) {
      context.handle(
        _securityLevelMeta,
        securityLevel.isAcceptableOrUnknown(
          data['security_level']!,
          _securityLevelMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {locationId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {branchId, locationCode},
  ];
  @override
  InventoryLocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryLocation(
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      )!,
      locationCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_code'],
      )!,
      locationType: $InventoryLocationsTable.$converterlocationType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}location_type'],
        )!,
      ),
      parentLocationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_location_id'],
      ),
      aisle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aisle'],
      ),
      shelf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shelf'],
      ),
      bin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bin'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      maxCapacity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_capacity'],
      ),
      currentCapacity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_capacity'],
      )!,
      isSellableLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sellable_location'],
      )!,
      requiresCounting: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_counting'],
      )!,
      temperatureControlled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}temperature_controlled'],
      )!,
      securityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}security_level'],
      )!,
      status: $InventoryLocationsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $InventoryLocationsTable createAlias(String alias) {
    return $InventoryLocationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LocationType, String, String>
  $converterlocationType = const EnumNameConverter<LocationType>(
    LocationType.values,
  );
  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class InventoryLocation extends DataClass
    implements Insertable<InventoryLocation> {
  final String locationId;
  final String businessId;
  final String branchId;
  final String locationName;
  final String locationCode;
  final LocationType locationType;
  final String? parentLocationId;
  final String? aisle;
  final String? shelf;
  final String? bin;
  final String? barcode;
  final int? maxCapacity;
  final int currentCapacity;
  final bool isSellableLocation;
  final bool requiresCounting;
  final bool temperatureControlled;
  final String securityLevel;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const InventoryLocation({
    required this.locationId,
    required this.businessId,
    required this.branchId,
    required this.locationName,
    required this.locationCode,
    required this.locationType,
    this.parentLocationId,
    this.aisle,
    this.shelf,
    this.bin,
    this.barcode,
    this.maxCapacity,
    required this.currentCapacity,
    required this.isSellableLocation,
    required this.requiresCounting,
    required this.temperatureControlled,
    required this.securityLevel,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['location_id'] = Variable<String>(locationId);
    map['business_id'] = Variable<String>(businessId);
    map['branch_id'] = Variable<String>(branchId);
    map['location_name'] = Variable<String>(locationName);
    map['location_code'] = Variable<String>(locationCode);
    {
      map['location_type'] = Variable<String>(
        $InventoryLocationsTable.$converterlocationType.toSql(locationType),
      );
    }
    if (!nullToAbsent || parentLocationId != null) {
      map['parent_location_id'] = Variable<String>(parentLocationId);
    }
    if (!nullToAbsent || aisle != null) {
      map['aisle'] = Variable<String>(aisle);
    }
    if (!nullToAbsent || shelf != null) {
      map['shelf'] = Variable<String>(shelf);
    }
    if (!nullToAbsent || bin != null) {
      map['bin'] = Variable<String>(bin);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || maxCapacity != null) {
      map['max_capacity'] = Variable<int>(maxCapacity);
    }
    map['current_capacity'] = Variable<int>(currentCapacity);
    map['is_sellable_location'] = Variable<bool>(isSellableLocation);
    map['requires_counting'] = Variable<bool>(requiresCounting);
    map['temperature_controlled'] = Variable<bool>(temperatureControlled);
    map['security_level'] = Variable<String>(securityLevel);
    {
      map['status'] = Variable<String>(
        $InventoryLocationsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  InventoryLocationsCompanion toCompanion(bool nullToAbsent) {
    return InventoryLocationsCompanion(
      locationId: Value(locationId),
      businessId: Value(businessId),
      branchId: Value(branchId),
      locationName: Value(locationName),
      locationCode: Value(locationCode),
      locationType: Value(locationType),
      parentLocationId: parentLocationId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentLocationId),
      aisle: aisle == null && nullToAbsent
          ? const Value.absent()
          : Value(aisle),
      shelf: shelf == null && nullToAbsent
          ? const Value.absent()
          : Value(shelf),
      bin: bin == null && nullToAbsent ? const Value.absent() : Value(bin),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      maxCapacity: maxCapacity == null && nullToAbsent
          ? const Value.absent()
          : Value(maxCapacity),
      currentCapacity: Value(currentCapacity),
      isSellableLocation: Value(isSellableLocation),
      requiresCounting: Value(requiresCounting),
      temperatureControlled: Value(temperatureControlled),
      securityLevel: Value(securityLevel),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory InventoryLocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryLocation(
      locationId: serializer.fromJson<String>(json['locationId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      locationName: serializer.fromJson<String>(json['locationName']),
      locationCode: serializer.fromJson<String>(json['locationCode']),
      locationType: $InventoryLocationsTable.$converterlocationType.fromJson(
        serializer.fromJson<String>(json['locationType']),
      ),
      parentLocationId: serializer.fromJson<String?>(json['parentLocationId']),
      aisle: serializer.fromJson<String?>(json['aisle']),
      shelf: serializer.fromJson<String?>(json['shelf']),
      bin: serializer.fromJson<String?>(json['bin']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      maxCapacity: serializer.fromJson<int?>(json['maxCapacity']),
      currentCapacity: serializer.fromJson<int>(json['currentCapacity']),
      isSellableLocation: serializer.fromJson<bool>(json['isSellableLocation']),
      requiresCounting: serializer.fromJson<bool>(json['requiresCounting']),
      temperatureControlled: serializer.fromJson<bool>(
        json['temperatureControlled'],
      ),
      securityLevel: serializer.fromJson<String>(json['securityLevel']),
      status: $InventoryLocationsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'locationId': serializer.toJson<String>(locationId),
      'businessId': serializer.toJson<String>(businessId),
      'branchId': serializer.toJson<String>(branchId),
      'locationName': serializer.toJson<String>(locationName),
      'locationCode': serializer.toJson<String>(locationCode),
      'locationType': serializer.toJson<String>(
        $InventoryLocationsTable.$converterlocationType.toJson(locationType),
      ),
      'parentLocationId': serializer.toJson<String?>(parentLocationId),
      'aisle': serializer.toJson<String?>(aisle),
      'shelf': serializer.toJson<String?>(shelf),
      'bin': serializer.toJson<String?>(bin),
      'barcode': serializer.toJson<String?>(barcode),
      'maxCapacity': serializer.toJson<int?>(maxCapacity),
      'currentCapacity': serializer.toJson<int>(currentCapacity),
      'isSellableLocation': serializer.toJson<bool>(isSellableLocation),
      'requiresCounting': serializer.toJson<bool>(requiresCounting),
      'temperatureControlled': serializer.toJson<bool>(temperatureControlled),
      'securityLevel': serializer.toJson<String>(securityLevel),
      'status': serializer.toJson<String>(
        $InventoryLocationsTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  InventoryLocation copyWith({
    String? locationId,
    String? businessId,
    String? branchId,
    String? locationName,
    String? locationCode,
    LocationType? locationType,
    Value<String?> parentLocationId = const Value.absent(),
    Value<String?> aisle = const Value.absent(),
    Value<String?> shelf = const Value.absent(),
    Value<String?> bin = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    Value<int?> maxCapacity = const Value.absent(),
    int? currentCapacity,
    bool? isSellableLocation,
    bool? requiresCounting,
    bool? temperatureControlled,
    String? securityLevel,
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => InventoryLocation(
    locationId: locationId ?? this.locationId,
    businessId: businessId ?? this.businessId,
    branchId: branchId ?? this.branchId,
    locationName: locationName ?? this.locationName,
    locationCode: locationCode ?? this.locationCode,
    locationType: locationType ?? this.locationType,
    parentLocationId: parentLocationId.present
        ? parentLocationId.value
        : this.parentLocationId,
    aisle: aisle.present ? aisle.value : this.aisle,
    shelf: shelf.present ? shelf.value : this.shelf,
    bin: bin.present ? bin.value : this.bin,
    barcode: barcode.present ? barcode.value : this.barcode,
    maxCapacity: maxCapacity.present ? maxCapacity.value : this.maxCapacity,
    currentCapacity: currentCapacity ?? this.currentCapacity,
    isSellableLocation: isSellableLocation ?? this.isSellableLocation,
    requiresCounting: requiresCounting ?? this.requiresCounting,
    temperatureControlled: temperatureControlled ?? this.temperatureControlled,
    securityLevel: securityLevel ?? this.securityLevel,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  InventoryLocation copyWithCompanion(InventoryLocationsCompanion data) {
    return InventoryLocation(
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      locationCode: data.locationCode.present
          ? data.locationCode.value
          : this.locationCode,
      locationType: data.locationType.present
          ? data.locationType.value
          : this.locationType,
      parentLocationId: data.parentLocationId.present
          ? data.parentLocationId.value
          : this.parentLocationId,
      aisle: data.aisle.present ? data.aisle.value : this.aisle,
      shelf: data.shelf.present ? data.shelf.value : this.shelf,
      bin: data.bin.present ? data.bin.value : this.bin,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      maxCapacity: data.maxCapacity.present
          ? data.maxCapacity.value
          : this.maxCapacity,
      currentCapacity: data.currentCapacity.present
          ? data.currentCapacity.value
          : this.currentCapacity,
      isSellableLocation: data.isSellableLocation.present
          ? data.isSellableLocation.value
          : this.isSellableLocation,
      requiresCounting: data.requiresCounting.present
          ? data.requiresCounting.value
          : this.requiresCounting,
      temperatureControlled: data.temperatureControlled.present
          ? data.temperatureControlled.value
          : this.temperatureControlled,
      securityLevel: data.securityLevel.present
          ? data.securityLevel.value
          : this.securityLevel,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLocation(')
          ..write('locationId: $locationId, ')
          ..write('businessId: $businessId, ')
          ..write('branchId: $branchId, ')
          ..write('locationName: $locationName, ')
          ..write('locationCode: $locationCode, ')
          ..write('locationType: $locationType, ')
          ..write('parentLocationId: $parentLocationId, ')
          ..write('aisle: $aisle, ')
          ..write('shelf: $shelf, ')
          ..write('bin: $bin, ')
          ..write('barcode: $barcode, ')
          ..write('maxCapacity: $maxCapacity, ')
          ..write('currentCapacity: $currentCapacity, ')
          ..write('isSellableLocation: $isSellableLocation, ')
          ..write('requiresCounting: $requiresCounting, ')
          ..write('temperatureControlled: $temperatureControlled, ')
          ..write('securityLevel: $securityLevel, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    locationId,
    businessId,
    branchId,
    locationName,
    locationCode,
    locationType,
    parentLocationId,
    aisle,
    shelf,
    bin,
    barcode,
    maxCapacity,
    currentCapacity,
    isSellableLocation,
    requiresCounting,
    temperatureControlled,
    securityLevel,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryLocation &&
          other.locationId == this.locationId &&
          other.businessId == this.businessId &&
          other.branchId == this.branchId &&
          other.locationName == this.locationName &&
          other.locationCode == this.locationCode &&
          other.locationType == this.locationType &&
          other.parentLocationId == this.parentLocationId &&
          other.aisle == this.aisle &&
          other.shelf == this.shelf &&
          other.bin == this.bin &&
          other.barcode == this.barcode &&
          other.maxCapacity == this.maxCapacity &&
          other.currentCapacity == this.currentCapacity &&
          other.isSellableLocation == this.isSellableLocation &&
          other.requiresCounting == this.requiresCounting &&
          other.temperatureControlled == this.temperatureControlled &&
          other.securityLevel == this.securityLevel &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class InventoryLocationsCompanion extends UpdateCompanion<InventoryLocation> {
  final Value<String> locationId;
  final Value<String> businessId;
  final Value<String> branchId;
  final Value<String> locationName;
  final Value<String> locationCode;
  final Value<LocationType> locationType;
  final Value<String?> parentLocationId;
  final Value<String?> aisle;
  final Value<String?> shelf;
  final Value<String?> bin;
  final Value<String?> barcode;
  final Value<int?> maxCapacity;
  final Value<int> currentCapacity;
  final Value<bool> isSellableLocation;
  final Value<bool> requiresCounting;
  final Value<bool> temperatureControlled;
  final Value<String> securityLevel;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const InventoryLocationsCompanion({
    this.locationId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.locationName = const Value.absent(),
    this.locationCode = const Value.absent(),
    this.locationType = const Value.absent(),
    this.parentLocationId = const Value.absent(),
    this.aisle = const Value.absent(),
    this.shelf = const Value.absent(),
    this.bin = const Value.absent(),
    this.barcode = const Value.absent(),
    this.maxCapacity = const Value.absent(),
    this.currentCapacity = const Value.absent(),
    this.isSellableLocation = const Value.absent(),
    this.requiresCounting = const Value.absent(),
    this.temperatureControlled = const Value.absent(),
    this.securityLevel = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryLocationsCompanion.insert({
    required String locationId,
    required String businessId,
    required String branchId,
    required String locationName,
    required String locationCode,
    required LocationType locationType,
    this.parentLocationId = const Value.absent(),
    this.aisle = const Value.absent(),
    this.shelf = const Value.absent(),
    this.bin = const Value.absent(),
    this.barcode = const Value.absent(),
    this.maxCapacity = const Value.absent(),
    this.currentCapacity = const Value.absent(),
    this.isSellableLocation = const Value.absent(),
    this.requiresCounting = const Value.absent(),
    this.temperatureControlled = const Value.absent(),
    this.securityLevel = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : locationId = Value(locationId),
       businessId = Value(businessId),
       branchId = Value(branchId),
       locationName = Value(locationName),
       locationCode = Value(locationCode),
       locationType = Value(locationType);
  static Insertable<InventoryLocation> custom({
    Expression<String>? locationId,
    Expression<String>? businessId,
    Expression<String>? branchId,
    Expression<String>? locationName,
    Expression<String>? locationCode,
    Expression<String>? locationType,
    Expression<String>? parentLocationId,
    Expression<String>? aisle,
    Expression<String>? shelf,
    Expression<String>? bin,
    Expression<String>? barcode,
    Expression<int>? maxCapacity,
    Expression<int>? currentCapacity,
    Expression<bool>? isSellableLocation,
    Expression<bool>? requiresCounting,
    Expression<bool>? temperatureControlled,
    Expression<String>? securityLevel,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (locationId != null) 'location_id': locationId,
      if (businessId != null) 'business_id': businessId,
      if (branchId != null) 'branch_id': branchId,
      if (locationName != null) 'location_name': locationName,
      if (locationCode != null) 'location_code': locationCode,
      if (locationType != null) 'location_type': locationType,
      if (parentLocationId != null) 'parent_location_id': parentLocationId,
      if (aisle != null) 'aisle': aisle,
      if (shelf != null) 'shelf': shelf,
      if (bin != null) 'bin': bin,
      if (barcode != null) 'barcode': barcode,
      if (maxCapacity != null) 'max_capacity': maxCapacity,
      if (currentCapacity != null) 'current_capacity': currentCapacity,
      if (isSellableLocation != null)
        'is_sellable_location': isSellableLocation,
      if (requiresCounting != null) 'requires_counting': requiresCounting,
      if (temperatureControlled != null)
        'temperature_controlled': temperatureControlled,
      if (securityLevel != null) 'security_level': securityLevel,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryLocationsCompanion copyWith({
    Value<String>? locationId,
    Value<String>? businessId,
    Value<String>? branchId,
    Value<String>? locationName,
    Value<String>? locationCode,
    Value<LocationType>? locationType,
    Value<String?>? parentLocationId,
    Value<String?>? aisle,
    Value<String?>? shelf,
    Value<String?>? bin,
    Value<String?>? barcode,
    Value<int?>? maxCapacity,
    Value<int>? currentCapacity,
    Value<bool>? isSellableLocation,
    Value<bool>? requiresCounting,
    Value<bool>? temperatureControlled,
    Value<String>? securityLevel,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return InventoryLocationsCompanion(
      locationId: locationId ?? this.locationId,
      businessId: businessId ?? this.businessId,
      branchId: branchId ?? this.branchId,
      locationName: locationName ?? this.locationName,
      locationCode: locationCode ?? this.locationCode,
      locationType: locationType ?? this.locationType,
      parentLocationId: parentLocationId ?? this.parentLocationId,
      aisle: aisle ?? this.aisle,
      shelf: shelf ?? this.shelf,
      bin: bin ?? this.bin,
      barcode: barcode ?? this.barcode,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      currentCapacity: currentCapacity ?? this.currentCapacity,
      isSellableLocation: isSellableLocation ?? this.isSellableLocation,
      requiresCounting: requiresCounting ?? this.requiresCounting,
      temperatureControlled:
          temperatureControlled ?? this.temperatureControlled,
      securityLevel: securityLevel ?? this.securityLevel,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (locationCode.present) {
      map['location_code'] = Variable<String>(locationCode.value);
    }
    if (locationType.present) {
      map['location_type'] = Variable<String>(
        $InventoryLocationsTable.$converterlocationType.toSql(
          locationType.value,
        ),
      );
    }
    if (parentLocationId.present) {
      map['parent_location_id'] = Variable<String>(parentLocationId.value);
    }
    if (aisle.present) {
      map['aisle'] = Variable<String>(aisle.value);
    }
    if (shelf.present) {
      map['shelf'] = Variable<String>(shelf.value);
    }
    if (bin.present) {
      map['bin'] = Variable<String>(bin.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (maxCapacity.present) {
      map['max_capacity'] = Variable<int>(maxCapacity.value);
    }
    if (currentCapacity.present) {
      map['current_capacity'] = Variable<int>(currentCapacity.value);
    }
    if (isSellableLocation.present) {
      map['is_sellable_location'] = Variable<bool>(isSellableLocation.value);
    }
    if (requiresCounting.present) {
      map['requires_counting'] = Variable<bool>(requiresCounting.value);
    }
    if (temperatureControlled.present) {
      map['temperature_controlled'] = Variable<bool>(
        temperatureControlled.value,
      );
    }
    if (securityLevel.present) {
      map['security_level'] = Variable<String>(securityLevel.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InventoryLocationsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLocationsCompanion(')
          ..write('locationId: $locationId, ')
          ..write('businessId: $businessId, ')
          ..write('branchId: $branchId, ')
          ..write('locationName: $locationName, ')
          ..write('locationCode: $locationCode, ')
          ..write('locationType: $locationType, ')
          ..write('parentLocationId: $parentLocationId, ')
          ..write('aisle: $aisle, ')
          ..write('shelf: $shelf, ')
          ..write('bin: $bin, ')
          ..write('barcode: $barcode, ')
          ..write('maxCapacity: $maxCapacity, ')
          ..write('currentCapacity: $currentCapacity, ')
          ..write('isSellableLocation: $isSellableLocation, ')
          ..write('requiresCounting: $requiresCounting, ')
          ..write('temperatureControlled: $temperatureControlled, ')
          ..write('securityLevel: $securityLevel, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryVariantsTable extends InventoryVariants
    with TableInfo<$InventoryVariantsTable, InventoryVariant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryVariantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inventoryIdMeta = const VerificationMeta(
    'inventoryId',
  );
  @override
  late final GeneratedColumn<String> inventoryId = GeneratedColumn<String>(
    'inventory_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorIdMeta = const VerificationMeta(
    'colorId',
  );
  @override
  late final GeneratedColumn<String> colorId = GeneratedColumn<String>(
    'color_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeIdMeta = const VerificationMeta('sizeId');
  @override
  late final GeneratedColumn<String> sizeId = GeneratedColumn<String>(
    'size_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variantSkuMeta = const VerificationMeta(
    'variantSku',
  );
  @override
  late final GeneratedColumn<String> variantSku = GeneratedColumn<String>(
    'variant_sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantBarcodeMeta = const VerificationMeta(
    'variantBarcode',
  );
  @override
  late final GeneratedColumn<String> variantBarcode = GeneratedColumn<String>(
    'variant_barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variantNameMeta = const VerificationMeta(
    'variantName',
  );
  @override
  late final GeneratedColumn<String> variantName = GeneratedColumn<String>(
    'variant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantCodeMeta = const VerificationMeta(
    'variantCode',
  );
  @override
  late final GeneratedColumn<String> variantCode = GeneratedColumn<String>(
    'variant_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPriceAdjustmentMeta =
      const VerificationMeta('costPriceAdjustment');
  @override
  late final GeneratedColumn<double> costPriceAdjustment =
      GeneratedColumn<double>(
        'cost_price_adjustment',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant<double>(0.00),
      );
  static const VerificationMeta _priceAdjustmentMeta = const VerificationMeta(
    'priceAdjustment',
  );
  @override
  late final GeneratedColumn<double> priceAdjustment = GeneratedColumn<double>(
    'price_adjustment',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant<double>(0.00),
  );
  static const VerificationMeta _finalCostPriceMeta = const VerificationMeta(
    'finalCostPrice',
  );
  @override
  late final GeneratedColumn<double> finalCostPrice = GeneratedColumn<double>(
    'final_cost_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalRetailPriceMeta = const VerificationMeta(
    'finalRetailPrice',
  );
  @override
  late final GeneratedColumn<double> finalRetailPrice = GeneratedColumn<double>(
    'final_retail_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variantDescriptionMeta =
      const VerificationMeta('variantDescription');
  @override
  late final GeneratedColumn<String> variantDescription =
      GeneratedColumn<String>(
        'variant_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _variantSpecificationsMeta =
      const VerificationMeta('variantSpecifications');
  @override
  late final GeneratedColumn<String> variantSpecifications =
      GeneratedColumn<String>(
        'variant_specifications',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _variantImagesMeta = const VerificationMeta(
    'variantImages',
  );
  @override
  late final GeneratedColumn<String> variantImages = GeneratedColumn<String>(
    'variant_images',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightAdjustmentMeta = const VerificationMeta(
    'weightAdjustment',
  );
  @override
  late final GeneratedColumn<double> weightAdjustment = GeneratedColumn<double>(
    'weight_adjustment',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant<double>(0.000),
  );
  static const VerificationMeta _dimensionAdjustmentsMeta =
      const VerificationMeta('dimensionAdjustments');
  @override
  late final GeneratedColumn<String> dimensionAdjustments =
      GeneratedColumn<String>(
        'dimension_adjustments',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _minimumStockLevelMeta = const VerificationMeta(
    'minimumStockLevel',
  );
  @override
  late final GeneratedColumn<int> minimumStockLevel = GeneratedColumn<int>(
    'minimum_stock_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _reorderLevelMeta = const VerificationMeta(
    'reorderLevel',
  );
  @override
  late final GeneratedColumn<int> reorderLevel = GeneratedColumn<int>(
    'reorder_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _maximumStockLevelMeta = const VerificationMeta(
    'maximumStockLevel',
  );
  @override
  late final GeneratedColumn<int> maximumStockLevel = GeneratedColumn<int>(
    'maximum_stock_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultVariantMeta = const VerificationMeta(
    'isDefaultVariant',
  );
  @override
  late final GeneratedColumn<bool> isDefaultVariant = GeneratedColumn<bool>(
    'is_default_variant',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default_variant" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(false),
  );
  static const VerificationMeta _isAvailableOnlineMeta = const VerificationMeta(
    'isAvailableOnline',
  );
  @override
  late final GeneratedColumn<bool> isAvailableOnline = GeneratedColumn<bool>(
    'is_available_online',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available_online" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(true),
  );
  static const VerificationMeta _isAvailableInStoreMeta =
      const VerificationMeta('isAvailableInStore');
  @override
  late final GeneratedColumn<bool> isAvailableInStore = GeneratedColumn<bool>(
    'is_available_in_store',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available_in_store" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(true),
  );
  static const VerificationMeta _availabilityDateMeta = const VerificationMeta(
    'availabilityDate',
  );
  @override
  late final GeneratedColumn<DateTime> availabilityDate =
      GeneratedColumn<DateTime>(
        'availability_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _discontinueDateMeta = const VerificationMeta(
    'discontinueDate',
  );
  @override
  late final GeneratedColumn<DateTime> discontinueDate =
      GeneratedColumn<DateTime>(
        'discontinue_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<StatusType, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant<String>('active'),
      ).withConverter<StatusType>($InventoryVariantsTable.$converterstatus);
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant<String>('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    variantId,
    inventoryId,
    businessId,
    colorId,
    sizeId,
    variantSku,
    variantBarcode,
    variantName,
    variantCode,
    costPriceAdjustment,
    priceAdjustment,
    finalCostPrice,
    finalRetailPrice,
    variantDescription,
    variantSpecifications,
    variantImages,
    weightAdjustment,
    dimensionAdjustments,
    minimumStockLevel,
    reorderLevel,
    maximumStockLevel,
    isDefaultVariant,
    isAvailableOnline,
    isAvailableInStore,
    availabilityDate,
    discontinueDate,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_variants';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryVariant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('inventory_id')) {
      context.handle(
        _inventoryIdMeta,
        inventoryId.isAcceptableOrUnknown(
          data['inventory_id']!,
          _inventoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inventoryIdMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('color_id')) {
      context.handle(
        _colorIdMeta,
        colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta),
      );
    }
    if (data.containsKey('size_id')) {
      context.handle(
        _sizeIdMeta,
        sizeId.isAcceptableOrUnknown(data['size_id']!, _sizeIdMeta),
      );
    }
    if (data.containsKey('variant_sku')) {
      context.handle(
        _variantSkuMeta,
        variantSku.isAcceptableOrUnknown(data['variant_sku']!, _variantSkuMeta),
      );
    } else if (isInserting) {
      context.missing(_variantSkuMeta);
    }
    if (data.containsKey('variant_barcode')) {
      context.handle(
        _variantBarcodeMeta,
        variantBarcode.isAcceptableOrUnknown(
          data['variant_barcode']!,
          _variantBarcodeMeta,
        ),
      );
    }
    if (data.containsKey('variant_name')) {
      context.handle(
        _variantNameMeta,
        variantName.isAcceptableOrUnknown(
          data['variant_name']!,
          _variantNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_variantNameMeta);
    }
    if (data.containsKey('variant_code')) {
      context.handle(
        _variantCodeMeta,
        variantCode.isAcceptableOrUnknown(
          data['variant_code']!,
          _variantCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_variantCodeMeta);
    }
    if (data.containsKey('cost_price_adjustment')) {
      context.handle(
        _costPriceAdjustmentMeta,
        costPriceAdjustment.isAcceptableOrUnknown(
          data['cost_price_adjustment']!,
          _costPriceAdjustmentMeta,
        ),
      );
    }
    if (data.containsKey('price_adjustment')) {
      context.handle(
        _priceAdjustmentMeta,
        priceAdjustment.isAcceptableOrUnknown(
          data['price_adjustment']!,
          _priceAdjustmentMeta,
        ),
      );
    }
    if (data.containsKey('final_cost_price')) {
      context.handle(
        _finalCostPriceMeta,
        finalCostPrice.isAcceptableOrUnknown(
          data['final_cost_price']!,
          _finalCostPriceMeta,
        ),
      );
    }
    if (data.containsKey('final_retail_price')) {
      context.handle(
        _finalRetailPriceMeta,
        finalRetailPrice.isAcceptableOrUnknown(
          data['final_retail_price']!,
          _finalRetailPriceMeta,
        ),
      );
    }
    if (data.containsKey('variant_description')) {
      context.handle(
        _variantDescriptionMeta,
        variantDescription.isAcceptableOrUnknown(
          data['variant_description']!,
          _variantDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('variant_specifications')) {
      context.handle(
        _variantSpecificationsMeta,
        variantSpecifications.isAcceptableOrUnknown(
          data['variant_specifications']!,
          _variantSpecificationsMeta,
        ),
      );
    }
    if (data.containsKey('variant_images')) {
      context.handle(
        _variantImagesMeta,
        variantImages.isAcceptableOrUnknown(
          data['variant_images']!,
          _variantImagesMeta,
        ),
      );
    }
    if (data.containsKey('weight_adjustment')) {
      context.handle(
        _weightAdjustmentMeta,
        weightAdjustment.isAcceptableOrUnknown(
          data['weight_adjustment']!,
          _weightAdjustmentMeta,
        ),
      );
    }
    if (data.containsKey('dimension_adjustments')) {
      context.handle(
        _dimensionAdjustmentsMeta,
        dimensionAdjustments.isAcceptableOrUnknown(
          data['dimension_adjustments']!,
          _dimensionAdjustmentsMeta,
        ),
      );
    }
    if (data.containsKey('minimum_stock_level')) {
      context.handle(
        _minimumStockLevelMeta,
        minimumStockLevel.isAcceptableOrUnknown(
          data['minimum_stock_level']!,
          _minimumStockLevelMeta,
        ),
      );
    }
    if (data.containsKey('reorder_level')) {
      context.handle(
        _reorderLevelMeta,
        reorderLevel.isAcceptableOrUnknown(
          data['reorder_level']!,
          _reorderLevelMeta,
        ),
      );
    }
    if (data.containsKey('maximum_stock_level')) {
      context.handle(
        _maximumStockLevelMeta,
        maximumStockLevel.isAcceptableOrUnknown(
          data['maximum_stock_level']!,
          _maximumStockLevelMeta,
        ),
      );
    }
    if (data.containsKey('is_default_variant')) {
      context.handle(
        _isDefaultVariantMeta,
        isDefaultVariant.isAcceptableOrUnknown(
          data['is_default_variant']!,
          _isDefaultVariantMeta,
        ),
      );
    }
    if (data.containsKey('is_available_online')) {
      context.handle(
        _isAvailableOnlineMeta,
        isAvailableOnline.isAcceptableOrUnknown(
          data['is_available_online']!,
          _isAvailableOnlineMeta,
        ),
      );
    }
    if (data.containsKey('is_available_in_store')) {
      context.handle(
        _isAvailableInStoreMeta,
        isAvailableInStore.isAcceptableOrUnknown(
          data['is_available_in_store']!,
          _isAvailableInStoreMeta,
        ),
      );
    }
    if (data.containsKey('availability_date')) {
      context.handle(
        _availabilityDateMeta,
        availabilityDate.isAcceptableOrUnknown(
          data['availability_date']!,
          _availabilityDateMeta,
        ),
      );
    }
    if (data.containsKey('discontinue_date')) {
      context.handle(
        _discontinueDateMeta,
        discontinueDate.isAcceptableOrUnknown(
          data['discontinue_date']!,
          _discontinueDateMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {variantId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {variantSku},
    {variantBarcode},
    {inventoryId, colorId, sizeId},
  ];
  @override
  InventoryVariant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryVariant(
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      )!,
      inventoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inventory_id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      colorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_id'],
      ),
      sizeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_id'],
      ),
      variantSku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_sku'],
      )!,
      variantBarcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_barcode'],
      ),
      variantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_name'],
      )!,
      variantCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_code'],
      )!,
      costPriceAdjustment: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_price_adjustment'],
      )!,
      priceAdjustment: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_adjustment'],
      )!,
      finalCostPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_cost_price'],
      ),
      finalRetailPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_retail_price'],
      ),
      variantDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_description'],
      ),
      variantSpecifications: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_specifications'],
      ),
      variantImages: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_images'],
      ),
      weightAdjustment: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_adjustment'],
      )!,
      dimensionAdjustments: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dimension_adjustments'],
      ),
      minimumStockLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minimum_stock_level'],
      )!,
      reorderLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reorder_level'],
      )!,
      maximumStockLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maximum_stock_level'],
      ),
      isDefaultVariant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default_variant'],
      )!,
      isAvailableOnline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available_online'],
      )!,
      isAvailableInStore: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available_in_store'],
      )!,
      availabilityDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}availability_date'],
      ),
      discontinueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}discontinue_date'],
      ),
      status: $InventoryVariantsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $InventoryVariantsTable createAlias(String alias) {
    return $InventoryVariantsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StatusType, String, String> $converterstatus =
      const EnumNameConverter<StatusType>(StatusType.values);
}

class InventoryVariant extends DataClass
    implements Insertable<InventoryVariant> {
  final String variantId;
  final String inventoryId;
  final String businessId;
  final String? colorId;
  final String? sizeId;
  final String variantSku;
  final String? variantBarcode;
  final String variantName;
  final String variantCode;
  final double costPriceAdjustment;
  final double priceAdjustment;
  final double? finalCostPrice;
  final double? finalRetailPrice;
  final String? variantDescription;
  final String? variantSpecifications;
  final String? variantImages;
  final double weightAdjustment;
  final String? dimensionAdjustments;
  final int minimumStockLevel;
  final int reorderLevel;
  final int? maximumStockLevel;
  final bool isDefaultVariant;
  final bool isAvailableOnline;
  final bool isAvailableInStore;
  final DateTime? availabilityDate;
  final DateTime? discontinueDate;
  final StatusType status;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const InventoryVariant({
    required this.variantId,
    required this.inventoryId,
    required this.businessId,
    this.colorId,
    this.sizeId,
    required this.variantSku,
    this.variantBarcode,
    required this.variantName,
    required this.variantCode,
    required this.costPriceAdjustment,
    required this.priceAdjustment,
    this.finalCostPrice,
    this.finalRetailPrice,
    this.variantDescription,
    this.variantSpecifications,
    this.variantImages,
    required this.weightAdjustment,
    this.dimensionAdjustments,
    required this.minimumStockLevel,
    required this.reorderLevel,
    this.maximumStockLevel,
    required this.isDefaultVariant,
    required this.isAvailableOnline,
    required this.isAvailableInStore,
    this.availabilityDate,
    this.discontinueDate,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['variant_id'] = Variable<String>(variantId);
    map['inventory_id'] = Variable<String>(inventoryId);
    map['business_id'] = Variable<String>(businessId);
    if (!nullToAbsent || colorId != null) {
      map['color_id'] = Variable<String>(colorId);
    }
    if (!nullToAbsent || sizeId != null) {
      map['size_id'] = Variable<String>(sizeId);
    }
    map['variant_sku'] = Variable<String>(variantSku);
    if (!nullToAbsent || variantBarcode != null) {
      map['variant_barcode'] = Variable<String>(variantBarcode);
    }
    map['variant_name'] = Variable<String>(variantName);
    map['variant_code'] = Variable<String>(variantCode);
    map['cost_price_adjustment'] = Variable<double>(costPriceAdjustment);
    map['price_adjustment'] = Variable<double>(priceAdjustment);
    if (!nullToAbsent || finalCostPrice != null) {
      map['final_cost_price'] = Variable<double>(finalCostPrice);
    }
    if (!nullToAbsent || finalRetailPrice != null) {
      map['final_retail_price'] = Variable<double>(finalRetailPrice);
    }
    if (!nullToAbsent || variantDescription != null) {
      map['variant_description'] = Variable<String>(variantDescription);
    }
    if (!nullToAbsent || variantSpecifications != null) {
      map['variant_specifications'] = Variable<String>(variantSpecifications);
    }
    if (!nullToAbsent || variantImages != null) {
      map['variant_images'] = Variable<String>(variantImages);
    }
    map['weight_adjustment'] = Variable<double>(weightAdjustment);
    if (!nullToAbsent || dimensionAdjustments != null) {
      map['dimension_adjustments'] = Variable<String>(dimensionAdjustments);
    }
    map['minimum_stock_level'] = Variable<int>(minimumStockLevel);
    map['reorder_level'] = Variable<int>(reorderLevel);
    if (!nullToAbsent || maximumStockLevel != null) {
      map['maximum_stock_level'] = Variable<int>(maximumStockLevel);
    }
    map['is_default_variant'] = Variable<bool>(isDefaultVariant);
    map['is_available_online'] = Variable<bool>(isAvailableOnline);
    map['is_available_in_store'] = Variable<bool>(isAvailableInStore);
    if (!nullToAbsent || availabilityDate != null) {
      map['availability_date'] = Variable<DateTime>(availabilityDate);
    }
    if (!nullToAbsent || discontinueDate != null) {
      map['discontinue_date'] = Variable<DateTime>(discontinueDate);
    }
    {
      map['status'] = Variable<String>(
        $InventoryVariantsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  InventoryVariantsCompanion toCompanion(bool nullToAbsent) {
    return InventoryVariantsCompanion(
      variantId: Value(variantId),
      inventoryId: Value(inventoryId),
      businessId: Value(businessId),
      colorId: colorId == null && nullToAbsent
          ? const Value.absent()
          : Value(colorId),
      sizeId: sizeId == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeId),
      variantSku: Value(variantSku),
      variantBarcode: variantBarcode == null && nullToAbsent
          ? const Value.absent()
          : Value(variantBarcode),
      variantName: Value(variantName),
      variantCode: Value(variantCode),
      costPriceAdjustment: Value(costPriceAdjustment),
      priceAdjustment: Value(priceAdjustment),
      finalCostPrice: finalCostPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(finalCostPrice),
      finalRetailPrice: finalRetailPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(finalRetailPrice),
      variantDescription: variantDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(variantDescription),
      variantSpecifications: variantSpecifications == null && nullToAbsent
          ? const Value.absent()
          : Value(variantSpecifications),
      variantImages: variantImages == null && nullToAbsent
          ? const Value.absent()
          : Value(variantImages),
      weightAdjustment: Value(weightAdjustment),
      dimensionAdjustments: dimensionAdjustments == null && nullToAbsent
          ? const Value.absent()
          : Value(dimensionAdjustments),
      minimumStockLevel: Value(minimumStockLevel),
      reorderLevel: Value(reorderLevel),
      maximumStockLevel: maximumStockLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(maximumStockLevel),
      isDefaultVariant: Value(isDefaultVariant),
      isAvailableOnline: Value(isAvailableOnline),
      isAvailableInStore: Value(isAvailableInStore),
      availabilityDate: availabilityDate == null && nullToAbsent
          ? const Value.absent()
          : Value(availabilityDate),
      discontinueDate: discontinueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(discontinueDate),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory InventoryVariant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryVariant(
      variantId: serializer.fromJson<String>(json['variantId']),
      inventoryId: serializer.fromJson<String>(json['inventoryId']),
      businessId: serializer.fromJson<String>(json['businessId']),
      colorId: serializer.fromJson<String?>(json['colorId']),
      sizeId: serializer.fromJson<String?>(json['sizeId']),
      variantSku: serializer.fromJson<String>(json['variantSku']),
      variantBarcode: serializer.fromJson<String?>(json['variantBarcode']),
      variantName: serializer.fromJson<String>(json['variantName']),
      variantCode: serializer.fromJson<String>(json['variantCode']),
      costPriceAdjustment: serializer.fromJson<double>(
        json['costPriceAdjustment'],
      ),
      priceAdjustment: serializer.fromJson<double>(json['priceAdjustment']),
      finalCostPrice: serializer.fromJson<double?>(json['finalCostPrice']),
      finalRetailPrice: serializer.fromJson<double?>(json['finalRetailPrice']),
      variantDescription: serializer.fromJson<String?>(
        json['variantDescription'],
      ),
      variantSpecifications: serializer.fromJson<String?>(
        json['variantSpecifications'],
      ),
      variantImages: serializer.fromJson<String?>(json['variantImages']),
      weightAdjustment: serializer.fromJson<double>(json['weightAdjustment']),
      dimensionAdjustments: serializer.fromJson<String?>(
        json['dimensionAdjustments'],
      ),
      minimumStockLevel: serializer.fromJson<int>(json['minimumStockLevel']),
      reorderLevel: serializer.fromJson<int>(json['reorderLevel']),
      maximumStockLevel: serializer.fromJson<int?>(json['maximumStockLevel']),
      isDefaultVariant: serializer.fromJson<bool>(json['isDefaultVariant']),
      isAvailableOnline: serializer.fromJson<bool>(json['isAvailableOnline']),
      isAvailableInStore: serializer.fromJson<bool>(json['isAvailableInStore']),
      availabilityDate: serializer.fromJson<DateTime?>(
        json['availabilityDate'],
      ),
      discontinueDate: serializer.fromJson<DateTime?>(json['discontinueDate']),
      status: $InventoryVariantsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'variantId': serializer.toJson<String>(variantId),
      'inventoryId': serializer.toJson<String>(inventoryId),
      'businessId': serializer.toJson<String>(businessId),
      'colorId': serializer.toJson<String?>(colorId),
      'sizeId': serializer.toJson<String?>(sizeId),
      'variantSku': serializer.toJson<String>(variantSku),
      'variantBarcode': serializer.toJson<String?>(variantBarcode),
      'variantName': serializer.toJson<String>(variantName),
      'variantCode': serializer.toJson<String>(variantCode),
      'costPriceAdjustment': serializer.toJson<double>(costPriceAdjustment),
      'priceAdjustment': serializer.toJson<double>(priceAdjustment),
      'finalCostPrice': serializer.toJson<double?>(finalCostPrice),
      'finalRetailPrice': serializer.toJson<double?>(finalRetailPrice),
      'variantDescription': serializer.toJson<String?>(variantDescription),
      'variantSpecifications': serializer.toJson<String?>(
        variantSpecifications,
      ),
      'variantImages': serializer.toJson<String?>(variantImages),
      'weightAdjustment': serializer.toJson<double>(weightAdjustment),
      'dimensionAdjustments': serializer.toJson<String?>(dimensionAdjustments),
      'minimumStockLevel': serializer.toJson<int>(minimumStockLevel),
      'reorderLevel': serializer.toJson<int>(reorderLevel),
      'maximumStockLevel': serializer.toJson<int?>(maximumStockLevel),
      'isDefaultVariant': serializer.toJson<bool>(isDefaultVariant),
      'isAvailableOnline': serializer.toJson<bool>(isAvailableOnline),
      'isAvailableInStore': serializer.toJson<bool>(isAvailableInStore),
      'availabilityDate': serializer.toJson<DateTime?>(availabilityDate),
      'discontinueDate': serializer.toJson<DateTime?>(discontinueDate),
      'status': serializer.toJson<String>(
        $InventoryVariantsTable.$converterstatus.toJson(status),
      ),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  InventoryVariant copyWith({
    String? variantId,
    String? inventoryId,
    String? businessId,
    Value<String?> colorId = const Value.absent(),
    Value<String?> sizeId = const Value.absent(),
    String? variantSku,
    Value<String?> variantBarcode = const Value.absent(),
    String? variantName,
    String? variantCode,
    double? costPriceAdjustment,
    double? priceAdjustment,
    Value<double?> finalCostPrice = const Value.absent(),
    Value<double?> finalRetailPrice = const Value.absent(),
    Value<String?> variantDescription = const Value.absent(),
    Value<String?> variantSpecifications = const Value.absent(),
    Value<String?> variantImages = const Value.absent(),
    double? weightAdjustment,
    Value<String?> dimensionAdjustments = const Value.absent(),
    int? minimumStockLevel,
    int? reorderLevel,
    Value<int?> maximumStockLevel = const Value.absent(),
    bool? isDefaultVariant,
    bool? isAvailableOnline,
    bool? isAvailableInStore,
    Value<DateTime?> availabilityDate = const Value.absent(),
    Value<DateTime?> discontinueDate = const Value.absent(),
    StatusType? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => InventoryVariant(
    variantId: variantId ?? this.variantId,
    inventoryId: inventoryId ?? this.inventoryId,
    businessId: businessId ?? this.businessId,
    colorId: colorId.present ? colorId.value : this.colorId,
    sizeId: sizeId.present ? sizeId.value : this.sizeId,
    variantSku: variantSku ?? this.variantSku,
    variantBarcode: variantBarcode.present
        ? variantBarcode.value
        : this.variantBarcode,
    variantName: variantName ?? this.variantName,
    variantCode: variantCode ?? this.variantCode,
    costPriceAdjustment: costPriceAdjustment ?? this.costPriceAdjustment,
    priceAdjustment: priceAdjustment ?? this.priceAdjustment,
    finalCostPrice: finalCostPrice.present
        ? finalCostPrice.value
        : this.finalCostPrice,
    finalRetailPrice: finalRetailPrice.present
        ? finalRetailPrice.value
        : this.finalRetailPrice,
    variantDescription: variantDescription.present
        ? variantDescription.value
        : this.variantDescription,
    variantSpecifications: variantSpecifications.present
        ? variantSpecifications.value
        : this.variantSpecifications,
    variantImages: variantImages.present
        ? variantImages.value
        : this.variantImages,
    weightAdjustment: weightAdjustment ?? this.weightAdjustment,
    dimensionAdjustments: dimensionAdjustments.present
        ? dimensionAdjustments.value
        : this.dimensionAdjustments,
    minimumStockLevel: minimumStockLevel ?? this.minimumStockLevel,
    reorderLevel: reorderLevel ?? this.reorderLevel,
    maximumStockLevel: maximumStockLevel.present
        ? maximumStockLevel.value
        : this.maximumStockLevel,
    isDefaultVariant: isDefaultVariant ?? this.isDefaultVariant,
    isAvailableOnline: isAvailableOnline ?? this.isAvailableOnline,
    isAvailableInStore: isAvailableInStore ?? this.isAvailableInStore,
    availabilityDate: availabilityDate.present
        ? availabilityDate.value
        : this.availabilityDate,
    discontinueDate: discontinueDate.present
        ? discontinueDate.value
        : this.discontinueDate,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  InventoryVariant copyWithCompanion(InventoryVariantsCompanion data) {
    return InventoryVariant(
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      inventoryId: data.inventoryId.present
          ? data.inventoryId.value
          : this.inventoryId,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      colorId: data.colorId.present ? data.colorId.value : this.colorId,
      sizeId: data.sizeId.present ? data.sizeId.value : this.sizeId,
      variantSku: data.variantSku.present
          ? data.variantSku.value
          : this.variantSku,
      variantBarcode: data.variantBarcode.present
          ? data.variantBarcode.value
          : this.variantBarcode,
      variantName: data.variantName.present
          ? data.variantName.value
          : this.variantName,
      variantCode: data.variantCode.present
          ? data.variantCode.value
          : this.variantCode,
      costPriceAdjustment: data.costPriceAdjustment.present
          ? data.costPriceAdjustment.value
          : this.costPriceAdjustment,
      priceAdjustment: data.priceAdjustment.present
          ? data.priceAdjustment.value
          : this.priceAdjustment,
      finalCostPrice: data.finalCostPrice.present
          ? data.finalCostPrice.value
          : this.finalCostPrice,
      finalRetailPrice: data.finalRetailPrice.present
          ? data.finalRetailPrice.value
          : this.finalRetailPrice,
      variantDescription: data.variantDescription.present
          ? data.variantDescription.value
          : this.variantDescription,
      variantSpecifications: data.variantSpecifications.present
          ? data.variantSpecifications.value
          : this.variantSpecifications,
      variantImages: data.variantImages.present
          ? data.variantImages.value
          : this.variantImages,
      weightAdjustment: data.weightAdjustment.present
          ? data.weightAdjustment.value
          : this.weightAdjustment,
      dimensionAdjustments: data.dimensionAdjustments.present
          ? data.dimensionAdjustments.value
          : this.dimensionAdjustments,
      minimumStockLevel: data.minimumStockLevel.present
          ? data.minimumStockLevel.value
          : this.minimumStockLevel,
      reorderLevel: data.reorderLevel.present
          ? data.reorderLevel.value
          : this.reorderLevel,
      maximumStockLevel: data.maximumStockLevel.present
          ? data.maximumStockLevel.value
          : this.maximumStockLevel,
      isDefaultVariant: data.isDefaultVariant.present
          ? data.isDefaultVariant.value
          : this.isDefaultVariant,
      isAvailableOnline: data.isAvailableOnline.present
          ? data.isAvailableOnline.value
          : this.isAvailableOnline,
      isAvailableInStore: data.isAvailableInStore.present
          ? data.isAvailableInStore.value
          : this.isAvailableInStore,
      availabilityDate: data.availabilityDate.present
          ? data.availabilityDate.value
          : this.availabilityDate,
      discontinueDate: data.discontinueDate.present
          ? data.discontinueDate.value
          : this.discontinueDate,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryVariant(')
          ..write('variantId: $variantId, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('businessId: $businessId, ')
          ..write('colorId: $colorId, ')
          ..write('sizeId: $sizeId, ')
          ..write('variantSku: $variantSku, ')
          ..write('variantBarcode: $variantBarcode, ')
          ..write('variantName: $variantName, ')
          ..write('variantCode: $variantCode, ')
          ..write('costPriceAdjustment: $costPriceAdjustment, ')
          ..write('priceAdjustment: $priceAdjustment, ')
          ..write('finalCostPrice: $finalCostPrice, ')
          ..write('finalRetailPrice: $finalRetailPrice, ')
          ..write('variantDescription: $variantDescription, ')
          ..write('variantSpecifications: $variantSpecifications, ')
          ..write('variantImages: $variantImages, ')
          ..write('weightAdjustment: $weightAdjustment, ')
          ..write('dimensionAdjustments: $dimensionAdjustments, ')
          ..write('minimumStockLevel: $minimumStockLevel, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('maximumStockLevel: $maximumStockLevel, ')
          ..write('isDefaultVariant: $isDefaultVariant, ')
          ..write('isAvailableOnline: $isAvailableOnline, ')
          ..write('isAvailableInStore: $isAvailableInStore, ')
          ..write('availabilityDate: $availabilityDate, ')
          ..write('discontinueDate: $discontinueDate, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    variantId,
    inventoryId,
    businessId,
    colorId,
    sizeId,
    variantSku,
    variantBarcode,
    variantName,
    variantCode,
    costPriceAdjustment,
    priceAdjustment,
    finalCostPrice,
    finalRetailPrice,
    variantDescription,
    variantSpecifications,
    variantImages,
    weightAdjustment,
    dimensionAdjustments,
    minimumStockLevel,
    reorderLevel,
    maximumStockLevel,
    isDefaultVariant,
    isAvailableOnline,
    isAvailableInStore,
    availabilityDate,
    discontinueDate,
    status,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
    syncStatus,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryVariant &&
          other.variantId == this.variantId &&
          other.inventoryId == this.inventoryId &&
          other.businessId == this.businessId &&
          other.colorId == this.colorId &&
          other.sizeId == this.sizeId &&
          other.variantSku == this.variantSku &&
          other.variantBarcode == this.variantBarcode &&
          other.variantName == this.variantName &&
          other.variantCode == this.variantCode &&
          other.costPriceAdjustment == this.costPriceAdjustment &&
          other.priceAdjustment == this.priceAdjustment &&
          other.finalCostPrice == this.finalCostPrice &&
          other.finalRetailPrice == this.finalRetailPrice &&
          other.variantDescription == this.variantDescription &&
          other.variantSpecifications == this.variantSpecifications &&
          other.variantImages == this.variantImages &&
          other.weightAdjustment == this.weightAdjustment &&
          other.dimensionAdjustments == this.dimensionAdjustments &&
          other.minimumStockLevel == this.minimumStockLevel &&
          other.reorderLevel == this.reorderLevel &&
          other.maximumStockLevel == this.maximumStockLevel &&
          other.isDefaultVariant == this.isDefaultVariant &&
          other.isAvailableOnline == this.isAvailableOnline &&
          other.isAvailableInStore == this.isAvailableInStore &&
          other.availabilityDate == this.availabilityDate &&
          other.discontinueDate == this.discontinueDate &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class InventoryVariantsCompanion extends UpdateCompanion<InventoryVariant> {
  final Value<String> variantId;
  final Value<String> inventoryId;
  final Value<String> businessId;
  final Value<String?> colorId;
  final Value<String?> sizeId;
  final Value<String> variantSku;
  final Value<String?> variantBarcode;
  final Value<String> variantName;
  final Value<String> variantCode;
  final Value<double> costPriceAdjustment;
  final Value<double> priceAdjustment;
  final Value<double?> finalCostPrice;
  final Value<double?> finalRetailPrice;
  final Value<String?> variantDescription;
  final Value<String?> variantSpecifications;
  final Value<String?> variantImages;
  final Value<double> weightAdjustment;
  final Value<String?> dimensionAdjustments;
  final Value<int> minimumStockLevel;
  final Value<int> reorderLevel;
  final Value<int?> maximumStockLevel;
  final Value<bool> isDefaultVariant;
  final Value<bool> isAvailableOnline;
  final Value<bool> isAvailableInStore;
  final Value<DateTime?> availabilityDate;
  final Value<DateTime?> discontinueDate;
  final Value<StatusType> status;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const InventoryVariantsCompanion({
    this.variantId = const Value.absent(),
    this.inventoryId = const Value.absent(),
    this.businessId = const Value.absent(),
    this.colorId = const Value.absent(),
    this.sizeId = const Value.absent(),
    this.variantSku = const Value.absent(),
    this.variantBarcode = const Value.absent(),
    this.variantName = const Value.absent(),
    this.variantCode = const Value.absent(),
    this.costPriceAdjustment = const Value.absent(),
    this.priceAdjustment = const Value.absent(),
    this.finalCostPrice = const Value.absent(),
    this.finalRetailPrice = const Value.absent(),
    this.variantDescription = const Value.absent(),
    this.variantSpecifications = const Value.absent(),
    this.variantImages = const Value.absent(),
    this.weightAdjustment = const Value.absent(),
    this.dimensionAdjustments = const Value.absent(),
    this.minimumStockLevel = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.maximumStockLevel = const Value.absent(),
    this.isDefaultVariant = const Value.absent(),
    this.isAvailableOnline = const Value.absent(),
    this.isAvailableInStore = const Value.absent(),
    this.availabilityDate = const Value.absent(),
    this.discontinueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryVariantsCompanion.insert({
    required String variantId,
    required String inventoryId,
    required String businessId,
    this.colorId = const Value.absent(),
    this.sizeId = const Value.absent(),
    required String variantSku,
    this.variantBarcode = const Value.absent(),
    required String variantName,
    required String variantCode,
    this.costPriceAdjustment = const Value.absent(),
    this.priceAdjustment = const Value.absent(),
    this.finalCostPrice = const Value.absent(),
    this.finalRetailPrice = const Value.absent(),
    this.variantDescription = const Value.absent(),
    this.variantSpecifications = const Value.absent(),
    this.variantImages = const Value.absent(),
    this.weightAdjustment = const Value.absent(),
    this.dimensionAdjustments = const Value.absent(),
    this.minimumStockLevel = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.maximumStockLevel = const Value.absent(),
    this.isDefaultVariant = const Value.absent(),
    this.isAvailableOnline = const Value.absent(),
    this.isAvailableInStore = const Value.absent(),
    this.availabilityDate = const Value.absent(),
    this.discontinueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : variantId = Value(variantId),
       inventoryId = Value(inventoryId),
       businessId = Value(businessId),
       variantSku = Value(variantSku),
       variantName = Value(variantName),
       variantCode = Value(variantCode);
  static Insertable<InventoryVariant> custom({
    Expression<String>? variantId,
    Expression<String>? inventoryId,
    Expression<String>? businessId,
    Expression<String>? colorId,
    Expression<String>? sizeId,
    Expression<String>? variantSku,
    Expression<String>? variantBarcode,
    Expression<String>? variantName,
    Expression<String>? variantCode,
    Expression<double>? costPriceAdjustment,
    Expression<double>? priceAdjustment,
    Expression<double>? finalCostPrice,
    Expression<double>? finalRetailPrice,
    Expression<String>? variantDescription,
    Expression<String>? variantSpecifications,
    Expression<String>? variantImages,
    Expression<double>? weightAdjustment,
    Expression<String>? dimensionAdjustments,
    Expression<int>? minimumStockLevel,
    Expression<int>? reorderLevel,
    Expression<int>? maximumStockLevel,
    Expression<bool>? isDefaultVariant,
    Expression<bool>? isAvailableOnline,
    Expression<bool>? isAvailableInStore,
    Expression<DateTime>? availabilityDate,
    Expression<DateTime>? discontinueDate,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (variantId != null) 'variant_id': variantId,
      if (inventoryId != null) 'inventory_id': inventoryId,
      if (businessId != null) 'business_id': businessId,
      if (colorId != null) 'color_id': colorId,
      if (sizeId != null) 'size_id': sizeId,
      if (variantSku != null) 'variant_sku': variantSku,
      if (variantBarcode != null) 'variant_barcode': variantBarcode,
      if (variantName != null) 'variant_name': variantName,
      if (variantCode != null) 'variant_code': variantCode,
      if (costPriceAdjustment != null)
        'cost_price_adjustment': costPriceAdjustment,
      if (priceAdjustment != null) 'price_adjustment': priceAdjustment,
      if (finalCostPrice != null) 'final_cost_price': finalCostPrice,
      if (finalRetailPrice != null) 'final_retail_price': finalRetailPrice,
      if (variantDescription != null) 'variant_description': variantDescription,
      if (variantSpecifications != null)
        'variant_specifications': variantSpecifications,
      if (variantImages != null) 'variant_images': variantImages,
      if (weightAdjustment != null) 'weight_adjustment': weightAdjustment,
      if (dimensionAdjustments != null)
        'dimension_adjustments': dimensionAdjustments,
      if (minimumStockLevel != null) 'minimum_stock_level': minimumStockLevel,
      if (reorderLevel != null) 'reorder_level': reorderLevel,
      if (maximumStockLevel != null) 'maximum_stock_level': maximumStockLevel,
      if (isDefaultVariant != null) 'is_default_variant': isDefaultVariant,
      if (isAvailableOnline != null) 'is_available_online': isAvailableOnline,
      if (isAvailableInStore != null)
        'is_available_in_store': isAvailableInStore,
      if (availabilityDate != null) 'availability_date': availabilityDate,
      if (discontinueDate != null) 'discontinue_date': discontinueDate,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryVariantsCompanion copyWith({
    Value<String>? variantId,
    Value<String>? inventoryId,
    Value<String>? businessId,
    Value<String?>? colorId,
    Value<String?>? sizeId,
    Value<String>? variantSku,
    Value<String?>? variantBarcode,
    Value<String>? variantName,
    Value<String>? variantCode,
    Value<double>? costPriceAdjustment,
    Value<double>? priceAdjustment,
    Value<double?>? finalCostPrice,
    Value<double?>? finalRetailPrice,
    Value<String?>? variantDescription,
    Value<String?>? variantSpecifications,
    Value<String?>? variantImages,
    Value<double>? weightAdjustment,
    Value<String?>? dimensionAdjustments,
    Value<int>? minimumStockLevel,
    Value<int>? reorderLevel,
    Value<int?>? maximumStockLevel,
    Value<bool>? isDefaultVariant,
    Value<bool>? isAvailableOnline,
    Value<bool>? isAvailableInStore,
    Value<DateTime?>? availabilityDate,
    Value<DateTime?>? discontinueDate,
    Value<StatusType>? status,
    Value<String?>? createdBy,
    Value<String?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return InventoryVariantsCompanion(
      variantId: variantId ?? this.variantId,
      inventoryId: inventoryId ?? this.inventoryId,
      businessId: businessId ?? this.businessId,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
      variantSku: variantSku ?? this.variantSku,
      variantBarcode: variantBarcode ?? this.variantBarcode,
      variantName: variantName ?? this.variantName,
      variantCode: variantCode ?? this.variantCode,
      costPriceAdjustment: costPriceAdjustment ?? this.costPriceAdjustment,
      priceAdjustment: priceAdjustment ?? this.priceAdjustment,
      finalCostPrice: finalCostPrice ?? this.finalCostPrice,
      finalRetailPrice: finalRetailPrice ?? this.finalRetailPrice,
      variantDescription: variantDescription ?? this.variantDescription,
      variantSpecifications:
          variantSpecifications ?? this.variantSpecifications,
      variantImages: variantImages ?? this.variantImages,
      weightAdjustment: weightAdjustment ?? this.weightAdjustment,
      dimensionAdjustments: dimensionAdjustments ?? this.dimensionAdjustments,
      minimumStockLevel: minimumStockLevel ?? this.minimumStockLevel,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      maximumStockLevel: maximumStockLevel ?? this.maximumStockLevel,
      isDefaultVariant: isDefaultVariant ?? this.isDefaultVariant,
      isAvailableOnline: isAvailableOnline ?? this.isAvailableOnline,
      isAvailableInStore: isAvailableInStore ?? this.isAvailableInStore,
      availabilityDate: availabilityDate ?? this.availabilityDate,
      discontinueDate: discontinueDate ?? this.discontinueDate,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (inventoryId.present) {
      map['inventory_id'] = Variable<String>(inventoryId.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (colorId.present) {
      map['color_id'] = Variable<String>(colorId.value);
    }
    if (sizeId.present) {
      map['size_id'] = Variable<String>(sizeId.value);
    }
    if (variantSku.present) {
      map['variant_sku'] = Variable<String>(variantSku.value);
    }
    if (variantBarcode.present) {
      map['variant_barcode'] = Variable<String>(variantBarcode.value);
    }
    if (variantName.present) {
      map['variant_name'] = Variable<String>(variantName.value);
    }
    if (variantCode.present) {
      map['variant_code'] = Variable<String>(variantCode.value);
    }
    if (costPriceAdjustment.present) {
      map['cost_price_adjustment'] = Variable<double>(
        costPriceAdjustment.value,
      );
    }
    if (priceAdjustment.present) {
      map['price_adjustment'] = Variable<double>(priceAdjustment.value);
    }
    if (finalCostPrice.present) {
      map['final_cost_price'] = Variable<double>(finalCostPrice.value);
    }
    if (finalRetailPrice.present) {
      map['final_retail_price'] = Variable<double>(finalRetailPrice.value);
    }
    if (variantDescription.present) {
      map['variant_description'] = Variable<String>(variantDescription.value);
    }
    if (variantSpecifications.present) {
      map['variant_specifications'] = Variable<String>(
        variantSpecifications.value,
      );
    }
    if (variantImages.present) {
      map['variant_images'] = Variable<String>(variantImages.value);
    }
    if (weightAdjustment.present) {
      map['weight_adjustment'] = Variable<double>(weightAdjustment.value);
    }
    if (dimensionAdjustments.present) {
      map['dimension_adjustments'] = Variable<String>(
        dimensionAdjustments.value,
      );
    }
    if (minimumStockLevel.present) {
      map['minimum_stock_level'] = Variable<int>(minimumStockLevel.value);
    }
    if (reorderLevel.present) {
      map['reorder_level'] = Variable<int>(reorderLevel.value);
    }
    if (maximumStockLevel.present) {
      map['maximum_stock_level'] = Variable<int>(maximumStockLevel.value);
    }
    if (isDefaultVariant.present) {
      map['is_default_variant'] = Variable<bool>(isDefaultVariant.value);
    }
    if (isAvailableOnline.present) {
      map['is_available_online'] = Variable<bool>(isAvailableOnline.value);
    }
    if (isAvailableInStore.present) {
      map['is_available_in_store'] = Variable<bool>(isAvailableInStore.value);
    }
    if (availabilityDate.present) {
      map['availability_date'] = Variable<DateTime>(availabilityDate.value);
    }
    if (discontinueDate.present) {
      map['discontinue_date'] = Variable<DateTime>(discontinueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InventoryVariantsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryVariantsCompanion(')
          ..write('variantId: $variantId, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('businessId: $businessId, ')
          ..write('colorId: $colorId, ')
          ..write('sizeId: $sizeId, ')
          ..write('variantSku: $variantSku, ')
          ..write('variantBarcode: $variantBarcode, ')
          ..write('variantName: $variantName, ')
          ..write('variantCode: $variantCode, ')
          ..write('costPriceAdjustment: $costPriceAdjustment, ')
          ..write('priceAdjustment: $priceAdjustment, ')
          ..write('finalCostPrice: $finalCostPrice, ')
          ..write('finalRetailPrice: $finalRetailPrice, ')
          ..write('variantDescription: $variantDescription, ')
          ..write('variantSpecifications: $variantSpecifications, ')
          ..write('variantImages: $variantImages, ')
          ..write('weightAdjustment: $weightAdjustment, ')
          ..write('dimensionAdjustments: $dimensionAdjustments, ')
          ..write('minimumStockLevel: $minimumStockLevel, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('maximumStockLevel: $maximumStockLevel, ')
          ..write('isDefaultVariant: $isDefaultVariant, ')
          ..write('isAvailableOnline: $isAvailableOnline, ')
          ..write('isAvailableInStore: $isAvailableInStore, ')
          ..write('availabilityDate: $availabilityDate, ')
          ..write('discontinueDate: $discontinueDate, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $InventoryLineTable inventoryLine = $InventoryLineTable(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $SubCategoryTable subCategory = $SubCategoryTable(this);
  late final $InventoryColorsTable inventoryColors = $InventoryColorsTable(
    this,
  );
  late final $InventorySizesTable inventorySizes = $InventorySizesTable(this);
  late final $SeasonTable season = $SeasonTable(this);
  late final $InventoryLocationsTable inventoryLocations =
      $InventoryLocationsTable(this);
  late final $InventoryVariantsTable inventoryVariants =
      $InventoryVariantsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    suppliers,
    inventoryLine,
    categoryTable,
    subCategory,
    inventoryColors,
    inventorySizes,
    season,
    inventoryLocations,
    inventoryVariants,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String email,
      required String password,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> email,
      Value<String> password,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          LocalUser,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (LocalUser, BaseReferences<_$AppDatabase, $UsersTable, LocalUser>),
          LocalUser,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                email: email,
                password: password,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String email,
                required String password,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                email: email,
                password: password,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      LocalUser,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (LocalUser, BaseReferences<_$AppDatabase, $UsersTable, LocalUser>),
      LocalUser,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      required String supplierId,
      required String businessId,
      required String supplierCode,
      required String supplierName,
      Value<String?> supplierType,
      Value<String?> contactPerson,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> website,
      Value<String?> address,
      Value<String?> city,
      Value<String?> state,
      Value<String?> country,
      Value<String?> postalCode,
      Value<String?> taxNumber,
      Value<String?> paymentTerms,
      Value<double?> creditLimit,
      Value<String> currency,
      Value<int?> leadTimeDays,
      Value<double?> minimumOrderAmount,
      Value<String?> shippingMethods,
      Value<double?> qualityRating,
      Value<double?> deliveryRating,
      Value<double?> priceRating,
      Value<bool> preferredSupplier,
      Value<DateTime?> contractStartDate,
      Value<DateTime?> contractEndDate,
      Value<String?> notes,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> supplierId,
      Value<String> businessId,
      Value<String> supplierCode,
      Value<String> supplierName,
      Value<String?> supplierType,
      Value<String?> contactPerson,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> website,
      Value<String?> address,
      Value<String?> city,
      Value<String?> state,
      Value<String?> country,
      Value<String?> postalCode,
      Value<String?> taxNumber,
      Value<String?> paymentTerms,
      Value<double?> creditLimit,
      Value<String> currency,
      Value<int?> leadTimeDays,
      Value<double?> minimumOrderAmount,
      Value<String?> shippingMethods,
      Value<double?> qualityRating,
      Value<double?> deliveryRating,
      Value<double?> priceRating,
      Value<bool> preferredSupplier,
      Value<DateTime?> contractStartDate,
      Value<DateTime?> contractEndDate,
      Value<String?> notes,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierCode => $composableBuilder(
    column: $table.supplierCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierType => $composableBuilder(
    column: $table.supplierType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxNumber => $composableBuilder(
    column: $table.taxNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get leadTimeDays => $composableBuilder(
    column: $table.leadTimeDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minimumOrderAmount => $composableBuilder(
    column: $table.minimumOrderAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shippingMethods => $composableBuilder(
    column: $table.shippingMethods,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deliveryRating => $composableBuilder(
    column: $table.deliveryRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceRating => $composableBuilder(
    column: $table.priceRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get preferredSupplier => $composableBuilder(
    column: $table.preferredSupplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get contractStartDate => $composableBuilder(
    column: $table.contractStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get contractEndDate => $composableBuilder(
    column: $table.contractEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierCode => $composableBuilder(
    column: $table.supplierCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierType => $composableBuilder(
    column: $table.supplierType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxNumber => $composableBuilder(
    column: $table.taxNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leadTimeDays => $composableBuilder(
    column: $table.leadTimeDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minimumOrderAmount => $composableBuilder(
    column: $table.minimumOrderAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shippingMethods => $composableBuilder(
    column: $table.shippingMethods,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deliveryRating => $composableBuilder(
    column: $table.deliveryRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceRating => $composableBuilder(
    column: $table.priceRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get preferredSupplier => $composableBuilder(
    column: $table.preferredSupplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get contractStartDate => $composableBuilder(
    column: $table.contractStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get contractEndDate => $composableBuilder(
    column: $table.contractEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierCode => $composableBuilder(
    column: $table.supplierCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierType => $composableBuilder(
    column: $table.supplierType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taxNumber =>
      $composableBuilder(column: $table.taxNumber, builder: (column) => column);

  GeneratedColumn<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => column,
  );

  GeneratedColumn<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get leadTimeDays => $composableBuilder(
    column: $table.leadTimeDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minimumOrderAmount => $composableBuilder(
    column: $table.minimumOrderAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shippingMethods => $composableBuilder(
    column: $table.shippingMethods,
    builder: (column) => column,
  );

  GeneratedColumn<double> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => column,
  );

  GeneratedColumn<double> get deliveryRating => $composableBuilder(
    column: $table.deliveryRating,
    builder: (column) => column,
  );

  GeneratedColumn<double> get priceRating => $composableBuilder(
    column: $table.priceRating,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get preferredSupplier => $composableBuilder(
    column: $table.preferredSupplier,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get contractStartDate => $composableBuilder(
    column: $table.contractStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get contractEndDate => $composableBuilder(
    column: $table.contractEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
          Supplier,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> supplierId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> supplierCode = const Value.absent(),
                Value<String> supplierName = const Value.absent(),
                Value<String?> supplierType = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> taxNumber = const Value.absent(),
                Value<String?> paymentTerms = const Value.absent(),
                Value<double?> creditLimit = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int?> leadTimeDays = const Value.absent(),
                Value<double?> minimumOrderAmount = const Value.absent(),
                Value<String?> shippingMethods = const Value.absent(),
                Value<double?> qualityRating = const Value.absent(),
                Value<double?> deliveryRating = const Value.absent(),
                Value<double?> priceRating = const Value.absent(),
                Value<bool> preferredSupplier = const Value.absent(),
                Value<DateTime?> contractStartDate = const Value.absent(),
                Value<DateTime?> contractEndDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion(
                supplierId: supplierId,
                businessId: businessId,
                supplierCode: supplierCode,
                supplierName: supplierName,
                supplierType: supplierType,
                contactPerson: contactPerson,
                phone: phone,
                email: email,
                website: website,
                address: address,
                city: city,
                state: state,
                country: country,
                postalCode: postalCode,
                taxNumber: taxNumber,
                paymentTerms: paymentTerms,
                creditLimit: creditLimit,
                currency: currency,
                leadTimeDays: leadTimeDays,
                minimumOrderAmount: minimumOrderAmount,
                shippingMethods: shippingMethods,
                qualityRating: qualityRating,
                deliveryRating: deliveryRating,
                priceRating: priceRating,
                preferredSupplier: preferredSupplier,
                contractStartDate: contractStartDate,
                contractEndDate: contractEndDate,
                notes: notes,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String supplierId,
                required String businessId,
                required String supplierCode,
                required String supplierName,
                Value<String?> supplierType = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<String?> taxNumber = const Value.absent(),
                Value<String?> paymentTerms = const Value.absent(),
                Value<double?> creditLimit = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int?> leadTimeDays = const Value.absent(),
                Value<double?> minimumOrderAmount = const Value.absent(),
                Value<String?> shippingMethods = const Value.absent(),
                Value<double?> qualityRating = const Value.absent(),
                Value<double?> deliveryRating = const Value.absent(),
                Value<double?> priceRating = const Value.absent(),
                Value<bool> preferredSupplier = const Value.absent(),
                Value<DateTime?> contractStartDate = const Value.absent(),
                Value<DateTime?> contractEndDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion.insert(
                supplierId: supplierId,
                businessId: businessId,
                supplierCode: supplierCode,
                supplierName: supplierName,
                supplierType: supplierType,
                contactPerson: contactPerson,
                phone: phone,
                email: email,
                website: website,
                address: address,
                city: city,
                state: state,
                country: country,
                postalCode: postalCode,
                taxNumber: taxNumber,
                paymentTerms: paymentTerms,
                creditLimit: creditLimit,
                currency: currency,
                leadTimeDays: leadTimeDays,
                minimumOrderAmount: minimumOrderAmount,
                shippingMethods: shippingMethods,
                qualityRating: qualityRating,
                deliveryRating: deliveryRating,
                priceRating: priceRating,
                preferredSupplier: preferredSupplier,
                contractStartDate: contractStartDate,
                contractEndDate: contractEndDate,
                notes: notes,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
      Supplier,
      PrefetchHooks Function()
    >;
typedef $$InventoryLineTableCreateCompanionBuilder =
    InventoryLineCompanion Function({
      required String inventoryLineId,
      required String businessId,
      required String lineCode,
      required String lineName,
      Value<String?> lineDescription,
      Value<PlacementType> linePlacement,
      Value<String?> parentLineId,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$InventoryLineTableUpdateCompanionBuilder =
    InventoryLineCompanion Function({
      Value<String> inventoryLineId,
      Value<String> businessId,
      Value<String> lineCode,
      Value<String> lineName,
      Value<String?> lineDescription,
      Value<PlacementType> linePlacement,
      Value<String?> parentLineId,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$InventoryLineTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryLineTable> {
  $$InventoryLineTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get inventoryLineId => $composableBuilder(
    column: $table.inventoryLineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lineCode => $composableBuilder(
    column: $table.lineCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lineName => $composableBuilder(
    column: $table.lineName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lineDescription => $composableBuilder(
    column: $table.lineDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlacementType, PlacementType, String>
  get linePlacement => $composableBuilder(
    column: $table.linePlacement,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get parentLineId => $composableBuilder(
    column: $table.parentLineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryLineTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryLineTable> {
  $$InventoryLineTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get inventoryLineId => $composableBuilder(
    column: $table.inventoryLineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lineCode => $composableBuilder(
    column: $table.lineCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lineName => $composableBuilder(
    column: $table.lineName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lineDescription => $composableBuilder(
    column: $table.lineDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linePlacement => $composableBuilder(
    column: $table.linePlacement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentLineId => $composableBuilder(
    column: $table.parentLineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryLineTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryLineTable> {
  $$InventoryLineTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get inventoryLineId => $composableBuilder(
    column: $table.inventoryLineId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lineCode =>
      $composableBuilder(column: $table.lineCode, builder: (column) => column);

  GeneratedColumn<String> get lineName =>
      $composableBuilder(column: $table.lineName, builder: (column) => column);

  GeneratedColumn<String> get lineDescription => $composableBuilder(
    column: $table.lineDescription,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlacementType, String> get linePlacement =>
      $composableBuilder(
        column: $table.linePlacement,
        builder: (column) => column,
      );

  GeneratedColumn<String> get parentLineId => $composableBuilder(
    column: $table.parentLineId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$InventoryLineTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryLineTable,
          InventoryLineData,
          $$InventoryLineTableFilterComposer,
          $$InventoryLineTableOrderingComposer,
          $$InventoryLineTableAnnotationComposer,
          $$InventoryLineTableCreateCompanionBuilder,
          $$InventoryLineTableUpdateCompanionBuilder,
          (
            InventoryLineData,
            BaseReferences<
              _$AppDatabase,
              $InventoryLineTable,
              InventoryLineData
            >,
          ),
          InventoryLineData,
          PrefetchHooks Function()
        > {
  $$InventoryLineTableTableManager(_$AppDatabase db, $InventoryLineTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryLineTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryLineTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryLineTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> inventoryLineId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> lineCode = const Value.absent(),
                Value<String> lineName = const Value.absent(),
                Value<String?> lineDescription = const Value.absent(),
                Value<PlacementType> linePlacement = const Value.absent(),
                Value<String?> parentLineId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryLineCompanion(
                inventoryLineId: inventoryLineId,
                businessId: businessId,
                lineCode: lineCode,
                lineName: lineName,
                lineDescription: lineDescription,
                linePlacement: linePlacement,
                parentLineId: parentLineId,
                sortOrder: sortOrder,
                isActive: isActive,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String inventoryLineId,
                required String businessId,
                required String lineCode,
                required String lineName,
                Value<String?> lineDescription = const Value.absent(),
                Value<PlacementType> linePlacement = const Value.absent(),
                Value<String?> parentLineId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryLineCompanion.insert(
                inventoryLineId: inventoryLineId,
                businessId: businessId,
                lineCode: lineCode,
                lineName: lineName,
                lineDescription: lineDescription,
                linePlacement: linePlacement,
                parentLineId: parentLineId,
                sortOrder: sortOrder,
                isActive: isActive,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryLineTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryLineTable,
      InventoryLineData,
      $$InventoryLineTableFilterComposer,
      $$InventoryLineTableOrderingComposer,
      $$InventoryLineTableAnnotationComposer,
      $$InventoryLineTableCreateCompanionBuilder,
      $$InventoryLineTableUpdateCompanionBuilder,
      (
        InventoryLineData,
        BaseReferences<_$AppDatabase, $InventoryLineTable, InventoryLineData>,
      ),
      InventoryLineData,
      PrefetchHooks Function()
    >;
typedef $$CategoryTableTableCreateCompanionBuilder =
    CategoryTableCompanion Function({
      required String categoryId,
      required String businessId,
      required String categoryCode,
      required String categoryName,
      Value<String?> categoryDescription,
      Value<String?> parentCategoryId,
      Value<String?> categoryImageUrl,
      Value<String?> seoSlug,
      Value<String?> metaTitle,
      Value<String?> metaDescription,
      Value<PlacementType> codePlacement,
      Value<int> sortOrder,
      Value<bool> isFeatured,
      Value<double?> commissionRate,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$CategoryTableTableUpdateCompanionBuilder =
    CategoryTableCompanion Function({
      Value<String> categoryId,
      Value<String> businessId,
      Value<String> categoryCode,
      Value<String> categoryName,
      Value<String?> categoryDescription,
      Value<String?> parentCategoryId,
      Value<String?> categoryImageUrl,
      Value<String?> seoSlug,
      Value<String?> metaTitle,
      Value<String?> metaDescription,
      Value<PlacementType> codePlacement,
      Value<int> sortOrder,
      Value<bool> isFeatured,
      Value<double?> commissionRate,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$CategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryCode => $composableBuilder(
    column: $table.categoryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryDescription => $composableBuilder(
    column: $table.categoryDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentCategoryId => $composableBuilder(
    column: $table.parentCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryImageUrl => $composableBuilder(
    column: $table.categoryImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seoSlug => $composableBuilder(
    column: $table.seoSlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metaTitle => $composableBuilder(
    column: $table.metaTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metaDescription => $composableBuilder(
    column: $table.metaDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlacementType, PlacementType, String>
  get codePlacement => $composableBuilder(
    column: $table.codePlacement,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryCode => $composableBuilder(
    column: $table.categoryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryDescription => $composableBuilder(
    column: $table.categoryDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentCategoryId => $composableBuilder(
    column: $table.parentCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryImageUrl => $composableBuilder(
    column: $table.categoryImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seoSlug => $composableBuilder(
    column: $table.seoSlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metaTitle => $composableBuilder(
    column: $table.metaTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metaDescription => $composableBuilder(
    column: $table.metaDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codePlacement => $composableBuilder(
    column: $table.codePlacement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryCode => $composableBuilder(
    column: $table.categoryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryDescription => $composableBuilder(
    column: $table.categoryDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentCategoryId => $composableBuilder(
    column: $table.parentCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryImageUrl => $composableBuilder(
    column: $table.categoryImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seoSlug =>
      $composableBuilder(column: $table.seoSlug, builder: (column) => column);

  GeneratedColumn<String> get metaTitle =>
      $composableBuilder(column: $table.metaTitle, builder: (column) => column);

  GeneratedColumn<String> get metaDescription => $composableBuilder(
    column: $table.metaDescription,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlacementType, String> get codePlacement =>
      $composableBuilder(
        column: $table.codePlacement,
        builder: (column) => column,
      );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionRate => $composableBuilder(
    column: $table.commissionRate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$CategoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryTableTable,
          CategoryTableData,
          $$CategoryTableTableFilterComposer,
          $$CategoryTableTableOrderingComposer,
          $$CategoryTableTableAnnotationComposer,
          $$CategoryTableTableCreateCompanionBuilder,
          $$CategoryTableTableUpdateCompanionBuilder,
          (
            CategoryTableData,
            BaseReferences<
              _$AppDatabase,
              $CategoryTableTable,
              CategoryTableData
            >,
          ),
          CategoryTableData,
          PrefetchHooks Function()
        > {
  $$CategoryTableTableTableManager(_$AppDatabase db, $CategoryTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> categoryId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> categoryCode = const Value.absent(),
                Value<String> categoryName = const Value.absent(),
                Value<String?> categoryDescription = const Value.absent(),
                Value<String?> parentCategoryId = const Value.absent(),
                Value<String?> categoryImageUrl = const Value.absent(),
                Value<String?> seoSlug = const Value.absent(),
                Value<String?> metaTitle = const Value.absent(),
                Value<String?> metaDescription = const Value.absent(),
                Value<PlacementType> codePlacement = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<double?> commissionRate = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryTableCompanion(
                categoryId: categoryId,
                businessId: businessId,
                categoryCode: categoryCode,
                categoryName: categoryName,
                categoryDescription: categoryDescription,
                parentCategoryId: parentCategoryId,
                categoryImageUrl: categoryImageUrl,
                seoSlug: seoSlug,
                metaTitle: metaTitle,
                metaDescription: metaDescription,
                codePlacement: codePlacement,
                sortOrder: sortOrder,
                isFeatured: isFeatured,
                commissionRate: commissionRate,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String categoryId,
                required String businessId,
                required String categoryCode,
                required String categoryName,
                Value<String?> categoryDescription = const Value.absent(),
                Value<String?> parentCategoryId = const Value.absent(),
                Value<String?> categoryImageUrl = const Value.absent(),
                Value<String?> seoSlug = const Value.absent(),
                Value<String?> metaTitle = const Value.absent(),
                Value<String?> metaDescription = const Value.absent(),
                Value<PlacementType> codePlacement = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<double?> commissionRate = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryTableCompanion.insert(
                categoryId: categoryId,
                businessId: businessId,
                categoryCode: categoryCode,
                categoryName: categoryName,
                categoryDescription: categoryDescription,
                parentCategoryId: parentCategoryId,
                categoryImageUrl: categoryImageUrl,
                seoSlug: seoSlug,
                metaTitle: metaTitle,
                metaDescription: metaDescription,
                codePlacement: codePlacement,
                sortOrder: sortOrder,
                isFeatured: isFeatured,
                commissionRate: commissionRate,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryTableTable,
      CategoryTableData,
      $$CategoryTableTableFilterComposer,
      $$CategoryTableTableOrderingComposer,
      $$CategoryTableTableAnnotationComposer,
      $$CategoryTableTableCreateCompanionBuilder,
      $$CategoryTableTableUpdateCompanionBuilder,
      (
        CategoryTableData,
        BaseReferences<_$AppDatabase, $CategoryTableTable, CategoryTableData>,
      ),
      CategoryTableData,
      PrefetchHooks Function()
    >;
typedef $$SubCategoryTableCreateCompanionBuilder =
    SubCategoryCompanion Function({
      required String subCategoryId,
      required String categoryId,
      required String businessId,
      required String subCategoryCode,
      required String subCategoryName,
      Value<String?> subCategoryDescription,
      Value<PlacementType> codePlacement,
      Value<int?> counter,
      Value<int> sortOrder,
      Value<String?> subCategoryImageUrl,
      Value<String?> sizeChartUrl,
      Value<String?> careInstructions,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$SubCategoryTableUpdateCompanionBuilder =
    SubCategoryCompanion Function({
      Value<String> subCategoryId,
      Value<String> categoryId,
      Value<String> businessId,
      Value<String> subCategoryCode,
      Value<String> subCategoryName,
      Value<String?> subCategoryDescription,
      Value<PlacementType> codePlacement,
      Value<int?> counter,
      Value<int> sortOrder,
      Value<String?> subCategoryImageUrl,
      Value<String?> sizeChartUrl,
      Value<String?> careInstructions,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$SubCategoryTableFilterComposer
    extends Composer<_$AppDatabase, $SubCategoryTable> {
  $$SubCategoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get subCategoryId => $composableBuilder(
    column: $table.subCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subCategoryCode => $composableBuilder(
    column: $table.subCategoryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subCategoryName => $composableBuilder(
    column: $table.subCategoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subCategoryDescription => $composableBuilder(
    column: $table.subCategoryDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlacementType, PlacementType, String>
  get codePlacement => $composableBuilder(
    column: $table.codePlacement,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get counter => $composableBuilder(
    column: $table.counter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subCategoryImageUrl => $composableBuilder(
    column: $table.subCategoryImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeChartUrl => $composableBuilder(
    column: $table.sizeChartUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get careInstructions => $composableBuilder(
    column: $table.careInstructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubCategoryTableOrderingComposer
    extends Composer<_$AppDatabase, $SubCategoryTable> {
  $$SubCategoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get subCategoryId => $composableBuilder(
    column: $table.subCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subCategoryCode => $composableBuilder(
    column: $table.subCategoryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subCategoryName => $composableBuilder(
    column: $table.subCategoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subCategoryDescription => $composableBuilder(
    column: $table.subCategoryDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codePlacement => $composableBuilder(
    column: $table.codePlacement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get counter => $composableBuilder(
    column: $table.counter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subCategoryImageUrl => $composableBuilder(
    column: $table.subCategoryImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeChartUrl => $composableBuilder(
    column: $table.sizeChartUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get careInstructions => $composableBuilder(
    column: $table.careInstructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubCategoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubCategoryTable> {
  $$SubCategoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get subCategoryId => $composableBuilder(
    column: $table.subCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subCategoryCode => $composableBuilder(
    column: $table.subCategoryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subCategoryName => $composableBuilder(
    column: $table.subCategoryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subCategoryDescription => $composableBuilder(
    column: $table.subCategoryDescription,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlacementType, String> get codePlacement =>
      $composableBuilder(
        column: $table.codePlacement,
        builder: (column) => column,
      );

  GeneratedColumn<int> get counter =>
      $composableBuilder(column: $table.counter, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get subCategoryImageUrl => $composableBuilder(
    column: $table.subCategoryImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sizeChartUrl => $composableBuilder(
    column: $table.sizeChartUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get careInstructions => $composableBuilder(
    column: $table.careInstructions,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$SubCategoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubCategoryTable,
          SubCategoryData,
          $$SubCategoryTableFilterComposer,
          $$SubCategoryTableOrderingComposer,
          $$SubCategoryTableAnnotationComposer,
          $$SubCategoryTableCreateCompanionBuilder,
          $$SubCategoryTableUpdateCompanionBuilder,
          (
            SubCategoryData,
            BaseReferences<_$AppDatabase, $SubCategoryTable, SubCategoryData>,
          ),
          SubCategoryData,
          PrefetchHooks Function()
        > {
  $$SubCategoryTableTableManager(_$AppDatabase db, $SubCategoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubCategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubCategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubCategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> subCategoryId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> subCategoryCode = const Value.absent(),
                Value<String> subCategoryName = const Value.absent(),
                Value<String?> subCategoryDescription = const Value.absent(),
                Value<PlacementType> codePlacement = const Value.absent(),
                Value<int?> counter = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> subCategoryImageUrl = const Value.absent(),
                Value<String?> sizeChartUrl = const Value.absent(),
                Value<String?> careInstructions = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubCategoryCompanion(
                subCategoryId: subCategoryId,
                categoryId: categoryId,
                businessId: businessId,
                subCategoryCode: subCategoryCode,
                subCategoryName: subCategoryName,
                subCategoryDescription: subCategoryDescription,
                codePlacement: codePlacement,
                counter: counter,
                sortOrder: sortOrder,
                subCategoryImageUrl: subCategoryImageUrl,
                sizeChartUrl: sizeChartUrl,
                careInstructions: careInstructions,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String subCategoryId,
                required String categoryId,
                required String businessId,
                required String subCategoryCode,
                required String subCategoryName,
                Value<String?> subCategoryDescription = const Value.absent(),
                Value<PlacementType> codePlacement = const Value.absent(),
                Value<int?> counter = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> subCategoryImageUrl = const Value.absent(),
                Value<String?> sizeChartUrl = const Value.absent(),
                Value<String?> careInstructions = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubCategoryCompanion.insert(
                subCategoryId: subCategoryId,
                categoryId: categoryId,
                businessId: businessId,
                subCategoryCode: subCategoryCode,
                subCategoryName: subCategoryName,
                subCategoryDescription: subCategoryDescription,
                codePlacement: codePlacement,
                counter: counter,
                sortOrder: sortOrder,
                subCategoryImageUrl: subCategoryImageUrl,
                sizeChartUrl: sizeChartUrl,
                careInstructions: careInstructions,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubCategoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubCategoryTable,
      SubCategoryData,
      $$SubCategoryTableFilterComposer,
      $$SubCategoryTableOrderingComposer,
      $$SubCategoryTableAnnotationComposer,
      $$SubCategoryTableCreateCompanionBuilder,
      $$SubCategoryTableUpdateCompanionBuilder,
      (
        SubCategoryData,
        BaseReferences<_$AppDatabase, $SubCategoryTable, SubCategoryData>,
      ),
      SubCategoryData,
      PrefetchHooks Function()
    >;
typedef $$InventoryColorsTableCreateCompanionBuilder =
    InventoryColorsCompanion Function({
      required String colorId,
      required String businessId,
      required String colorName,
      required String colorCode,
      Value<String?> hexColor,
      Value<String?> rgbColor,
      Value<String?> pantoneCode,
      Value<String?> supplierColorCode,
      Value<String?> colorFamily,
      Value<bool> isSeasonal,
      Value<String?> seasonIds,
      Value<int> displayOrder,
      Value<String?> colorImageUrl,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$InventoryColorsTableUpdateCompanionBuilder =
    InventoryColorsCompanion Function({
      Value<String> colorId,
      Value<String> businessId,
      Value<String> colorName,
      Value<String> colorCode,
      Value<String?> hexColor,
      Value<String?> rgbColor,
      Value<String?> pantoneCode,
      Value<String?> supplierColorCode,
      Value<String?> colorFamily,
      Value<bool> isSeasonal,
      Value<String?> seasonIds,
      Value<int> displayOrder,
      Value<String?> colorImageUrl,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$InventoryColorsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryColorsTable> {
  $$InventoryColorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorName => $composableBuilder(
    column: $table.colorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorCode => $composableBuilder(
    column: $table.colorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hexColor => $composableBuilder(
    column: $table.hexColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rgbColor => $composableBuilder(
    column: $table.rgbColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pantoneCode => $composableBuilder(
    column: $table.pantoneCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierColorCode => $composableBuilder(
    column: $table.supplierColorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorFamily => $composableBuilder(
    column: $table.colorFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSeasonal => $composableBuilder(
    column: $table.isSeasonal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seasonIds => $composableBuilder(
    column: $table.seasonIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorImageUrl => $composableBuilder(
    column: $table.colorImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryColorsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryColorsTable> {
  $$InventoryColorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorName => $composableBuilder(
    column: $table.colorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorCode => $composableBuilder(
    column: $table.colorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hexColor => $composableBuilder(
    column: $table.hexColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rgbColor => $composableBuilder(
    column: $table.rgbColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pantoneCode => $composableBuilder(
    column: $table.pantoneCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierColorCode => $composableBuilder(
    column: $table.supplierColorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorFamily => $composableBuilder(
    column: $table.colorFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSeasonal => $composableBuilder(
    column: $table.isSeasonal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seasonIds => $composableBuilder(
    column: $table.seasonIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorImageUrl => $composableBuilder(
    column: $table.colorImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryColorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryColorsTable> {
  $$InventoryColorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get colorId =>
      $composableBuilder(column: $table.colorId, builder: (column) => column);

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorName =>
      $composableBuilder(column: $table.colorName, builder: (column) => column);

  GeneratedColumn<String> get colorCode =>
      $composableBuilder(column: $table.colorCode, builder: (column) => column);

  GeneratedColumn<String> get hexColor =>
      $composableBuilder(column: $table.hexColor, builder: (column) => column);

  GeneratedColumn<String> get rgbColor =>
      $composableBuilder(column: $table.rgbColor, builder: (column) => column);

  GeneratedColumn<String> get pantoneCode => $composableBuilder(
    column: $table.pantoneCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierColorCode => $composableBuilder(
    column: $table.supplierColorCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorFamily => $composableBuilder(
    column: $table.colorFamily,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSeasonal => $composableBuilder(
    column: $table.isSeasonal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seasonIds =>
      $composableBuilder(column: $table.seasonIds, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorImageUrl => $composableBuilder(
    column: $table.colorImageUrl,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$InventoryColorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryColorsTable,
          InventoryColor,
          $$InventoryColorsTableFilterComposer,
          $$InventoryColorsTableOrderingComposer,
          $$InventoryColorsTableAnnotationComposer,
          $$InventoryColorsTableCreateCompanionBuilder,
          $$InventoryColorsTableUpdateCompanionBuilder,
          (
            InventoryColor,
            BaseReferences<
              _$AppDatabase,
              $InventoryColorsTable,
              InventoryColor
            >,
          ),
          InventoryColor,
          PrefetchHooks Function()
        > {
  $$InventoryColorsTableTableManager(
    _$AppDatabase db,
    $InventoryColorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryColorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryColorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryColorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> colorId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> colorName = const Value.absent(),
                Value<String> colorCode = const Value.absent(),
                Value<String?> hexColor = const Value.absent(),
                Value<String?> rgbColor = const Value.absent(),
                Value<String?> pantoneCode = const Value.absent(),
                Value<String?> supplierColorCode = const Value.absent(),
                Value<String?> colorFamily = const Value.absent(),
                Value<bool> isSeasonal = const Value.absent(),
                Value<String?> seasonIds = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<String?> colorImageUrl = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryColorsCompanion(
                colorId: colorId,
                businessId: businessId,
                colorName: colorName,
                colorCode: colorCode,
                hexColor: hexColor,
                rgbColor: rgbColor,
                pantoneCode: pantoneCode,
                supplierColorCode: supplierColorCode,
                colorFamily: colorFamily,
                isSeasonal: isSeasonal,
                seasonIds: seasonIds,
                displayOrder: displayOrder,
                colorImageUrl: colorImageUrl,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String colorId,
                required String businessId,
                required String colorName,
                required String colorCode,
                Value<String?> hexColor = const Value.absent(),
                Value<String?> rgbColor = const Value.absent(),
                Value<String?> pantoneCode = const Value.absent(),
                Value<String?> supplierColorCode = const Value.absent(),
                Value<String?> colorFamily = const Value.absent(),
                Value<bool> isSeasonal = const Value.absent(),
                Value<String?> seasonIds = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<String?> colorImageUrl = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryColorsCompanion.insert(
                colorId: colorId,
                businessId: businessId,
                colorName: colorName,
                colorCode: colorCode,
                hexColor: hexColor,
                rgbColor: rgbColor,
                pantoneCode: pantoneCode,
                supplierColorCode: supplierColorCode,
                colorFamily: colorFamily,
                isSeasonal: isSeasonal,
                seasonIds: seasonIds,
                displayOrder: displayOrder,
                colorImageUrl: colorImageUrl,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryColorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryColorsTable,
      InventoryColor,
      $$InventoryColorsTableFilterComposer,
      $$InventoryColorsTableOrderingComposer,
      $$InventoryColorsTableAnnotationComposer,
      $$InventoryColorsTableCreateCompanionBuilder,
      $$InventoryColorsTableUpdateCompanionBuilder,
      (
        InventoryColor,
        BaseReferences<_$AppDatabase, $InventoryColorsTable, InventoryColor>,
      ),
      InventoryColor,
      PrefetchHooks Function()
    >;
typedef $$InventorySizesTableCreateCompanionBuilder =
    InventorySizesCompanion Function({
      required String sizeId,
      required String businessId,
      Value<String?> subCategoryId,
      required String sizeName,
      required String sizeCode,
      required String sizeType,
      Value<String?> sizeSystem,
      Value<String?> sizeMeasurements,
      Value<int?> sizeChartPosition,
      Value<int> displayOrder,
      Value<String?> equivalentSizes,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$InventorySizesTableUpdateCompanionBuilder =
    InventorySizesCompanion Function({
      Value<String> sizeId,
      Value<String> businessId,
      Value<String?> subCategoryId,
      Value<String> sizeName,
      Value<String> sizeCode,
      Value<String> sizeType,
      Value<String?> sizeSystem,
      Value<String?> sizeMeasurements,
      Value<int?> sizeChartPosition,
      Value<int> displayOrder,
      Value<String?> equivalentSizes,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$InventorySizesTableFilterComposer
    extends Composer<_$AppDatabase, $InventorySizesTable> {
  $$InventorySizesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sizeId => $composableBuilder(
    column: $table.sizeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subCategoryId => $composableBuilder(
    column: $table.subCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeName => $composableBuilder(
    column: $table.sizeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeCode => $composableBuilder(
    column: $table.sizeCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeType => $composableBuilder(
    column: $table.sizeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeSystem => $composableBuilder(
    column: $table.sizeSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeMeasurements => $composableBuilder(
    column: $table.sizeMeasurements,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeChartPosition => $composableBuilder(
    column: $table.sizeChartPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equivalentSizes => $composableBuilder(
    column: $table.equivalentSizes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventorySizesTableOrderingComposer
    extends Composer<_$AppDatabase, $InventorySizesTable> {
  $$InventorySizesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sizeId => $composableBuilder(
    column: $table.sizeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subCategoryId => $composableBuilder(
    column: $table.subCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeName => $composableBuilder(
    column: $table.sizeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeCode => $composableBuilder(
    column: $table.sizeCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeType => $composableBuilder(
    column: $table.sizeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeSystem => $composableBuilder(
    column: $table.sizeSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeMeasurements => $composableBuilder(
    column: $table.sizeMeasurements,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeChartPosition => $composableBuilder(
    column: $table.sizeChartPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equivalentSizes => $composableBuilder(
    column: $table.equivalentSizes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventorySizesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventorySizesTable> {
  $$InventorySizesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sizeId =>
      $composableBuilder(column: $table.sizeId, builder: (column) => column);

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subCategoryId => $composableBuilder(
    column: $table.subCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sizeName =>
      $composableBuilder(column: $table.sizeName, builder: (column) => column);

  GeneratedColumn<String> get sizeCode =>
      $composableBuilder(column: $table.sizeCode, builder: (column) => column);

  GeneratedColumn<String> get sizeType =>
      $composableBuilder(column: $table.sizeType, builder: (column) => column);

  GeneratedColumn<String> get sizeSystem => $composableBuilder(
    column: $table.sizeSystem,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sizeMeasurements => $composableBuilder(
    column: $table.sizeMeasurements,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sizeChartPosition => $composableBuilder(
    column: $table.sizeChartPosition,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equivalentSizes => $composableBuilder(
    column: $table.equivalentSizes,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$InventorySizesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventorySizesTable,
          InventorySize,
          $$InventorySizesTableFilterComposer,
          $$InventorySizesTableOrderingComposer,
          $$InventorySizesTableAnnotationComposer,
          $$InventorySizesTableCreateCompanionBuilder,
          $$InventorySizesTableUpdateCompanionBuilder,
          (
            InventorySize,
            BaseReferences<_$AppDatabase, $InventorySizesTable, InventorySize>,
          ),
          InventorySize,
          PrefetchHooks Function()
        > {
  $$InventorySizesTableTableManager(
    _$AppDatabase db,
    $InventorySizesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventorySizesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventorySizesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventorySizesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sizeId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String?> subCategoryId = const Value.absent(),
                Value<String> sizeName = const Value.absent(),
                Value<String> sizeCode = const Value.absent(),
                Value<String> sizeType = const Value.absent(),
                Value<String?> sizeSystem = const Value.absent(),
                Value<String?> sizeMeasurements = const Value.absent(),
                Value<int?> sizeChartPosition = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<String?> equivalentSizes = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventorySizesCompanion(
                sizeId: sizeId,
                businessId: businessId,
                subCategoryId: subCategoryId,
                sizeName: sizeName,
                sizeCode: sizeCode,
                sizeType: sizeType,
                sizeSystem: sizeSystem,
                sizeMeasurements: sizeMeasurements,
                sizeChartPosition: sizeChartPosition,
                displayOrder: displayOrder,
                equivalentSizes: equivalentSizes,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sizeId,
                required String businessId,
                Value<String?> subCategoryId = const Value.absent(),
                required String sizeName,
                required String sizeCode,
                required String sizeType,
                Value<String?> sizeSystem = const Value.absent(),
                Value<String?> sizeMeasurements = const Value.absent(),
                Value<int?> sizeChartPosition = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<String?> equivalentSizes = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventorySizesCompanion.insert(
                sizeId: sizeId,
                businessId: businessId,
                subCategoryId: subCategoryId,
                sizeName: sizeName,
                sizeCode: sizeCode,
                sizeType: sizeType,
                sizeSystem: sizeSystem,
                sizeMeasurements: sizeMeasurements,
                sizeChartPosition: sizeChartPosition,
                displayOrder: displayOrder,
                equivalentSizes: equivalentSizes,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventorySizesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventorySizesTable,
      InventorySize,
      $$InventorySizesTableFilterComposer,
      $$InventorySizesTableOrderingComposer,
      $$InventorySizesTableAnnotationComposer,
      $$InventorySizesTableCreateCompanionBuilder,
      $$InventorySizesTableUpdateCompanionBuilder,
      (
        InventorySize,
        BaseReferences<_$AppDatabase, $InventorySizesTable, InventorySize>,
      ),
      InventorySize,
      PrefetchHooks Function()
    >;
typedef $$SeasonTableCreateCompanionBuilder =
    SeasonCompanion Function({
      required String seasonId,
      required String businessId,
      required String seasonName,
      required String seasonCode,
      Value<String?> seasonDescription,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<bool> isCurrentSeason,
      Value<String?> marketingThemes,
      Value<String?> targetDemographics,
      Value<double?> seasonalMarkupPercentage,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$SeasonTableUpdateCompanionBuilder =
    SeasonCompanion Function({
      Value<String> seasonId,
      Value<String> businessId,
      Value<String> seasonName,
      Value<String> seasonCode,
      Value<String?> seasonDescription,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<bool> isCurrentSeason,
      Value<String?> marketingThemes,
      Value<String?> targetDemographics,
      Value<double?> seasonalMarkupPercentage,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$SeasonTableFilterComposer
    extends Composer<_$AppDatabase, $SeasonTable> {
  $$SeasonTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get seasonId => $composableBuilder(
    column: $table.seasonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seasonName => $composableBuilder(
    column: $table.seasonName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seasonCode => $composableBuilder(
    column: $table.seasonCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seasonDescription => $composableBuilder(
    column: $table.seasonDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrentSeason => $composableBuilder(
    column: $table.isCurrentSeason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marketingThemes => $composableBuilder(
    column: $table.marketingThemes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetDemographics => $composableBuilder(
    column: $table.targetDemographics,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get seasonalMarkupPercentage => $composableBuilder(
    column: $table.seasonalMarkupPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SeasonTableOrderingComposer
    extends Composer<_$AppDatabase, $SeasonTable> {
  $$SeasonTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get seasonId => $composableBuilder(
    column: $table.seasonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seasonName => $composableBuilder(
    column: $table.seasonName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seasonCode => $composableBuilder(
    column: $table.seasonCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seasonDescription => $composableBuilder(
    column: $table.seasonDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrentSeason => $composableBuilder(
    column: $table.isCurrentSeason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marketingThemes => $composableBuilder(
    column: $table.marketingThemes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetDemographics => $composableBuilder(
    column: $table.targetDemographics,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get seasonalMarkupPercentage => $composableBuilder(
    column: $table.seasonalMarkupPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SeasonTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeasonTable> {
  $$SeasonTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get seasonId =>
      $composableBuilder(column: $table.seasonId, builder: (column) => column);

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seasonName => $composableBuilder(
    column: $table.seasonName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seasonCode => $composableBuilder(
    column: $table.seasonCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seasonDescription => $composableBuilder(
    column: $table.seasonDescription,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isCurrentSeason => $composableBuilder(
    column: $table.isCurrentSeason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marketingThemes => $composableBuilder(
    column: $table.marketingThemes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetDemographics => $composableBuilder(
    column: $table.targetDemographics,
    builder: (column) => column,
  );

  GeneratedColumn<double> get seasonalMarkupPercentage => $composableBuilder(
    column: $table.seasonalMarkupPercentage,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$SeasonTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeasonTable,
          SeasonData,
          $$SeasonTableFilterComposer,
          $$SeasonTableOrderingComposer,
          $$SeasonTableAnnotationComposer,
          $$SeasonTableCreateCompanionBuilder,
          $$SeasonTableUpdateCompanionBuilder,
          (SeasonData, BaseReferences<_$AppDatabase, $SeasonTable, SeasonData>),
          SeasonData,
          PrefetchHooks Function()
        > {
  $$SeasonTableTableManager(_$AppDatabase db, $SeasonTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeasonTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeasonTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeasonTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> seasonId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> seasonName = const Value.absent(),
                Value<String> seasonCode = const Value.absent(),
                Value<String?> seasonDescription = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<bool> isCurrentSeason = const Value.absent(),
                Value<String?> marketingThemes = const Value.absent(),
                Value<String?> targetDemographics = const Value.absent(),
                Value<double?> seasonalMarkupPercentage = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeasonCompanion(
                seasonId: seasonId,
                businessId: businessId,
                seasonName: seasonName,
                seasonCode: seasonCode,
                seasonDescription: seasonDescription,
                startDate: startDate,
                endDate: endDate,
                isCurrentSeason: isCurrentSeason,
                marketingThemes: marketingThemes,
                targetDemographics: targetDemographics,
                seasonalMarkupPercentage: seasonalMarkupPercentage,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String seasonId,
                required String businessId,
                required String seasonName,
                required String seasonCode,
                Value<String?> seasonDescription = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<bool> isCurrentSeason = const Value.absent(),
                Value<String?> marketingThemes = const Value.absent(),
                Value<String?> targetDemographics = const Value.absent(),
                Value<double?> seasonalMarkupPercentage = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeasonCompanion.insert(
                seasonId: seasonId,
                businessId: businessId,
                seasonName: seasonName,
                seasonCode: seasonCode,
                seasonDescription: seasonDescription,
                startDate: startDate,
                endDate: endDate,
                isCurrentSeason: isCurrentSeason,
                marketingThemes: marketingThemes,
                targetDemographics: targetDemographics,
                seasonalMarkupPercentage: seasonalMarkupPercentage,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SeasonTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeasonTable,
      SeasonData,
      $$SeasonTableFilterComposer,
      $$SeasonTableOrderingComposer,
      $$SeasonTableAnnotationComposer,
      $$SeasonTableCreateCompanionBuilder,
      $$SeasonTableUpdateCompanionBuilder,
      (SeasonData, BaseReferences<_$AppDatabase, $SeasonTable, SeasonData>),
      SeasonData,
      PrefetchHooks Function()
    >;
typedef $$InventoryLocationsTableCreateCompanionBuilder =
    InventoryLocationsCompanion Function({
      required String locationId,
      required String businessId,
      required String branchId,
      required String locationName,
      required String locationCode,
      required LocationType locationType,
      Value<String?> parentLocationId,
      Value<String?> aisle,
      Value<String?> shelf,
      Value<String?> bin,
      Value<String?> barcode,
      Value<int?> maxCapacity,
      Value<int> currentCapacity,
      Value<bool> isSellableLocation,
      Value<bool> requiresCounting,
      Value<bool> temperatureControlled,
      Value<String> securityLevel,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$InventoryLocationsTableUpdateCompanionBuilder =
    InventoryLocationsCompanion Function({
      Value<String> locationId,
      Value<String> businessId,
      Value<String> branchId,
      Value<String> locationName,
      Value<String> locationCode,
      Value<LocationType> locationType,
      Value<String?> parentLocationId,
      Value<String?> aisle,
      Value<String?> shelf,
      Value<String?> bin,
      Value<String?> barcode,
      Value<int?> maxCapacity,
      Value<int> currentCapacity,
      Value<bool> isSellableLocation,
      Value<bool> requiresCounting,
      Value<bool> temperatureControlled,
      Value<String> securityLevel,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$InventoryLocationsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryLocationsTable> {
  $$InventoryLocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationCode => $composableBuilder(
    column: $table.locationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocationType, LocationType, String>
  get locationType => $composableBuilder(
    column: $table.locationType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get parentLocationId => $composableBuilder(
    column: $table.parentLocationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aisle => $composableBuilder(
    column: $table.aisle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shelf => $composableBuilder(
    column: $table.shelf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bin => $composableBuilder(
    column: $table.bin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxCapacity => $composableBuilder(
    column: $table.maxCapacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentCapacity => $composableBuilder(
    column: $table.currentCapacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSellableLocation => $composableBuilder(
    column: $table.isSellableLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresCounting => $composableBuilder(
    column: $table.requiresCounting,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get temperatureControlled => $composableBuilder(
    column: $table.temperatureControlled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get securityLevel => $composableBuilder(
    column: $table.securityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryLocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryLocationsTable> {
  $$InventoryLocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationCode => $composableBuilder(
    column: $table.locationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationType => $composableBuilder(
    column: $table.locationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentLocationId => $composableBuilder(
    column: $table.parentLocationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aisle => $composableBuilder(
    column: $table.aisle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shelf => $composableBuilder(
    column: $table.shelf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bin => $composableBuilder(
    column: $table.bin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxCapacity => $composableBuilder(
    column: $table.maxCapacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentCapacity => $composableBuilder(
    column: $table.currentCapacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSellableLocation => $composableBuilder(
    column: $table.isSellableLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresCounting => $composableBuilder(
    column: $table.requiresCounting,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get temperatureControlled => $composableBuilder(
    column: $table.temperatureControlled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get securityLevel => $composableBuilder(
    column: $table.securityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryLocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryLocationsTable> {
  $$InventoryLocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationCode => $composableBuilder(
    column: $table.locationCode,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LocationType, String> get locationType =>
      $composableBuilder(
        column: $table.locationType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get parentLocationId => $composableBuilder(
    column: $table.parentLocationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aisle =>
      $composableBuilder(column: $table.aisle, builder: (column) => column);

  GeneratedColumn<String> get shelf =>
      $composableBuilder(column: $table.shelf, builder: (column) => column);

  GeneratedColumn<String> get bin =>
      $composableBuilder(column: $table.bin, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get maxCapacity => $composableBuilder(
    column: $table.maxCapacity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentCapacity => $composableBuilder(
    column: $table.currentCapacity,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSellableLocation => $composableBuilder(
    column: $table.isSellableLocation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresCounting => $composableBuilder(
    column: $table.requiresCounting,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get temperatureControlled => $composableBuilder(
    column: $table.temperatureControlled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get securityLevel => $composableBuilder(
    column: $table.securityLevel,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$InventoryLocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryLocationsTable,
          InventoryLocation,
          $$InventoryLocationsTableFilterComposer,
          $$InventoryLocationsTableOrderingComposer,
          $$InventoryLocationsTableAnnotationComposer,
          $$InventoryLocationsTableCreateCompanionBuilder,
          $$InventoryLocationsTableUpdateCompanionBuilder,
          (
            InventoryLocation,
            BaseReferences<
              _$AppDatabase,
              $InventoryLocationsTable,
              InventoryLocation
            >,
          ),
          InventoryLocation,
          PrefetchHooks Function()
        > {
  $$InventoryLocationsTableTableManager(
    _$AppDatabase db,
    $InventoryLocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryLocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryLocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryLocationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> locationId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> locationName = const Value.absent(),
                Value<String> locationCode = const Value.absent(),
                Value<LocationType> locationType = const Value.absent(),
                Value<String?> parentLocationId = const Value.absent(),
                Value<String?> aisle = const Value.absent(),
                Value<String?> shelf = const Value.absent(),
                Value<String?> bin = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int?> maxCapacity = const Value.absent(),
                Value<int> currentCapacity = const Value.absent(),
                Value<bool> isSellableLocation = const Value.absent(),
                Value<bool> requiresCounting = const Value.absent(),
                Value<bool> temperatureControlled = const Value.absent(),
                Value<String> securityLevel = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryLocationsCompanion(
                locationId: locationId,
                businessId: businessId,
                branchId: branchId,
                locationName: locationName,
                locationCode: locationCode,
                locationType: locationType,
                parentLocationId: parentLocationId,
                aisle: aisle,
                shelf: shelf,
                bin: bin,
                barcode: barcode,
                maxCapacity: maxCapacity,
                currentCapacity: currentCapacity,
                isSellableLocation: isSellableLocation,
                requiresCounting: requiresCounting,
                temperatureControlled: temperatureControlled,
                securityLevel: securityLevel,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String locationId,
                required String businessId,
                required String branchId,
                required String locationName,
                required String locationCode,
                required LocationType locationType,
                Value<String?> parentLocationId = const Value.absent(),
                Value<String?> aisle = const Value.absent(),
                Value<String?> shelf = const Value.absent(),
                Value<String?> bin = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int?> maxCapacity = const Value.absent(),
                Value<int> currentCapacity = const Value.absent(),
                Value<bool> isSellableLocation = const Value.absent(),
                Value<bool> requiresCounting = const Value.absent(),
                Value<bool> temperatureControlled = const Value.absent(),
                Value<String> securityLevel = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryLocationsCompanion.insert(
                locationId: locationId,
                businessId: businessId,
                branchId: branchId,
                locationName: locationName,
                locationCode: locationCode,
                locationType: locationType,
                parentLocationId: parentLocationId,
                aisle: aisle,
                shelf: shelf,
                bin: bin,
                barcode: barcode,
                maxCapacity: maxCapacity,
                currentCapacity: currentCapacity,
                isSellableLocation: isSellableLocation,
                requiresCounting: requiresCounting,
                temperatureControlled: temperatureControlled,
                securityLevel: securityLevel,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryLocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryLocationsTable,
      InventoryLocation,
      $$InventoryLocationsTableFilterComposer,
      $$InventoryLocationsTableOrderingComposer,
      $$InventoryLocationsTableAnnotationComposer,
      $$InventoryLocationsTableCreateCompanionBuilder,
      $$InventoryLocationsTableUpdateCompanionBuilder,
      (
        InventoryLocation,
        BaseReferences<
          _$AppDatabase,
          $InventoryLocationsTable,
          InventoryLocation
        >,
      ),
      InventoryLocation,
      PrefetchHooks Function()
    >;
typedef $$InventoryVariantsTableCreateCompanionBuilder =
    InventoryVariantsCompanion Function({
      required String variantId,
      required String inventoryId,
      required String businessId,
      Value<String?> colorId,
      Value<String?> sizeId,
      required String variantSku,
      Value<String?> variantBarcode,
      required String variantName,
      required String variantCode,
      Value<double> costPriceAdjustment,
      Value<double> priceAdjustment,
      Value<double?> finalCostPrice,
      Value<double?> finalRetailPrice,
      Value<String?> variantDescription,
      Value<String?> variantSpecifications,
      Value<String?> variantImages,
      Value<double> weightAdjustment,
      Value<String?> dimensionAdjustments,
      Value<int> minimumStockLevel,
      Value<int> reorderLevel,
      Value<int?> maximumStockLevel,
      Value<bool> isDefaultVariant,
      Value<bool> isAvailableOnline,
      Value<bool> isAvailableInStore,
      Value<DateTime?> availabilityDate,
      Value<DateTime?> discontinueDate,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$InventoryVariantsTableUpdateCompanionBuilder =
    InventoryVariantsCompanion Function({
      Value<String> variantId,
      Value<String> inventoryId,
      Value<String> businessId,
      Value<String?> colorId,
      Value<String?> sizeId,
      Value<String> variantSku,
      Value<String?> variantBarcode,
      Value<String> variantName,
      Value<String> variantCode,
      Value<double> costPriceAdjustment,
      Value<double> priceAdjustment,
      Value<double?> finalCostPrice,
      Value<double?> finalRetailPrice,
      Value<String?> variantDescription,
      Value<String?> variantSpecifications,
      Value<String?> variantImages,
      Value<double> weightAdjustment,
      Value<String?> dimensionAdjustments,
      Value<int> minimumStockLevel,
      Value<int> reorderLevel,
      Value<int?> maximumStockLevel,
      Value<bool> isDefaultVariant,
      Value<bool> isAvailableOnline,
      Value<bool> isAvailableInStore,
      Value<DateTime?> availabilityDate,
      Value<DateTime?> discontinueDate,
      Value<StatusType> status,
      Value<String?> createdBy,
      Value<String?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$InventoryVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryVariantsTable> {
  $$InventoryVariantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inventoryId => $composableBuilder(
    column: $table.inventoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeId => $composableBuilder(
    column: $table.sizeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantSku => $composableBuilder(
    column: $table.variantSku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantBarcode => $composableBuilder(
    column: $table.variantBarcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantCode => $composableBuilder(
    column: $table.variantCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPriceAdjustment => $composableBuilder(
    column: $table.costPriceAdjustment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceAdjustment => $composableBuilder(
    column: $table.priceAdjustment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalCostPrice => $composableBuilder(
    column: $table.finalCostPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalRetailPrice => $composableBuilder(
    column: $table.finalRetailPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantDescription => $composableBuilder(
    column: $table.variantDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantSpecifications => $composableBuilder(
    column: $table.variantSpecifications,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantImages => $composableBuilder(
    column: $table.variantImages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightAdjustment => $composableBuilder(
    column: $table.weightAdjustment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dimensionAdjustments => $composableBuilder(
    column: $table.dimensionAdjustments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minimumStockLevel => $composableBuilder(
    column: $table.minimumStockLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maximumStockLevel => $composableBuilder(
    column: $table.maximumStockLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefaultVariant => $composableBuilder(
    column: $table.isDefaultVariant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailableOnline => $composableBuilder(
    column: $table.isAvailableOnline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailableInStore => $composableBuilder(
    column: $table.isAvailableInStore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get availabilityDate => $composableBuilder(
    column: $table.availabilityDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get discontinueDate => $composableBuilder(
    column: $table.discontinueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatusType, StatusType, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryVariantsTable> {
  $$InventoryVariantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inventoryId => $composableBuilder(
    column: $table.inventoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeId => $composableBuilder(
    column: $table.sizeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantSku => $composableBuilder(
    column: $table.variantSku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantBarcode => $composableBuilder(
    column: $table.variantBarcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantCode => $composableBuilder(
    column: $table.variantCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPriceAdjustment => $composableBuilder(
    column: $table.costPriceAdjustment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceAdjustment => $composableBuilder(
    column: $table.priceAdjustment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalCostPrice => $composableBuilder(
    column: $table.finalCostPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalRetailPrice => $composableBuilder(
    column: $table.finalRetailPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantDescription => $composableBuilder(
    column: $table.variantDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantSpecifications => $composableBuilder(
    column: $table.variantSpecifications,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantImages => $composableBuilder(
    column: $table.variantImages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightAdjustment => $composableBuilder(
    column: $table.weightAdjustment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dimensionAdjustments => $composableBuilder(
    column: $table.dimensionAdjustments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minimumStockLevel => $composableBuilder(
    column: $table.minimumStockLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maximumStockLevel => $composableBuilder(
    column: $table.maximumStockLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefaultVariant => $composableBuilder(
    column: $table.isDefaultVariant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailableOnline => $composableBuilder(
    column: $table.isAvailableOnline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailableInStore => $composableBuilder(
    column: $table.isAvailableInStore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get availabilityDate => $composableBuilder(
    column: $table.availabilityDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get discontinueDate => $composableBuilder(
    column: $table.discontinueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryVariantsTable> {
  $$InventoryVariantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get inventoryId => $composableBuilder(
    column: $table.inventoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessId => $composableBuilder(
    column: $table.businessId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorId =>
      $composableBuilder(column: $table.colorId, builder: (column) => column);

  GeneratedColumn<String> get sizeId =>
      $composableBuilder(column: $table.sizeId, builder: (column) => column);

  GeneratedColumn<String> get variantSku => $composableBuilder(
    column: $table.variantSku,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantBarcode => $composableBuilder(
    column: $table.variantBarcode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantName => $composableBuilder(
    column: $table.variantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantCode => $composableBuilder(
    column: $table.variantCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costPriceAdjustment => $composableBuilder(
    column: $table.costPriceAdjustment,
    builder: (column) => column,
  );

  GeneratedColumn<double> get priceAdjustment => $composableBuilder(
    column: $table.priceAdjustment,
    builder: (column) => column,
  );

  GeneratedColumn<double> get finalCostPrice => $composableBuilder(
    column: $table.finalCostPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get finalRetailPrice => $composableBuilder(
    column: $table.finalRetailPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantDescription => $composableBuilder(
    column: $table.variantDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantSpecifications => $composableBuilder(
    column: $table.variantSpecifications,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantImages => $composableBuilder(
    column: $table.variantImages,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightAdjustment => $composableBuilder(
    column: $table.weightAdjustment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dimensionAdjustments => $composableBuilder(
    column: $table.dimensionAdjustments,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minimumStockLevel => $composableBuilder(
    column: $table.minimumStockLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maximumStockLevel => $composableBuilder(
    column: $table.maximumStockLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefaultVariant => $composableBuilder(
    column: $table.isDefaultVariant,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAvailableOnline => $composableBuilder(
    column: $table.isAvailableOnline,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAvailableInStore => $composableBuilder(
    column: $table.isAvailableInStore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get availabilityDate => $composableBuilder(
    column: $table.availabilityDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get discontinueDate => $composableBuilder(
    column: $table.discontinueDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatusType, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$InventoryVariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryVariantsTable,
          InventoryVariant,
          $$InventoryVariantsTableFilterComposer,
          $$InventoryVariantsTableOrderingComposer,
          $$InventoryVariantsTableAnnotationComposer,
          $$InventoryVariantsTableCreateCompanionBuilder,
          $$InventoryVariantsTableUpdateCompanionBuilder,
          (
            InventoryVariant,
            BaseReferences<
              _$AppDatabase,
              $InventoryVariantsTable,
              InventoryVariant
            >,
          ),
          InventoryVariant,
          PrefetchHooks Function()
        > {
  $$InventoryVariantsTableTableManager(
    _$AppDatabase db,
    $InventoryVariantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryVariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryVariantsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> variantId = const Value.absent(),
                Value<String> inventoryId = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String?> colorId = const Value.absent(),
                Value<String?> sizeId = const Value.absent(),
                Value<String> variantSku = const Value.absent(),
                Value<String?> variantBarcode = const Value.absent(),
                Value<String> variantName = const Value.absent(),
                Value<String> variantCode = const Value.absent(),
                Value<double> costPriceAdjustment = const Value.absent(),
                Value<double> priceAdjustment = const Value.absent(),
                Value<double?> finalCostPrice = const Value.absent(),
                Value<double?> finalRetailPrice = const Value.absent(),
                Value<String?> variantDescription = const Value.absent(),
                Value<String?> variantSpecifications = const Value.absent(),
                Value<String?> variantImages = const Value.absent(),
                Value<double> weightAdjustment = const Value.absent(),
                Value<String?> dimensionAdjustments = const Value.absent(),
                Value<int> minimumStockLevel = const Value.absent(),
                Value<int> reorderLevel = const Value.absent(),
                Value<int?> maximumStockLevel = const Value.absent(),
                Value<bool> isDefaultVariant = const Value.absent(),
                Value<bool> isAvailableOnline = const Value.absent(),
                Value<bool> isAvailableInStore = const Value.absent(),
                Value<DateTime?> availabilityDate = const Value.absent(),
                Value<DateTime?> discontinueDate = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryVariantsCompanion(
                variantId: variantId,
                inventoryId: inventoryId,
                businessId: businessId,
                colorId: colorId,
                sizeId: sizeId,
                variantSku: variantSku,
                variantBarcode: variantBarcode,
                variantName: variantName,
                variantCode: variantCode,
                costPriceAdjustment: costPriceAdjustment,
                priceAdjustment: priceAdjustment,
                finalCostPrice: finalCostPrice,
                finalRetailPrice: finalRetailPrice,
                variantDescription: variantDescription,
                variantSpecifications: variantSpecifications,
                variantImages: variantImages,
                weightAdjustment: weightAdjustment,
                dimensionAdjustments: dimensionAdjustments,
                minimumStockLevel: minimumStockLevel,
                reorderLevel: reorderLevel,
                maximumStockLevel: maximumStockLevel,
                isDefaultVariant: isDefaultVariant,
                isAvailableOnline: isAvailableOnline,
                isAvailableInStore: isAvailableInStore,
                availabilityDate: availabilityDate,
                discontinueDate: discontinueDate,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String variantId,
                required String inventoryId,
                required String businessId,
                Value<String?> colorId = const Value.absent(),
                Value<String?> sizeId = const Value.absent(),
                required String variantSku,
                Value<String?> variantBarcode = const Value.absent(),
                required String variantName,
                required String variantCode,
                Value<double> costPriceAdjustment = const Value.absent(),
                Value<double> priceAdjustment = const Value.absent(),
                Value<double?> finalCostPrice = const Value.absent(),
                Value<double?> finalRetailPrice = const Value.absent(),
                Value<String?> variantDescription = const Value.absent(),
                Value<String?> variantSpecifications = const Value.absent(),
                Value<String?> variantImages = const Value.absent(),
                Value<double> weightAdjustment = const Value.absent(),
                Value<String?> dimensionAdjustments = const Value.absent(),
                Value<int> minimumStockLevel = const Value.absent(),
                Value<int> reorderLevel = const Value.absent(),
                Value<int?> maximumStockLevel = const Value.absent(),
                Value<bool> isDefaultVariant = const Value.absent(),
                Value<bool> isAvailableOnline = const Value.absent(),
                Value<bool> isAvailableInStore = const Value.absent(),
                Value<DateTime?> availabilityDate = const Value.absent(),
                Value<DateTime?> discontinueDate = const Value.absent(),
                Value<StatusType> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryVariantsCompanion.insert(
                variantId: variantId,
                inventoryId: inventoryId,
                businessId: businessId,
                colorId: colorId,
                sizeId: sizeId,
                variantSku: variantSku,
                variantBarcode: variantBarcode,
                variantName: variantName,
                variantCode: variantCode,
                costPriceAdjustment: costPriceAdjustment,
                priceAdjustment: priceAdjustment,
                finalCostPrice: finalCostPrice,
                finalRetailPrice: finalRetailPrice,
                variantDescription: variantDescription,
                variantSpecifications: variantSpecifications,
                variantImages: variantImages,
                weightAdjustment: weightAdjustment,
                dimensionAdjustments: dimensionAdjustments,
                minimumStockLevel: minimumStockLevel,
                reorderLevel: reorderLevel,
                maximumStockLevel: maximumStockLevel,
                isDefaultVariant: isDefaultVariant,
                isAvailableOnline: isAvailableOnline,
                isAvailableInStore: isAvailableInStore,
                availabilityDate: availabilityDate,
                discontinueDate: discontinueDate,
                status: status,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryVariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryVariantsTable,
      InventoryVariant,
      $$InventoryVariantsTableFilterComposer,
      $$InventoryVariantsTableOrderingComposer,
      $$InventoryVariantsTableAnnotationComposer,
      $$InventoryVariantsTableCreateCompanionBuilder,
      $$InventoryVariantsTableUpdateCompanionBuilder,
      (
        InventoryVariant,
        BaseReferences<
          _$AppDatabase,
          $InventoryVariantsTable,
          InventoryVariant
        >,
      ),
      InventoryVariant,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$InventoryLineTableTableManager get inventoryLine =>
      $$InventoryLineTableTableManager(_db, _db.inventoryLine);
  $$CategoryTableTableTableManager get categoryTable =>
      $$CategoryTableTableTableManager(_db, _db.categoryTable);
  $$SubCategoryTableTableManager get subCategory =>
      $$SubCategoryTableTableManager(_db, _db.subCategory);
  $$InventoryColorsTableTableManager get inventoryColors =>
      $$InventoryColorsTableTableManager(_db, _db.inventoryColors);
  $$InventorySizesTableTableManager get inventorySizes =>
      $$InventorySizesTableTableManager(_db, _db.inventorySizes);
  $$SeasonTableTableManager get season =>
      $$SeasonTableTableManager(_db, _db.season);
  $$InventoryLocationsTableTableManager get inventoryLocations =>
      $$InventoryLocationsTableTableManager(_db, _db.inventoryLocations);
  $$InventoryVariantsTableTableManager get inventoryVariants =>
      $$InventoryVariantsTableTableManager(_db, _db.inventoryVariants);
}
