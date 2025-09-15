# Enterprise POS Backend System Documentation

## Overview

This is an enterprise-grade Flutter POS (Point of Sale) system with comprehensive multi-business support, advanced inventory control, role-based access control (RBAC), and complete activity tracking. The system uses Supabase for backend services and implements Clean Architecture with responsive design patterns.

The backend has been enhanced with normalized database schema, comprehensive audit trails, advanced cash management, payment processing, returns management, and promotional campaigns to meet enterprise requirements.

## Key Features

- **Multi-Tenant Architecture**: Complete business isolation with proper data segregation
- **Role-Based Access Control (RBAC)**: Hierarchical permission system with custom roles
- **Normalized Schema**: Proper database normalization with referential integrity
- **Enterprise Cash Management**: Comprehensive cashier sessions with reconciliation
- **Advanced Inventory**: Multi-location stock tracking with lot/serial number support
- **Payment Processing**: Multi-payment method support with comprehensive transaction tracking
- **Returns & Exchanges**: Complete return management with quality control workflow
- **Promotion Engine**: Advanced marketing campaigns with flexible rule engine
- **Comprehensive Audit Trail**: System-wide activity tracking for compliance
- **Performance Optimized**: Proper indexing, partitioning strategy, and query optimization

---

## System Entities Overview

**Core System:**
- Users: Authentication and user management
- UserRoles: Role-based access control system
- BusinessUsers: User-business relationship management
- Business: Multi-tenant business entities
- Branches: Physical/Online store locations
- Systems: POS terminal tracking

**Settings & Configuration:**
- PersonalSettings: User preferences
- SystemsSettings: POS configuration
- TaxRates: Centralized tax management

**Supplier & Procurement:**
- Suppliers: Vendor management
- PurchasesBill: Purchase bill verification
- Purchases: Purchase order management
- PurchaseLineItems: Normalized purchase transaction details

**Inventory Management:**
- InventoryLine: Product line organization
- Category/SubCategory: Product classification hierarchy
- InventoryColors/InventorySizes: Variant attributes
- Season: Seasonal merchandise grouping
- Inventory: Core product data
- InventoryVariants: Color/size combinations
- InventoryLocations: Multi-location inventory storage
- InventoryStock: Location-based stock tracking
- InventoryTracking: Stock movement audit trails

**Sales & Transactions:**
- Sales: Sales transaction records
- SalesLineItems: Normalized sales transaction details
- PaymentTransactions: Multi-payment transaction tracking
- Returns: Return/refund management
- Customer: Customer relationship management

**Cash Management:**
- CashierSessions: Cashier login/logout tracking
- CashRegisters: Physical register/counter management
- CashMovements: Transaction-level cash tracking
- SessionDenominations: Cash counting by denominations
- SessionAuditLog: Complete session audit trail
- CashFloatRequests: Cash float management

**Promotions & Discounts:**
- PromotionCampaigns: Marketing campaign management
- PromotionRules: Discount rule definitions
- PromotionUsage: Promotion usage tracking

**Reporting & Analytics:**
- DailySalesReports: Daily analytics with hourly data
- WeeklySalesReports: Weekly performance summaries
- MonthlySalesReports: Monthly analytics with category breakdowns

**Audit & Security:**
- AuditLog: System-wide audit trail
- UserSessions: User session management

---

# API Integration

## V2 API Architecture

The enhanced database schema directly aligns with the V2 API endpoints, providing:

### Endpoint Structure
```
/api/v2/{business_id}/{resource}
```

### Key Integration Points

**Multi-Tenancy**: All API endpoints enforce `business_id` isolation at the database level through Row-Level Security (RLS) policies.

**RBAC Integration**: API endpoints validate user permissions through the UserRoles and BusinessUsers tables before executing operations.

**Normalized Transactions**: 
- Sales endpoints work with both Sales and SalesLineItems tables
- Purchase endpoints handle Purchases and PurchaseLineItems tables
- Payment endpoints integrate with PaymentTransactions for multi-payment support

**Real-time Inventory**: API endpoints automatically update InventoryStock and create InventoryTracking records for all inventory-affecting operations.

### Authentication Flow
1. User authenticates via Supabase Auth
2. System validates BusinessUsers relationship  
3. UserRoles permissions are checked for requested operation
4. Row-Level Security policies enforce business-level data isolation

### Business Logic Integration
- **Sales Processing**: Creates Sales, SalesLineItems, PaymentTransactions, and InventoryTracking records atomically
- **Inventory Management**: Updates InventoryStock across multiple locations with proper tracking
- **Cash Management**: Integrates with CashierSessions for all cash-related operations
- **Promotions**: Real-time promotion validation and application through PromotionCampaigns

---

# ENUMS

## StatusType
["active", "blocked", "deleted"]

## SystemType
["mobile", "computer", "tablet"]

## PlacementType
["pre", "post"]

## BranchType
["shop", "online", "store"]

## SessionStatus
["active", "suspended", "closed"]

## MovementType
["sale", "refund", "deposit", "withdrawal", "float_in", "float_out", "adjustment"]

## ReconciliationStatus
["balanced", "over", "short"]

## UserRole
["super_admin", "business_owner", "business_admin", "branch_manager", "cashier", "inventory_manager", "sales_associate", "accountant", "viewer"]

## PaymentMethod
["cash", "card", "mobile_payment", "bank_transfer", "check", "store_credit", "loyalty_points"]

## PaymentStatus
["pending", "processing", "completed", "failed", "cancelled", "refunded", "partially_refunded"]

## TransactionType
["sale", "return", "exchange", "void", "training"]

## PromotionType
["percentage", "fixed_amount", "buy_x_get_y", "free_shipping", "loyalty_bonus"]

## LocationType
["storage", "display", "transit", "damaged", "reserved"]

## AuditAction
["create", "update", "delete", "login", "logout", "view", "export", "import"]

---

# BACKEND SCHEMA

## Users

Core user authentication and profile management with proper multi-tenancy support.

```sql
{
'user_id': String PRIMARY KEY,
'email': String UNIQUE NOT NULL,
'name': String NOT NULL,
'phone': String,
'avatar_url': String,
'is_email_verified': Boolean DEFAULT false,
'is_phone_verified': Boolean DEFAULT false,
'last_login_at': Timestamp,
'password_changed_at': Timestamp,
'two_factor_enabled': Boolean DEFAULT false,
'preferred_language': String DEFAULT 'en',
'timezone': String DEFAULT 'UTC',

'status': StatusType DEFAULT 'active',

'created_by': String,
'updated_by': String,
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
UNIQUE INDEX idx_users_email ON Users(email),
INDEX idx_users_status ON Users(status),
INDEX idx_users_last_login ON Users(last_login_at)
}
```

## UserRoles

Defines available roles in the system with hierarchical permissions.

```sql
{
'role_id': String PRIMARY KEY,
'role_name': UserRole UNIQUE NOT NULL,
'role_display_name': String NOT NULL,
'role_description': String,
'permissions': JSON NOT NULL, -- Array of permission strings
'is_system_role': Boolean DEFAULT false,
'hierarchy_level': Integer NOT NULL, -- 1=highest, 10=lowest

'status': StatusType DEFAULT 'active',

'created_by': String,
'updated_by': String,
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
UNIQUE INDEX idx_roles_name ON UserRoles(role_name),
INDEX idx_roles_hierarchy ON UserRoles(hierarchy_level)
}
```

## BusinessUsers

Junction table managing user-business relationships with role assignments.

```sql
{
'business_user_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'user_id': String NOT NULL REFERENCES Users(user_id),
'role_id': String NOT NULL REFERENCES UserRoles(role_id),
'assigned_branches': JSON, -- Array of branch_ids user can access
'custom_permissions': JSON, -- Additional/restricted permissions
'employment_start_date': Date,
'employment_end_date': Date,
'is_primary_business': Boolean DEFAULT false,

'status': StatusType DEFAULT 'active',

'created_by': String,
'updated_by': String,
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_business_users_unique ON BusinessUsers(business_id, user_id),
INDEX idx_business_users_business ON BusinessUsers(business_id),
INDEX idx_business_users_user ON BusinessUsers(user_id),
INDEX idx_business_users_role ON BusinessUsers(role_id)
}
```

## Business

Enhanced business entity with proper constraints and business intelligence fields.

```sql
{
'business_id': String PRIMARY KEY,
'business_code': String UNIQUE NOT NULL, -- Business registration/tax number
'business_name': String NOT NULL,
'business_type': String, -- retail, wholesale, restaurant, etc.
'logo_url': String,
'website_url': String,
'phone': String,
'email': String,
'address': String,
'city': String,
'state': String,
'country': String DEFAULT 'US',
'postal_code': String,
'tax_number': String,
'registration_number': String,
'default_currency': String DEFAULT 'USD',
'default_tax_rate': Decimal(5,4) DEFAULT 0.0000,
'business_settings': JSON, -- Business-specific configurations
'subscription_plan': String DEFAULT 'basic',
'subscription_expires_at': Timestamp,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
UNIQUE INDEX idx_business_code ON Business(business_code),
INDEX idx_business_name ON Business(business_name),
INDEX idx_business_status ON Business(status),
INDEX idx_business_subscription ON Business(subscription_plan, subscription_expires_at)
}
```

## Branches

Enhanced branch management with proper location and operational data.

```sql
{
'branch_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_code': String NOT NULL, -- Unique within business
'branch_name': String NOT NULL,
'branch_type': BranchType DEFAULT 'shop',
'address': String NOT NULL,
'city': String NOT NULL,
'state': String NOT NULL,
'country': String DEFAULT 'US',
'postal_code': String,
'phone': String,
'email': String,
'manager_user_id': String REFERENCES Users(user_id),
'operating_hours': JSON, -- Weekly schedule
'timezone': String DEFAULT 'UTC',
'coordinates': JSON, -- lat/lng for delivery/mapping
'is_warehouse': Boolean DEFAULT false,
'allows_online_orders': Boolean DEFAULT true,
'delivery_radius_km': Decimal(8,2),

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_branches_business_code ON Branches(business_id, branch_code),
INDEX idx_branches_business ON Branches(business_id),
INDEX idx_branches_manager ON Branches(manager_user_id),
INDEX idx_branches_location ON Branches(city, state, country)
}
```

## Systems

Enhanced POS terminal tracking with device management capabilities.

```sql
{
'system_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'system_name': String NOT NULL,
'system_code': String NOT NULL, -- Unique within branch
'system_type': SystemType NOT NULL,
'device_info': JSON, -- Hardware specs, OS version, etc.
'mac_address': String,
'ip_address': String,
'installed_version': String,
'last_sync_at': Timestamp,
'is_online': Boolean DEFAULT false,
'assigned_user_id': String REFERENCES Users(user_id),

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_systems_branch_code ON Systems(branch_id, system_code),
INDEX idx_systems_business ON Systems(business_id),
INDEX idx_systems_branch ON Systems(branch_id),
INDEX idx_systems_online ON Systems(is_online),
INDEX idx_systems_assigned ON Systems(assigned_user_id)
}
```

## TaxRates

Centralized tax management with date-based rate changes.

```sql
{
'tax_rate_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'tax_name': String NOT NULL, -- Sales Tax, VAT, etc.
'tax_code': String NOT NULL,
'tax_rate': Decimal(5,4) NOT NULL, -- e.g., 0.0825 for 8.25%
'effective_from': Date NOT NULL,
'effective_until': Date,
'applies_to': JSON, -- Categories, products, or 'all'
'is_inclusive': Boolean DEFAULT false, -- Tax included in price
'calculation_order': Integer DEFAULT 1,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_tax_rates_business_code ON TaxRates(business_id, tax_code),
INDEX idx_tax_rates_effective ON TaxRates(effective_from, effective_until),
INDEX idx_tax_rates_business ON TaxRates(business_id)
}
```

## PersonalSettings

Enhanced user preferences with business-specific settings.

```sql
{
'setting_id': String PRIMARY KEY,
'user_id': String NOT NULL REFERENCES Users(user_id),
'business_id': String REFERENCES Business(business_id), -- Business-specific settings
'theme': String DEFAULT 'light',
'language': String DEFAULT 'en-US',
'currency': String DEFAULT 'USD',
'timezone': String DEFAULT 'UTC',
'date_format': String DEFAULT 'MM/DD/YYYY',
'time_format': String DEFAULT '12h',
'number_format': JSON, -- Decimal places, separators
'notification_preferences': JSON,
'dashboard_layout': JSON,
'quick_access_items': JSON,

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_personal_settings_user_business ON PersonalSettings(user_id, business_id),
INDEX idx_personal_settings_user ON PersonalSettings(user_id)
}
```

## SystemsSettings

Enhanced POS configuration with template management.

```sql
{
'system_setting_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'system_id': String NOT NULL REFERENCES Systems(system_id),
'pos_name': String NOT NULL,
'receipt_templates': JSON, -- Multiple receipt types
'receipt_header': String,
'receipt_footer': String,
'default_tax_rate_id': String REFERENCES TaxRates(tax_rate_id),
'currency_symbol': String DEFAULT '$',
'auto_print_receipt': Boolean DEFAULT false,
'auto_open_drawer': Boolean DEFAULT true,
'require_customer_info': Boolean DEFAULT false,
'allow_negative_inventory': Boolean DEFAULT false,
'low_inventory_alert_threshold': Integer DEFAULT 10,
'barcode_scanner_enabled': Boolean DEFAULT true,
'scale_integration_enabled': Boolean DEFAULT false,
'offline_mode_enabled': Boolean DEFAULT true,
'sync_interval_minutes': Integer DEFAULT 15,
'backup_settings': JSON,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_systems_settings_system ON SystemsSettings(system_id),
INDEX idx_systems_settings_business ON SystemsSettings(business_id),
INDEX idx_systems_settings_tax_rate ON SystemsSettings(default_tax_rate_id)
}
```

## CashRegisters

Enhanced cash register management with security and tracking features.

```sql
{
'register_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'register_name': String NOT NULL,
'register_code': String NOT NULL, -- Unique within branch
'register_location': String,
'system_id': String REFERENCES Systems(system_id),
'is_active': Boolean DEFAULT true,
'requires_manager_override': Boolean DEFAULT false,
'max_cash_amount': Decimal(10,2),
'starting_float_amount': Decimal(10,2) DEFAULT 0.00,
'device_info': JSON,
'last_maintenance_date': Date,
'maintenance_schedule': JSON,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_registers_branch_code ON CashRegisters(branch_id, register_code),
INDEX idx_registers_business ON CashRegisters(business_id),
INDEX idx_registers_branch ON CashRegisters(branch_id),
INDEX idx_registers_system ON CashRegisters(system_id),
INDEX idx_registers_active ON CashRegisters(is_active)
}
```

## CashierSessions

Enhanced cashier session management with comprehensive tracking.

```sql
{
'session_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'register_id': String NOT NULL REFERENCES CashRegisters(register_id),
'cashier_id': String NOT NULL REFERENCES Users(user_id),
'session_number': String GENERATED NOT NULL, -- Auto-generated format
'login_time': Timestamp NOT NULL DEFAULT NOW(),
'logout_time': Timestamp,
'expected_logout_time': Timestamp,
'opening_cash_amount': Decimal(10,2) NOT NULL,
'closing_cash_amount': Decimal(10,2),
'expected_cash_amount': Decimal(10,2) GENERATED, -- Calculated field
'cash_difference': Decimal(10,2) GENERATED, -- closing - expected
'reconciliation_status': ReconciliationStatus,
'session_status': SessionStatus DEFAULT 'active',
'notes': TEXT,
'suspension_reason': String,
'suspended_at': Timestamp,
'resumed_at': Timestamp,
'manager_override_by': String REFERENCES Users(user_id),
'override_reason': String,
'session_settings': JSON,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
INDEX idx_sessions_business ON CashierSessions(business_id),
INDEX idx_sessions_branch ON CashierSessions(branch_id),
INDEX idx_sessions_register ON CashierSessions(register_id),
INDEX idx_sessions_cashier ON CashierSessions(cashier_id),
INDEX idx_sessions_status ON CashierSessions(session_status),
INDEX idx_sessions_date ON CashierSessions(login_time),
UNIQUE INDEX idx_sessions_active_register ON CashierSessions(register_id) WHERE session_status = 'active'
}
```

## CashMovements

Enhanced cash movement tracking with detailed categorization.

```sql
{
'movement_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'session_id': String NOT NULL REFERENCES CashierSessions(session_id),
'register_id': String NOT NULL REFERENCES CashRegisters(register_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'movement_type': MovementType NOT NULL,
'amount': Decimal(10,2) NOT NULL,
'running_total': Decimal(10,2) NOT NULL,
'reference_id': String, -- Links to sales, returns, etc.
'reference_type': String,
'description': TEXT,
'payment_method': PaymentMethod,
'cash_amount': Decimal(10,2), -- Actual cash portion if mixed payment
'transaction_time': Timestamp DEFAULT NOW(),
'processed_by': String NOT NULL REFERENCES Users(user_id),
'approved_by': String REFERENCES Users(user_id), -- For large amounts
'void_reason': String,
'voided_by': String REFERENCES Users(user_id),
'voided_at': Timestamp,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_movements_business ON CashMovements(business_id),
INDEX idx_movements_session ON CashMovements(session_id),
INDEX idx_movements_register ON CashMovements(register_id),
INDEX idx_movements_type ON CashMovements(movement_type),
INDEX idx_movements_time ON CashMovements(transaction_time),
INDEX idx_movements_reference ON CashMovements(reference_type, reference_id)
}
```

## SessionDenominations

Enhanced denomination tracking with verification workflow.

```sql
{
'denomination_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'session_id': String NOT NULL REFERENCES CashierSessions(session_id),
'counting_type': String NOT NULL, -- 'opening', 'closing', 'mid_shift'
'denominations': JSON NOT NULL, -- Detailed breakdown structure
'total_amount': Decimal(10,2) GENERATED NOT NULL, -- Sum of all denominations
'counted_by': String NOT NULL REFERENCES Users(user_id),
'verified_by': String REFERENCES Users(user_id),
'count_time': Timestamp DEFAULT NOW(),
'verification_time': Timestamp,
'discrepancy_amount': Decimal(10,2),
'notes': TEXT,
'recount_required': Boolean DEFAULT false,
'images': JSON, -- Photos of cash count

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_denominations_business ON SessionDenominations(business_id),
INDEX idx_denominations_session ON SessionDenominations(session_id),
INDEX idx_denominations_type ON SessionDenominations(counting_type),
INDEX idx_denominations_counted_by ON SessionDenominations(counted_by)
}
```

## CashFloatRequests

Enhanced float management with approval workflow.

```sql
{
'float_request_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'from_register_id': String REFERENCES CashRegisters(register_id),
'to_register_id': String NOT NULL REFERENCES CashRegisters(register_id),
'requested_by': String NOT NULL REFERENCES Users(user_id),
'approved_by': String REFERENCES Users(user_id),
'processed_by': String REFERENCES Users(user_id),
'request_type': String NOT NULL, -- 'increase', 'decrease', 'transfer'
'amount': Decimal(10,2) NOT NULL,
'reason': TEXT NOT NULL,
'priority': String DEFAULT 'normal', -- 'urgent', 'normal', 'low'
'request_status': String DEFAULT 'pending',
'request_time': Timestamp DEFAULT NOW(),
'approval_time': Timestamp,
'completion_time': Timestamp,
'notes': TEXT,
'supporting_documents': JSON, -- Attached files/images

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_float_requests_business ON CashFloatRequests(business_id),
INDEX idx_float_requests_branch ON CashFloatRequests(branch_id),
INDEX idx_float_requests_status ON CashFloatRequests(request_status),
INDEX idx_float_requests_to_register ON CashFloatRequests(to_register_id),
INDEX idx_float_requests_requested_by ON CashFloatRequests(requested_by)
}
```

## Suppliers

Enhanced supplier management with comprehensive vendor information.

```sql
{
'supplier_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'supplier_code': String NOT NULL, -- Unique within business
'supplier_name': String NOT NULL,
'supplier_type': String, -- 'manufacturer', 'distributor', 'wholesaler'
'contact_person': String,
'phone': String,
'email': String,
'website': String,
'address': String,
'city': String,
'state': String,
'country': String,
'postal_code': String,
'tax_number': String,
'payment_terms': String, -- 'Net 30', 'COD', '2/10 Net 30'
'credit_limit': Decimal(12,2),
'currency': String DEFAULT 'USD',
'lead_time_days': Integer,
'minimum_order_amount': Decimal(10,2),
'shipping_methods': JSON,
'quality_rating': Decimal(3,2), -- 1.00 to 5.00
'delivery_rating': Decimal(3,2),
'price_rating': Decimal(3,2),
'preferred_supplier': Boolean DEFAULT false,
'contract_start_date': Date,
'contract_end_date': Date,
'notes': TEXT,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_suppliers_business_code ON Suppliers(business_id, supplier_code),
INDEX idx_suppliers_business ON Suppliers(business_id),
INDEX idx_suppliers_name ON Suppliers(supplier_name),
INDEX idx_suppliers_preferred ON Suppliers(preferred_supplier)
}
```

## InventoryLine

Enhanced product line management with hierarchical organization.

```sql
{
'inventory_line_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'line_code': String NOT NULL,
'line_name': String NOT NULL,
'line_description': TEXT,
'line_placement': PlacementType DEFAULT 'pre',
'parent_line_id': String REFERENCES InventoryLine(inventory_line_id),
'sort_order': Integer DEFAULT 0,
'is_active': Boolean DEFAULT true,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_inventory_line_business_code ON InventoryLine(business_id, line_code),
INDEX idx_inventory_line_business ON InventoryLine(business_id),
INDEX idx_inventory_line_parent ON InventoryLine(parent_line_id)
}
```

## Category

Enhanced category management with improved hierarchy and SEO support.

```sql
{
'category_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'category_code': String NOT NULL,
'category_name': String NOT NULL,
'category_description': TEXT,
'parent_category_id': String REFERENCES Category(category_id),
'category_image_url': String,
'seo_slug': String,
'meta_title': String,
'meta_description': String,
'code_placement': PlacementType DEFAULT 'pre',
'sort_order': Integer DEFAULT 0,
'is_featured': Boolean DEFAULT false,
'commission_rate': Decimal(5,4), -- Sales commission for this category

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_category_business_code ON Category(business_id, category_code),
UNIQUE INDEX idx_category_business_slug ON Category(business_id, seo_slug),
INDEX idx_category_business ON Category(business_id),
INDEX idx_category_parent ON Category(parent_category_id),
INDEX idx_category_featured ON Category(is_featured)
}
```

## SubCategory

Enhanced sub-category management with automated counter and better organization.

```sql
{
'sub_category_id': String PRIMARY KEY,
'category_id': String NOT NULL REFERENCES Category(category_id),
'business_id': String NOT NULL REFERENCES Business(business_id),
'sub_category_code': String NOT NULL,
'sub_category_name': String NOT NULL,
'sub_category_description': TEXT,
'code_placement': PlacementType DEFAULT 'pre',
'counter': Integer GENERATED, -- Auto-incremented within category
'sort_order': Integer DEFAULT 0,
'sub_category_image_url': String,
'size_chart_url': String, -- For clothing categories
'care_instructions': TEXT, -- For applicable items

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_subcategory_category_code ON SubCategory(category_id, sub_category_code),
INDEX idx_subcategory_business ON SubCategory(business_id),
INDEX idx_subcategory_category ON SubCategory(category_id)
}
```

## InventoryColors

Enhanced color management with advanced color specifications.

```sql
{
'color_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'color_name': String NOT NULL,
'color_code': String NOT NULL, -- SKU code component
'hex_color': String, -- #FFFFFF format
'rgb_color': String, -- rgb(255,255,255) format
'pantone_code': String, -- Pantone color matching
'supplier_color_code': String, -- Vendor's color reference
'color_family': String, -- Red, Blue, Green, etc.
'is_seasonal': Boolean DEFAULT false,
'season_ids': JSON, -- Array of applicable season IDs
'display_order': Integer DEFAULT 0,
'color_image_url': String, -- Sample color swatch image

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_colors_business_code ON InventoryColors(business_id, color_code),
INDEX idx_colors_business ON InventoryColors(business_id),
INDEX idx_colors_family ON InventoryColors(color_family),
INDEX idx_colors_seasonal ON InventoryColors(is_seasonal)
}
```

## InventorySizes

Enhanced size management with detailed size specifications.

```sql
{
'size_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'sub_category_id': String REFERENCES SubCategory(sub_category_id),
'size_name': String NOT NULL, -- S, M, L or 32, 34, 36
'size_code': String NOT NULL, -- SKU component
'size_type': String NOT NULL, -- 'clothing', 'shoes', 'generic', 'numeric'
'size_system': String, -- US, EU, UK, etc.
'size_measurements': JSON, -- Detailed measurements
'size_chart_position': Integer,
'display_order': Integer DEFAULT 0,
'equivalent_sizes': JSON, -- Size conversions to other systems

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_sizes_business_subcat_code ON InventorySizes(business_id, sub_category_id, size_code),
INDEX idx_sizes_business ON InventorySizes(business_id),
INDEX idx_sizes_subcategory ON InventorySizes(sub_category_id),
INDEX idx_sizes_type ON InventorySizes(size_type)
}
```

## Season

Enhanced seasonal management with date ranges and marketing support.

```sql
{
'season_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'season_name': String NOT NULL,
'season_code': String NOT NULL,
'season_description': TEXT,
'start_date': Date,
'end_date': Date,
'is_current_season': Boolean DEFAULT false,
'marketing_themes': JSON, -- Colors, styles, themes
'target_demographics': JSON,
'seasonal_markup_percentage': Decimal(5,2), -- Additional markup for season

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_seasons_business_code ON Season(business_id, season_code),
INDEX idx_seasons_business ON Season(business_id),
INDEX idx_seasons_current ON Season(is_current_season),
INDEX idx_seasons_dates ON Season(start_date, end_date)
}
```

## InventoryLocations

Multi-location inventory storage management with capacity tracking.

```sql
{
'location_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'location_name': String NOT NULL,
'location_code': String NOT NULL,
'location_type': LocationType NOT NULL,
'parent_location_id': String REFERENCES InventoryLocations(location_id),
'aisle': String,
'shelf': String,
'bin': String,
'barcode': String,
'max_capacity': Integer,
'current_capacity': Integer DEFAULT 0,
'is_sellable_location': Boolean DEFAULT true,
'requires_counting': Boolean DEFAULT true,
'temperature_controlled': Boolean DEFAULT false,
'security_level': String DEFAULT 'standard', -- standard, high, restricted

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_locations_branch_code ON InventoryLocations(branch_id, location_code),
INDEX idx_locations_business ON InventoryLocations(business_id),
INDEX idx_locations_branch ON InventoryLocations(branch_id),
INDEX idx_locations_type ON InventoryLocations(location_type),
INDEX idx_locations_parent ON InventoryLocations(parent_location_id)
}
```

## Inventory

Enhanced inventory management with comprehensive product information.

```sql
{
'inventory_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'inventory_line_id': String REFERENCES InventoryLine(inventory_line_id),
'category_id': String NOT NULL REFERENCES Category(category_id),
'sub_category_id': String REFERENCES SubCategory(sub_category_id),
'supplier_id': String REFERENCES Suppliers(supplier_id),
'season_id': String REFERENCES Season(season_id),

-- Product Identification
'sku': String UNIQUE NOT NULL, -- Stock Keeping Unit
'product_code': String NOT NULL, -- Internal product code
'barcode': String,
'upc_code': String,
'isbn': String, -- For books
'model_number': String,
'manufacturer_part_number': String,

-- Product Information
'product_name': String NOT NULL,
'product_description': TEXT,
'short_description': String,
'specifications': JSON,
'brand': String,
'manufacturer': String,
'country_of_origin': String,
'material': String,
'care_instructions': TEXT,
'warranty_period_months': Integer,
'age_restriction': String, -- Age requirements if applicable

-- Pricing
'cost_price': Decimal(10,2) NOT NULL,
'wholesale_price': Decimal(10,2),
'retail_price': Decimal(10,2) NOT NULL,
'msrp': Decimal(10,2), -- Manufacturer Suggested Retail Price
'markup_percentage': Decimal(5,2) GENERATED,
'margin_percentage': Decimal(5,2) GENERATED,

-- Inventory Management
'unit_of_measure': String DEFAULT 'piece',
'minimum_stock_level': Integer DEFAULT 0,
'reorder_level': Integer DEFAULT 0,
'maximum_stock_level': Integer,
'reorder_quantity': Integer,
'lead_time_days': Integer,

-- Physical Properties
'weight': Decimal(8,3), -- kg
'length': Decimal(8,2), -- cm
'width': Decimal(8,2), -- cm
'height': Decimal(8,2), -- cm
'volume': Decimal(8,3) GENERATED, -- cubic cm

-- Tracking
'is_serialized': Boolean DEFAULT false,
'is_perishable': Boolean DEFAULT false,
'expiry_date': Date,
'lot_tracking': Boolean DEFAULT false,
'has_variants': Boolean DEFAULT false,

-- Images and Media
'primary_image_url': String,
'image_urls': JSON, -- Array of additional images
'video_url': String,
'document_urls': JSON, -- Manuals, certificates, etc.

-- SEO and Marketing
'seo_slug': String,
'meta_title': String,
'meta_description': String,
'keywords': JSON,
'is_featured': Boolean DEFAULT false,
'is_gift_card': Boolean DEFAULT false,
'gift_card_type': String, -- 'physical', 'digital'

-- Sales Restrictions
'is_discountable': Boolean DEFAULT true,
'is_returnable': Boolean DEFAULT true,
'return_period_days': Integer DEFAULT 30,
'requires_age_verification': Boolean DEFAULT false,
'requires_id_check': Boolean DEFAULT false,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints and Indexes
UNIQUE INDEX idx_inventory_sku ON Inventory(sku),
UNIQUE INDEX idx_inventory_barcode ON Inventory(barcode) WHERE barcode IS NOT NULL,
INDEX idx_inventory_business ON Inventory(business_id),
INDEX idx_inventory_category ON Inventory(category_id),
INDEX idx_inventory_subcategory ON Inventory(sub_category_id),
INDEX idx_inventory_supplier ON Inventory(supplier_id),
INDEX idx_inventory_brand ON Inventory(brand),
INDEX idx_inventory_featured ON Inventory(is_featured),
INDEX idx_inventory_price_range ON Inventory(retail_price),
INDEX idx_inventory_search ON Inventory USING gin(to_tsvector('english', product_name || ' ' || COALESCE(product_description, '')))
}
```

## InventoryVariants

Enhanced product variants with comprehensive variant management.

```sql
{
'variant_id': String PRIMARY KEY,
'inventory_id': String NOT NULL REFERENCES Inventory(inventory_id),
'business_id': String NOT NULL REFERENCES Business(business_id),
'color_id': String REFERENCES InventoryColors(color_id),
'size_id': String REFERENCES InventorySizes(size_id),

-- Variant Identification
'variant_sku': String UNIQUE NOT NULL,
'variant_barcode': String UNIQUE,
'variant_name': String NOT NULL, -- Generated: "Product Name - Red - Large"
'variant_code': String NOT NULL, -- Short variant identifier

-- Pricing Adjustments
'cost_price_adjustment': Decimal(10,2) DEFAULT 0.00,
'price_adjustment': Decimal(10,2) DEFAULT 0.00,
'final_cost_price': Decimal(10,2) GENERATED,
'final_retail_price': Decimal(10,2) GENERATED,

-- Variant-Specific Information
'variant_description': TEXT,
'variant_specifications': JSON,
'variant_images': JSON, -- Variant-specific images
'weight_adjustment': Decimal(8,3) DEFAULT 0.000,
'dimension_adjustments': JSON, -- L/W/H adjustments

-- Inventory Settings
'minimum_stock_level': Integer DEFAULT 0,
'reorder_level': Integer DEFAULT 0,
'maximum_stock_level': Integer,

-- Availability
'is_default_variant': Boolean DEFAULT false,
'is_available_online': Boolean DEFAULT true,
'is_available_in_store': Boolean DEFAULT true,
'availability_date': Date, -- When variant becomes available
'discontinue_date': Date, -- When to stop selling

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_variants_sku ON InventoryVariants(variant_sku),
UNIQUE INDEX idx_variants_barcode ON InventoryVariants(variant_barcode) WHERE variant_barcode IS NOT NULL,
UNIQUE INDEX idx_variants_inventory_color_size ON InventoryVariants(inventory_id, color_id, size_id),
INDEX idx_variants_business ON InventoryVariants(business_id),
INDEX idx_variants_inventory ON InventoryVariants(inventory_id),
INDEX idx_variants_color ON InventoryVariants(color_id),
INDEX idx_variants_size ON InventoryVariants(size_id),
INDEX idx_variants_default ON InventoryVariants(is_default_variant)
}
```

## InventoryStock

Location-based stock tracking with real-time inventory management.

```sql
{
'stock_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'inventory_id': String NOT NULL REFERENCES Inventory(inventory_id),
'variant_id': String REFERENCES InventoryVariants(variant_id),
'location_id': String NOT NULL REFERENCES InventoryLocations(location_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),

-- Stock Quantities
'quantity_available': Integer DEFAULT 0,
'quantity_reserved': Integer DEFAULT 0, -- Reserved for pending orders
'quantity_damaged': Integer DEFAULT 0,
'quantity_expired': Integer DEFAULT 0,
'quantity_in_transit': Integer DEFAULT 0,
'total_quantity': Integer GENERATED, -- Sum of all quantities

-- Costing (for FIFO/LIFO)
'average_cost': Decimal(10,2),
'last_cost': Decimal(10,2),
'fifo_layers': JSON, -- For FIFO costing

-- Tracking
'last_counted_date': Date,
'last_counted_by': String REFERENCES Users(user_id),
'cycle_count_due_date': Date,
'last_movement_date': Timestamp,
'last_sale_date': Date,
'last_purchase_date': Date,

-- Lot/Serial Tracking
'lot_number': String,
'serial_numbers': JSON, -- For serialized items
'expiry_date': Date,
'received_date': Date,

-- Alerts
'reorder_point_reached': Boolean DEFAULT false,
'overstock_alert': Boolean DEFAULT false,
'expiry_alert_date': Date,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_stock_inventory_variant_location ON InventoryStock(inventory_id, variant_id, location_id),
INDEX idx_stock_business ON InventoryStock(business_id),
INDEX idx_stock_location ON InventoryStock(location_id),
INDEX idx_stock_branch ON InventoryStock(branch_id),
INDEX idx_stock_reorder ON InventoryStock(reorder_point_reached),
INDEX idx_stock_expiry ON InventoryStock(expiry_date)
}
```

## InventoryTracking

Enhanced inventory movement tracking with comprehensive audit trail.

```sql
{
'tracking_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'inventory_id': String NOT NULL REFERENCES Inventory(inventory_id),
'variant_id': String REFERENCES InventoryVariants(variant_id),
'location_id': String REFERENCES InventoryLocations(location_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),

-- Movement Details
'transaction_type': String NOT NULL, -- 'in', 'out', 'transfer', 'adjustment', 'count'
'movement_reason': String NOT NULL, -- 'sale', 'purchase', 'return', 'damage', 'theft', 'transfer'
'quantity_change': Integer NOT NULL, -- Positive for in, negative for out
'unit_cost': Decimal(10,2),
'total_cost': Decimal(10,2) GENERATED,

-- Before/After Quantities
'quantity_before': Integer NOT NULL,
'quantity_after': Integer NOT NULL,

-- Reference Information
'reference_type': String, -- 'sale', 'purchase', 'return', 'transfer', 'adjustment'
'reference_id': String, -- ID of source transaction
'reference_document': String, -- Document number

-- Transfer Details (if applicable)
'from_location_id': String REFERENCES InventoryLocations(location_id),
'to_location_id': String REFERENCES InventoryLocations(location_id),
'from_branch_id': String REFERENCES Branches(branch_id),
'to_branch_id': String REFERENCES Branches(branch_id),

-- Lot/Serial Tracking
'lot_number': String,
'serial_number': String,
'expiry_date': Date,

-- Additional Information
'notes': TEXT,
'processed_by': String NOT NULL REFERENCES Users(user_id),
'approved_by': String REFERENCES Users(user_id), -- For adjustments
'system_generated': Boolean DEFAULT false,
'correction_of_tracking_id': String REFERENCES InventoryTracking(tracking_id),

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_tracking_business ON InventoryTracking(business_id),
INDEX idx_tracking_inventory ON InventoryTracking(inventory_id),
INDEX idx_tracking_variant ON InventoryTracking(variant_id),
INDEX idx_tracking_location ON InventoryTracking(location_id),
INDEX idx_tracking_branch ON InventoryTracking(branch_id),
INDEX idx_tracking_type ON InventoryTracking(transaction_type),
INDEX idx_tracking_reference ON InventoryTracking(reference_type, reference_id),
INDEX idx_tracking_date ON InventoryTracking(created_at),
INDEX idx_tracking_processed_by ON InventoryTracking(processed_by)
}
```

## Sales

Enhanced sales transaction management with comprehensive transaction support.

```sql
{
'sale_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'system_id': String NOT NULL REFERENCES Systems(system_id),
'cashier_session_id': String REFERENCES CashierSessions(session_id),
'customer_id': String REFERENCES Customer(customer_id),

-- Transaction Identification
'transaction_number': String UNIQUE NOT NULL, -- Auto-generated
'receipt_number': String UNIQUE NOT NULL,
'pos_transaction_id': String, -- Local POS system ID
'external_order_id': String, -- From e-commerce platform

-- Transaction Details
'transaction_type': TransactionType DEFAULT 'sale',
'transaction_date': Timestamp DEFAULT NOW(),
'sale_date': Date GENERATED, -- Date only for reporting
'cashier_id': String NOT NULL REFERENCES Users(user_id),
'sales_associate_id': String REFERENCES Users(user_id),

-- Financial Information
'subtotal': Decimal(10,2) NOT NULL,
'total_tax': Decimal(10,2) NOT NULL DEFAULT 0.00,
'total_discount': Decimal(10,2) NOT NULL DEFAULT 0.00,
'shipping_amount': Decimal(10,2) NOT NULL DEFAULT 0.00,
'tip_amount': Decimal(10,2) NOT NULL DEFAULT 0.00,
'total_amount': Decimal(10,2) NOT NULL,
'rounding_adjustment': Decimal(10,2) NOT NULL DEFAULT 0.00,

-- Payment Information
'payment_status': PaymentStatus DEFAULT 'completed',
'payment_method_summary': JSON, -- Summary of payment methods used
'change_given': Decimal(10,2) NOT NULL DEFAULT 0.00,

-- Customer Information
'customer_email': String,
'customer_phone': String,
'customer_name': String,
'loyalty_points_earned': Integer DEFAULT 0,
'loyalty_points_redeemed': Integer DEFAULT 0,

-- Fulfillment
'fulfillment_type': String DEFAULT 'in_store', -- 'in_store', 'pickup', 'delivery', 'ship'
'fulfillment_status': String DEFAULT 'completed',
'delivery_address': JSON,
'pickup_date': Timestamp,
'delivery_date': Timestamp,
'tracking_number': String,

-- Additional Information
'notes': TEXT,
'internal_notes': TEXT, -- Staff notes not printed on receipt
'gift_receipt': Boolean DEFAULT false,
'no_receipt': Boolean DEFAULT false,
'email_receipt': Boolean DEFAULT false,
'receipt_printed': Boolean DEFAULT false,

-- Promotions and Discounts
'promotion_codes': JSON, -- Applied promotion codes
'discount_reason': String,
'manager_override': Boolean DEFAULT false,
'override_reason': String,
'overridden_by': String REFERENCES Users(user_id),

-- Training and Testing
'is_training_transaction': Boolean DEFAULT false,
'is_test_transaction': Boolean DEFAULT false,

-- Returns and Exchanges
'original_sale_id': String REFERENCES Sales(sale_id), -- For returns/exchanges
'return_reason': String,
'exchange_difference': Decimal(10,2),

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
UNIQUE INDEX idx_sales_transaction_number ON Sales(transaction_number),
UNIQUE INDEX idx_sales_receipt_number ON Sales(receipt_number),
INDEX idx_sales_business ON Sales(business_id),
INDEX idx_sales_branch ON Sales(branch_id),
INDEX idx_sales_date ON Sales(sale_date),
INDEX idx_sales_customer ON Sales(customer_id),
INDEX idx_sales_cashier ON Sales(cashier_id),
INDEX idx_sales_session ON Sales(cashier_session_id),
INDEX idx_sales_status ON Sales(payment_status),
INDEX idx_sales_amount ON Sales(total_amount),
INDEX idx_sales_type ON Sales(transaction_type)
}
```

## SalesLineItems

Normalized sales line items with comprehensive product tracking.

```sql
{
'line_item_id': String PRIMARY KEY,
'sale_id': String NOT NULL REFERENCES Sales(sale_id),
'business_id': String NOT NULL REFERENCES Business(business_id),
'inventory_id': String NOT NULL REFERENCES Inventory(inventory_id),
'variant_id': String REFERENCES InventoryVariants(variant_id),

-- Product Information (at time of sale)
'product_name': String NOT NULL,
'variant_name': String,
'sku': String NOT NULL,
'barcode': String,

-- Quantities and Pricing
'quantity': Integer NOT NULL,
'unit_price': Decimal(10,2) NOT NULL,
'original_unit_price': Decimal(10,2) NOT NULL, -- Before any discounts
'cost_price': Decimal(10,2) NOT NULL, -- For margin calculations

-- Line Total Calculations
'line_subtotal': Decimal(10,2) GENERATED, -- quantity * unit_price
'line_discount_amount': Decimal(10,2) NOT NULL DEFAULT 0.00,
'line_tax_amount': Decimal(10,2) NOT NULL DEFAULT 0.00,
'line_total': Decimal(10,2) GENERATED, -- subtotal - discount + tax

-- Discounts
'discount_type': String, -- 'percentage', 'fixed', 'promotion'
'discount_value': Decimal(10,4),
'discount_reason': String,
'promotion_id': String REFERENCES PromotionCampaigns(promotion_id),

-- Tax Information
'tax_rate_id': String REFERENCES TaxRates(tax_rate_id),
'tax_rate': Decimal(5,4),
'is_tax_exempt': Boolean DEFAULT false,
'tax_exempt_reason': String,

-- Inventory Impact
'inventory_deducted': Boolean DEFAULT true,
'serial_number': String,
'lot_number': String,
'location_id': String REFERENCES InventoryLocations(location_id),

-- Returns and Exchanges
'is_returnable': Boolean DEFAULT true,
'is_exchangeable': Boolean DEFAULT true,
'return_deadline': Date,
'returned_quantity': Integer DEFAULT 0,
'exchanged_quantity': Integer DEFAULT 0,
'refunded_amount': Decimal(10,2) DEFAULT 0.00,

-- Additional Information
'notes': TEXT,
'gift_wrap': Boolean DEFAULT false,
'gift_message': String,
'warranty_period_months': Integer,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_sales_line_items_sale ON SalesLineItems(sale_id),
INDEX idx_sales_line_items_business ON SalesLineItems(business_id),
INDEX idx_sales_line_items_inventory ON SalesLineItems(inventory_id),
INDEX idx_sales_line_items_variant ON SalesLineItems(variant_id),
INDEX idx_sales_line_items_date ON SalesLineItems(created_at),
INDEX idx_sales_line_items_promotion ON SalesLineItems(promotion_id)
}
```

## PaymentTransactions

Comprehensive payment transaction management supporting multiple payment methods.

```sql
{
'payment_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'sale_id': String NOT NULL REFERENCES Sales(sale_id),
'cashier_session_id': String REFERENCES CashierSessions(session_id),

-- Payment Information
'payment_method': PaymentMethod NOT NULL,
'payment_amount': Decimal(10,2) NOT NULL,
'payment_status': PaymentStatus DEFAULT 'completed',
'currency': String DEFAULT 'USD',
'exchange_rate': Decimal(10,6) DEFAULT 1.000000,

-- Card Payment Details
'card_type': String, -- 'credit', 'debit', 'gift'
'card_brand': String, -- 'Visa', 'MasterCard', 'Amex'
'card_last_four': String,
'card_holder_name': String,
'authorization_code': String,
'transaction_id': String, -- From payment processor
'terminal_id': String,
'batch_number': String,
'emv_data': JSON,

-- Digital Payment Details
'digital_wallet_type': String, -- 'Apple Pay', 'Google Pay', 'PayPal'
'digital_transaction_id': String,
'digital_reference': String,

-- Cash Payment Details
'cash_received': Decimal(10,2),
'change_given': Decimal(10,2),
'cash_drawer_id': String,

-- Check Payment Details
'check_number': String,
'bank_name': String,
'account_number_last_four': String,

-- Store Credit/Gift Card Details
'gift_card_number': String,
'gift_card_balance_before': Decimal(10,2),
'gift_card_balance_after': Decimal(10,2),

-- Loyalty Points
'loyalty_points_used': Integer DEFAULT 0,
'loyalty_points_value': Decimal(10,2) DEFAULT 0.00,

-- Processing Information
'processor_name': String,
'processor_transaction_id': String,
'processor_response': JSON,
'processing_fee': Decimal(10,2) DEFAULT 0.00,
'net_amount': Decimal(10,2) GENERATED, -- amount - processing_fee

-- Settlement Information
'settlement_date': Date,
'settled_amount': Decimal(10,2),
'settlement_reference': String,

-- Refund Information
'is_refund': Boolean DEFAULT false,
'refund_reason': String,
'original_payment_id': String REFERENCES PaymentTransactions(payment_id),
'refunded_amount': Decimal(10,2) DEFAULT 0.00,
'refund_reference': String,

-- Timestamps
'processed_at': Timestamp DEFAULT NOW(),
'authorized_at': Timestamp,
'captured_at': Timestamp,
'voided_at': Timestamp,
'refunded_at': Timestamp,

-- Verification
'signature_required': Boolean DEFAULT false,
'signature_captured': Boolean DEFAULT false,
'id_verified': Boolean DEFAULT false,
'verification_method': String,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_payments_business ON PaymentTransactions(business_id),
INDEX idx_payments_sale ON PaymentTransactions(sale_id),
INDEX idx_payments_session ON PaymentTransactions(cashier_session_id),
INDEX idx_payments_method ON PaymentTransactions(payment_method),
INDEX idx_payments_status ON PaymentTransactions(payment_status),
INDEX idx_payments_date ON PaymentTransactions(processed_at),
INDEX idx_payments_processor_id ON PaymentTransactions(processor_transaction_id),
INDEX idx_payments_settlement ON PaymentTransactions(settlement_date)
}
```

## Returns

Comprehensive return and refund management system.

```sql
{
'return_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'original_sale_id': String NOT NULL REFERENCES Sales(sale_id),
'return_transaction_id': String REFERENCES Sales(sale_id), -- New sale record for return

-- Return Information
'return_number': String UNIQUE NOT NULL,
'return_date': Timestamp DEFAULT NOW(),
'return_type': String NOT NULL, -- 'return', 'exchange', 'store_credit'
'return_reason': String NOT NULL,
'return_condition': String, -- 'new', 'used', 'damaged', 'defective'

-- Staff Information
'processed_by': String NOT NULL REFERENCES Users(user_id),
'authorized_by': String REFERENCES Users(user_id),
'manager_override': Boolean DEFAULT false,

-- Customer Information
'customer_id': String REFERENCES Customer(customer_id),
'customer_satisfaction_rating': Integer, -- 1-5 scale

-- Financial Information
'original_total': Decimal(10,2) NOT NULL,
'return_total': Decimal(10,2) NOT NULL,
'restocking_fee': Decimal(10,2) DEFAULT 0.00,
'refund_amount': Decimal(10,2) NOT NULL,
'store_credit_issued': Decimal(10,2) DEFAULT 0.00,
'exchange_value': Decimal(10,2) DEFAULT 0.00,

-- Processing Information
'receipt_provided': Boolean DEFAULT false,
'original_receipt_number': String,
'return_within_policy': Boolean DEFAULT true,
'policy_exception_reason': String,

-- Quality Control
'quality_check_required': Boolean DEFAULT false,
'quality_check_completed': Boolean DEFAULT false,
'quality_check_passed': Boolean DEFAULT false,
'quality_check_notes': TEXT,
'quality_checked_by': String REFERENCES Users(user_id),

-- Inventory Impact
'inventory_restocked': Boolean DEFAULT false,
'restock_location_id': String REFERENCES InventoryLocations(location_id),
'items_damaged': Boolean DEFAULT false,
'vendor_return_required': Boolean DEFAULT false,

-- Additional Information
'notes': TEXT,
'photos': JSON, -- Images of returned items
'customer_feedback': TEXT,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
UNIQUE INDEX idx_returns_number ON Returns(return_number),
INDEX idx_returns_business ON Returns(business_id),
INDEX idx_returns_branch ON Returns(branch_id),
INDEX idx_returns_original_sale ON Returns(original_sale_id),
INDEX idx_returns_date ON Returns(return_date),
INDEX idx_returns_type ON Returns(return_type),
INDEX idx_returns_processed_by ON Returns(processed_by)
}
```

## ReturnLineItems

Detailed line items for returns with individual item tracking.

```sql
{
'return_line_id': String PRIMARY KEY,
'return_id': String NOT NULL REFERENCES Returns(return_id),
'business_id': String NOT NULL REFERENCES Business(business_id),
'original_line_item_id': String NOT NULL REFERENCES SalesLineItems(line_item_id),
'inventory_id': String NOT NULL REFERENCES Inventory(inventory_id),
'variant_id': String REFERENCES InventoryVariants(variant_id),

-- Product Information
'product_name': String NOT NULL,
'variant_name': String,
'sku': String NOT NULL,
'serial_number': String,
'lot_number': String,

-- Quantities and Pricing
'original_quantity': Integer NOT NULL,
'return_quantity': Integer NOT NULL,
'original_unit_price': Decimal(10,2) NOT NULL,
'refund_unit_price': Decimal(10,2) NOT NULL,
'line_refund_total': Decimal(10,2) GENERATED,

-- Return Details
'return_reason': String NOT NULL,
'item_condition': String NOT NULL,
'is_defective': Boolean DEFAULT false,
'is_damaged': Boolean DEFAULT false,
'defect_description': TEXT,

-- Processing
'restocking_fee_rate': Decimal(5,4) DEFAULT 0.0000,
'restocking_fee_amount': Decimal(10,2) DEFAULT 0.00,
'final_refund_amount': Decimal(10,2) GENERATED,

-- Inventory Impact
'restock_quantity': Integer DEFAULT 0,
'restock_location_id': String REFERENCES InventoryLocations(location_id),
'dispose_quantity': Integer DEFAULT 0,
'vendor_return_quantity': Integer DEFAULT 0,

-- Quality Control
'quality_notes': TEXT,
'photos': JSON,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_return_line_items_return ON ReturnLineItems(return_id),
INDEX idx_return_line_items_business ON ReturnLineItems(business_id),
INDEX idx_return_line_items_original ON ReturnLineItems(original_line_item_id),
INDEX idx_return_line_items_inventory ON ReturnLineItems(inventory_id)
}
```

## PromotionCampaigns

Marketing campaigns and promotion management system.

```sql
{
'promotion_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'campaign_name': String NOT NULL,
'campaign_code': String NOT NULL, -- Customer-facing code
'promotion_type': PromotionType NOT NULL,
'description': TEXT,

-- Discount Configuration
'discount_value': Decimal(10,4) NOT NULL, -- Percentage or fixed amount
'max_discount_amount': Decimal(10,2), -- Cap for percentage discounts
'min_purchase_amount': Decimal(10,2), -- Minimum order value

-- Buy X Get Y Configuration
'buy_quantity': Integer,
'get_quantity': Integer,
'get_discount_percentage': Decimal(5,2),

-- Validity Period
'start_date': Timestamp NOT NULL,
'end_date': Timestamp NOT NULL,
'start_time': Time, -- Daily start time if applicable
'end_time': Time, -- Daily end time if applicable
'valid_days_of_week': JSON, -- [1,2,3,4,5,6,7] for Sun-Sat

-- Usage Limits
'total_usage_limit': Integer,
'per_customer_limit': Integer,
'per_day_limit': Integer,
'current_usage_count': Integer DEFAULT 0,

-- Applicability
'applicable_to': String NOT NULL, -- 'all', 'categories', 'products', 'brands'
'applicable_categories': JSON,
'applicable_products': JSON,
'applicable_brands': JSON,
'excluded_categories': JSON,
'excluded_products': JSON,

-- Customer Targeting
'customer_groups': JSON, -- VIP, Regular, New, etc.
'min_customer_tier': String,
'first_time_customers_only': Boolean DEFAULT false,
'loyalty_members_only': Boolean DEFAULT false,

-- Channel Restrictions
'valid_channels': JSON, -- 'in_store', 'online', 'mobile_app'
'valid_branches': JSON, -- Specific branch restrictions

-- Stacking Rules
'stackable_with_other_promotions': Boolean DEFAULT false,
'stackable_promotion_types': JSON,
'priority': Integer DEFAULT 1, -- Higher priority applies first

-- Display and Marketing
'display_name': String,
'marketing_message': TEXT,
'banner_image_url': String,
'terms_and_conditions': TEXT,
'is_featured': Boolean DEFAULT false,
'show_on_receipt': Boolean DEFAULT true,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_promotions_business_code ON PromotionCampaigns(business_id, campaign_code),
INDEX idx_promotions_business ON PromotionCampaigns(business_id),
INDEX idx_promotions_dates ON PromotionCampaigns(start_date, end_date),
INDEX idx_promotions_type ON PromotionCampaigns(promotion_type),
INDEX idx_promotions_featured ON PromotionCampaigns(is_featured)
}
```

## PromotionUsage

Track individual promotion usage for analytics and limit enforcement.

```sql
{
'usage_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'promotion_id': String NOT NULL REFERENCES PromotionCampaigns(promotion_id),
'sale_id': String NOT NULL REFERENCES Sales(sale_id),
'customer_id': String REFERENCES Customer(customer_id),

-- Usage Details
'usage_date': Timestamp DEFAULT NOW(),
'discount_amount': Decimal(10,2) NOT NULL,
'original_order_value': Decimal(10,2) NOT NULL,
'final_order_value': Decimal(10,2) NOT NULL,

-- Applicable Items
'applicable_line_items': JSON, -- Array of line_item_ids that qualified

-- Customer Information
'customer_tier': String,
'customer_usage_count': Integer, -- This customer's usage count for this promotion

-- Processing Information
'processed_by': String NOT NULL REFERENCES Users(user_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'system_id': String REFERENCES Systems(system_id),

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_promotion_usage_business ON PromotionUsage(business_id),
INDEX idx_promotion_usage_promotion ON PromotionUsage(promotion_id),
INDEX idx_promotion_usage_sale ON PromotionUsage(sale_id),
INDEX idx_promotion_usage_customer ON PromotionUsage(customer_id),
INDEX idx_promotion_usage_date ON PromotionUsage(usage_date)
}
```

## Purchases

Enhanced purchase order management with comprehensive supplier integration.

```sql
{
'purchase_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'supplier_id': String NOT NULL REFERENCES Suppliers(supplier_id),

-- Purchase Order Information
'purchase_order_number': String UNIQUE NOT NULL,
'supplier_invoice_number': String,
'purchase_date': Date NOT NULL,
'expected_delivery_date': Date,
'actual_delivery_date': Date,
'order_deadline': Date,

-- Requester Information
'requested_by': String NOT NULL REFERENCES Users(user_id),
'approved_by': String REFERENCES Users(user_id),
'received_by': String REFERENCES Users(user_id),

-- Financial Information
'subtotal': Decimal(12,2) NOT NULL,
'tax_rate': Decimal(5,4) NOT NULL,
'tax_amount': Decimal(12,2) NOT NULL,
'shipping_cost': Decimal(12,2) DEFAULT 0.00,
'handling_fee': Decimal(12,2) DEFAULT 0.00,
'discount_amount': Decimal(12,2) DEFAULT 0.00,
'total_amount': Decimal(12,2) NOT NULL,
'currency': String DEFAULT 'USD',
'exchange_rate': Decimal(10,6) DEFAULT 1.000000,

-- Status Information
'order_status': String DEFAULT 'draft', -- draft, sent, acknowledged, partial, completed, cancelled
'payment_status': PaymentStatus DEFAULT 'pending',
'delivery_status': String DEFAULT 'pending', -- pending, partial, completed, delayed

-- Terms and Conditions
'payment_terms': String NOT NULL,
'shipping_terms': String,
'delivery_instructions': TEXT,
'special_instructions': TEXT,

-- Shipping Information
'shipping_method': String,
'tracking_number': String,
'carrier': String,
'shipping_address': JSON,

-- Quality and Inspection
'inspection_required': Boolean DEFAULT false,
'quality_check_completed': Boolean DEFAULT false,
'quality_issues_found': Boolean DEFAULT false,
'quality_notes': TEXT,

-- Documentation
'contract_reference': String,
'requisition_number': String,
'budget_code': String,
'cost_center': String,
'attached_documents': JSON,

-- Recurring Orders
'is_recurring_order': Boolean DEFAULT false,
'recurring_frequency': String, -- weekly, monthly, quarterly
'next_order_date': Date,
'recurring_until_date': Date,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints and Indexes
UNIQUE INDEX idx_purchases_po_number ON Purchases(purchase_order_number),
INDEX idx_purchases_business ON Purchases(business_id),
INDEX idx_purchases_branch ON Purchases(branch_id),
INDEX idx_purchases_supplier ON Purchases(supplier_id),
INDEX idx_purchases_status ON Purchases(order_status),
INDEX idx_purchases_date ON Purchases(purchase_date),
INDEX idx_purchases_delivery ON Purchases(expected_delivery_date)
}
```

## PurchaseLineItems

Normalized purchase line items with detailed tracking and receiving information.

```sql
{
'line_item_id': String PRIMARY KEY,
'purchase_id': String NOT NULL REFERENCES Purchases(purchase_id),
'business_id': String NOT NULL REFERENCES Business(business_id),
'inventory_id': String NOT NULL REFERENCES Inventory(inventory_id),
'variant_id': String REFERENCES InventoryVariants(variant_id),

-- Product Information (at time of order)
'product_name': String NOT NULL,
'variant_name': String,
'sku': String NOT NULL,
'supplier_product_code': String,
'manufacturer_part_number': String,

-- Quantities
'quantity_ordered': Integer NOT NULL,
'quantity_received': Integer DEFAULT 0,
'quantity_accepted': Integer DEFAULT 0,
'quantity_rejected': Integer DEFAULT 0,
'quantity_back_ordered': Integer DEFAULT 0,
'unit_of_measure': String DEFAULT 'piece',

-- Pricing
'unit_cost': Decimal(10,2) NOT NULL,
'original_unit_cost': Decimal(10,2) NOT NULL, -- Before any discounts
'line_discount_percentage': Decimal(5,4) DEFAULT 0.0000,
'line_discount_amount': Decimal(10,2) DEFAULT 0.00,
'final_unit_cost': Decimal(10,2) GENERATED,
'line_total': Decimal(10,2) GENERATED, -- quantity_ordered * final_unit_cost

-- Delivery Information
'expected_delivery_date': Date,
'actual_delivery_date': Date,
'delivery_status': String DEFAULT 'pending', -- pending, partial, complete, back_ordered

-- Quality Control
'quality_check_required': Boolean DEFAULT false,
'quality_check_passed': Boolean DEFAULT false,
'quality_notes': TEXT,
'rejection_reason': String,
'defect_rate': Decimal(5,4), -- Percentage of defective items

-- Lot and Serial Tracking
'lot_number': String,
'expiry_date': Date,
'serial_numbers': JSON, -- For serialized items
'manufacturing_date': Date,

-- Receiving Information
'received_by': String REFERENCES Users(user_id),
'received_date': Timestamp,
'receiving_notes': TEXT,
'receiving_location_id': String REFERENCES InventoryLocations(location_id),

-- Costing
'landed_cost': Decimal(10,2), -- Including shipping, duties, etc.
'duty_rate': Decimal(5,4),
'duty_amount': Decimal(10,2),

-- Returns to Vendor
'return_to_vendor': Boolean DEFAULT false,
'return_reason': String,
'return_quantity': Integer DEFAULT 0,
'return_date': Date,
'vendor_credit_amount': Decimal(10,2) DEFAULT 0.00,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Indexes
INDEX idx_purchase_line_items_purchase ON PurchaseLineItems(purchase_id),
INDEX idx_purchase_line_items_business ON PurchaseLineItems(business_id),
INDEX idx_purchase_line_items_inventory ON PurchaseLineItems(inventory_id),
INDEX idx_purchase_line_items_variant ON PurchaseLineItems(variant_id),
INDEX idx_purchase_line_items_delivery ON PurchaseLineItems(delivery_status),
INDEX idx_purchase_line_items_received ON PurchaseLineItems(received_date)
}
```

## Customer

Enhanced customer management with comprehensive CRM capabilities.

```sql
{
'customer_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'customer_number': String UNIQUE NOT NULL, -- Auto-generated customer number
'customer_type': String DEFAULT 'individual', -- individual, business, vip

-- Personal Information
'first_name': String NOT NULL,
'last_name': String NOT NULL,
'full_name': String GENERATED, -- first_name + ' ' + last_name
'date_of_birth': Date,
'gender': String, -- male, female, other, prefer_not_to_say
'preferred_language': String DEFAULT 'en',

-- Contact Information
'email': String,
'phone': String,
'mobile': String,
'fax': String,
'preferred_contact_method': String DEFAULT 'email', -- email, phone, mobile, sms

-- Address Information
'billing_address': JSON,
'shipping_address': JSON,
'same_as_billing': Boolean DEFAULT true,

-- Business Information (for business customers)
'company_name': String,
'business_type': String,
'tax_number': String,
'business_registration_number': String,

-- Account Information
'account_status': String DEFAULT 'active', -- active, suspended, closed
'account_opened_date': Date DEFAULT CURRENT_DATE,
'credit_limit': Decimal(12,2) DEFAULT 0.00,
'payment_terms': String DEFAULT 'immediate',
'price_level': String DEFAULT 'retail', -- retail, wholesale, vip

-- Loyalty Program
'loyalty_member': Boolean DEFAULT false,
'loyalty_number': String UNIQUE,
'loyalty_tier': String, -- bronze, silver, gold, platinum
'loyalty_points_balance': Integer DEFAULT 0,
'loyalty_points_lifetime': Integer DEFAULT 0,
'loyalty_join_date': Date,

-- Purchase History Metrics
'first_purchase_date': Date,
'last_purchase_date': Date,
'total_purchases_count': Integer DEFAULT 0,
'total_purchases_amount': Decimal(12,2) DEFAULT 0.00,
'average_order_value': Decimal(10,2) DEFAULT 0.00,
'last_visit_date': Date,
'visit_count': Integer DEFAULT 0,

-- Marketing Preferences
'email_marketing_opt_in': Boolean DEFAULT false,
'sms_marketing_opt_in': Boolean DEFAULT false,
'phone_marketing_opt_in': Boolean DEFAULT false,
'mail_marketing_opt_in': Boolean DEFAULT false,
'marketing_opt_in_date': Timestamp,

-- Behavioral Data
'preferred_categories': JSON, -- Array of category preferences
'favorite_brands': JSON,
'seasonal_shopper': Boolean DEFAULT false,
'price_sensitive': Boolean DEFAULT false,
'impulse_buyer': Boolean DEFAULT false,

-- Customer Service
'notes': TEXT, -- Staff notes about customer
'internal_notes': TEXT, -- Internal notes not visible to customer
'customer_service_rating': Decimal(3,2), -- Average service rating
'complaint_count': Integer DEFAULT 0,
'last_complaint_date': Date,

-- Social Media
'social_media_profiles': JSON, -- Facebook, Instagram, Twitter links

-- Referral Information
'referral_source': String, -- How they found the business
'referred_by_customer_id': String REFERENCES Customer(customer_id),
'referral_count': Integer DEFAULT 0, -- How many customers they referred

-- Tags and Segmentation
'customer_tags': JSON, -- Array of custom tags
'customer_segment': String, -- High value, regular, at-risk, etc.
'risk_score': Integer, -- Credit/fraud risk score

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints and Indexes
UNIQUE INDEX idx_customers_number ON Customer(customer_number),
UNIQUE INDEX idx_customers_loyalty ON Customer(loyalty_number) WHERE loyalty_number IS NOT NULL,
INDEX idx_customers_business ON Customer(business_id),
INDEX idx_customers_email ON Customer(email),
INDEX idx_customers_phone ON Customer(phone),
INDEX idx_customers_name ON Customer(last_name, first_name),
INDEX idx_customers_loyalty_member ON Customer(loyalty_member),
INDEX idx_customers_tier ON Customer(loyalty_tier),
INDEX idx_customers_segment ON Customer(customer_segment),
INDEX idx_customers_last_purchase ON Customer(last_purchase_date),
INDEX idx_customers_total_amount ON Customer(total_purchases_amount)
}
```

## AuditLog

System-wide comprehensive audit trail for compliance and security monitoring.

```sql
{
'audit_id': String PRIMARY KEY,
'business_id': String REFERENCES Business(business_id),
'user_id': String REFERENCES Users(user_id),
'session_id': String, -- User session identifier

-- Action Information
'action': AuditAction NOT NULL,
'resource_type': String NOT NULL, -- Table or entity name
'resource_id': String, -- Primary key of affected record
'resource_name': String, -- Human-readable name of resource

-- Change Details
'old_values': JSON, -- Previous state
'new_values': JSON, -- New state after change
'changed_fields': JSON, -- Array of field names that changed

-- Request Context
'ip_address': String,
'user_agent': String,
'request_id': String, -- Correlation ID for request tracking
'endpoint': String, -- API endpoint or page accessed
'http_method': String,

-- Additional Context
'reason': String, -- Reason for action if applicable
'notes': TEXT, -- Additional audit notes
'sensitivity_level': String DEFAULT 'normal', -- normal, sensitive, confidential

-- Metadata
'occurred_at': Timestamp DEFAULT NOW(),
'browser_info': JSON,
'device_info': JSON,
'location_data': JSON, -- Geolocation if available

-- Results
'success': Boolean DEFAULT true,
'error_message': TEXT,
'response_time_ms': Integer,

-- Indexes for performance
INDEX idx_audit_business ON AuditLog(business_id),
INDEX idx_audit_user ON AuditLog(user_id),
INDEX idx_audit_occurred_at ON AuditLog(occurred_at),
INDEX idx_audit_action ON AuditLog(action),
INDEX idx_audit_resource ON AuditLog(resource_type, resource_id),
INDEX idx_audit_ip ON AuditLog(ip_address),
INDEX idx_audit_success ON AuditLog(success)
}
```

## DailySalesReports

Aggregated daily sales data with hourly breakdowns, payment methods, and top-selling items.

```sql
{
'daily_report_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'system_id': String REFERENCES Systems(system_id),
'report_date': Date NOT NULL,
'total_sales': Decimal(12,2) NOT NULL,
'total_transactions': Integer NOT NULL,
'total_items_sold': Integer NOT NULL,
'total_tax': Decimal(10,2) NOT NULL,
'total_discount': Decimal(10,2) NOT NULL,
'payment_methods': JSON NOT NULL, -- Breakdown by payment method
'top_selling_items': JSON, -- Top 10 products
'hourly_sales': JSON, -- Sales by hour breakdown
'average_transaction_value': Decimal(10,2) GENERATED,
'transactions_per_hour': Decimal(6,2) GENERATED,

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_daily_reports_business_branch_date ON DailySalesReports(business_id, branch_id, report_date),
INDEX idx_daily_reports_business ON DailySalesReports(business_id),
INDEX idx_daily_reports_date ON DailySalesReports(report_date)
}
```

## WeeklySalesReports

Weekly sales summaries with daily breakdowns and performance metrics.

```sql
{
'weekly_report_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'week_start_date': Date NOT NULL,
'week_end_date': Date NOT NULL,
'total_sales': Decimal(12,2) NOT NULL,
'total_transactions': Integer NOT NULL,
'total_items_sold': Integer NOT NULL,
'total_tax': Decimal(10,2) NOT NULL,
'total_discount': Decimal(10,2) NOT NULL,
'average_daily_sales': Decimal(10,2) GENERATED,
'payment_methods': JSON NOT NULL,
'daily_breakdown': JSON, -- Sales by day
'top_selling_items': JSON,
'growth_percentage': Decimal(5,2), -- Week over week growth

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_weekly_reports_business_branch_dates ON WeeklySalesReports(business_id, branch_id, week_start_date),
INDEX idx_weekly_reports_business ON WeeklySalesReports(business_id),
INDEX idx_weekly_reports_dates ON WeeklySalesReports(week_start_date, week_end_date)
}
```

## MonthlySalesReports

Monthly sales analytics with comprehensive performance metrics.

```sql
{
'monthly_report_id': String PRIMARY KEY,
'business_id': String NOT NULL REFERENCES Business(business_id),
'branch_id': String NOT NULL REFERENCES Branches(branch_id),
'month': Integer NOT NULL, -- 1-12
'year': Integer NOT NULL,
'total_sales': Decimal(12,2) NOT NULL,
'total_transactions': Integer NOT NULL,
'total_items_sold': Integer NOT NULL,
'total_tax': Decimal(10,2) NOT NULL,
'total_discount': Decimal(10,2) NOT NULL,
'average_daily_sales': Decimal(10,2) GENERATED,
'payment_methods': JSON NOT NULL,
'weekly_breakdown': JSON, -- Sales by week
'categories_performance': JSON, -- Performance by category
'top_selling_items': JSON,
'customer_metrics': JSON, -- New vs returning customers
'growth_percentage': Decimal(5,2), -- Month over month growth

'status': StatusType DEFAULT 'active',

'created_by': String REFERENCES Users(user_id),
'updated_by': String REFERENCES Users(user_id),
'created_at': Timestamp DEFAULT NOW(),
'updated_at': Timestamp DEFAULT NOW(),

-- Constraints
UNIQUE INDEX idx_monthly_reports_business_branch_period ON MonthlySalesReports(business_id, branch_id, year, month),
INDEX idx_monthly_reports_business ON MonthlySalesReports(business_id),
INDEX idx_monthly_reports_period ON MonthlySalesReports(year, month)
}
```

---

# PERFORMANCE CONSIDERATIONS

## Critical Indexes

```sql
-- Business Multi-tenancy
CREATE INDEX CONCURRENTLY idx_business_id_composite ON table_name(business_id, frequently_queried_field);

-- Date-based Queries (for reporting)
CREATE INDEX CONCURRENTLY idx_sales_business_date ON Sales(business_id, sale_date);
CREATE INDEX CONCURRENTLY idx_inventory_tracking_date ON InventoryTracking(business_id, created_at);

-- Cash Management
CREATE INDEX CONCURRENTLY idx_sessions_active_register ON CashierSessions(register_id, session_status);
CREATE INDEX CONCURRENTLY idx_movements_session_time ON CashMovements(session_id, transaction_time);

-- Inventory Performance
CREATE INDEX CONCURRENTLY idx_inventory_stock_location ON InventoryStock(location_id, inventory_id);
CREATE INDEX CONCURRENTLY idx_stock_reorder ON InventoryStock(business_id, reorder_point_reached) WHERE reorder_point_reached = true;

-- Sales Performance
CREATE INDEX CONCURRENTLY idx_sales_customer_date ON Sales(customer_id, sale_date);
CREATE INDEX CONCURRENTLY idx_line_items_inventory_date ON SalesLineItems(inventory_id, created_at);
```

## Partitioning Strategy

For high-volume tables, implement partitioning:

```sql
-- Partition large tables by date for performance
-- Sales by month
CREATE TABLE Sales_2024_01 PARTITION OF Sales FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

-- Audit logs by quarter
CREATE TABLE AuditLog_2024_Q1 PARTITION OF AuditLog FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

-- Inventory tracking by month
CREATE TABLE InventoryTracking_2024_01 PARTITION OF InventoryTracking FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');
```

## Query Optimization Patterns

1. **Always filter by business_id first** for multi-tenant queries
2. **Use composite indexes** for common query patterns
3. **Implement proper pagination** for large result sets
4. **Use covering indexes** for frequently accessed columns
5. **Monitor query performance** with pg_stat_statements

---

# SECURITY AND COMPLIANCE

## Row-Level Security (RLS)

Implement RLS policies to enforce multi-tenancy:

```sql
-- Enable RLS on all business-related tables
ALTER TABLE Sales ENABLE ROW LEVEL SECURITY;

-- Create policy to restrict access to business data
CREATE POLICY sales_business_isolation ON Sales
  FOR ALL TO authenticated
  USING (business_id IN (
    SELECT business_id FROM BusinessUsers 
    WHERE user_id = auth.uid() AND status = 'active'
  ));
```

## RBAC Implementation

The UserRoles and BusinessUsers tables implement a comprehensive RBAC system:

- **Hierarchical Permissions**: Roles have hierarchy levels for inheritance
- **Business-Specific Roles**: Users can have different roles in different businesses
- **Custom Permissions**: Override default role permissions per user
- **Branch-Level Access**: Restrict users to specific branches

## Audit Trail Requirements

The AuditLog table captures:
- **All data changes** with before/after values
- **User actions** with context and metadata
- **Security events** like failed login attempts
- **Compliance data** for regulatory requirements

---

# MIGRATION SUMMARY

## Key Changes from Original Schema

### 1. **Normalized Transaction Tables**
- **Sales.items JSON → SalesLineItems table**: Proper normalization for line items
- **Purchases.items JSON → PurchaseLineItems table**: Structured purchase details
- **Benefits**: Better reporting, referential integrity, query performance

### 2. **Enhanced Multi-Tenancy**
- **Added business_id to all relevant tables**: Complete data isolation
- **Row-Level Security policies**: Database-enforced security
- **BusinessUsers junction table**: Flexible user-business relationships

### 3. **RBAC System Implementation**
- **UserRoles table**: Centralized role management
- **Hierarchical permissions**: Role inheritance and custom overrides
- **Branch-level access control**: Granular permission management

### 4. **Enterprise Features**
- **PaymentTransactions table**: Multi-payment method support
- **Returns management**: Complete return workflow
- **PromotionCampaigns**: Advanced marketing capabilities
- **InventoryLocations**: Multi-location inventory tracking

### 5. **Performance Optimizations**
- **Proper indexing strategy**: Optimized for common query patterns
- **Generated columns**: Calculated fields for better performance
- **Partitioning recommendations**: For high-volume tables

### 6. **Audit and Compliance**
- **Comprehensive audit trail**: System-wide activity tracking
- **Data integrity constraints**: Business rules enforcement
- **Security enhancements**: Enterprise-grade security measures

## Migration Considerations

1. **Data Migration Required**: JSON fields need to be normalized to separate tables
2. **API Updates Needed**: Endpoints must handle new normalized structure
3. **Security Implementation**: RLS policies and RBAC system setup
4. **Performance Testing**: Validate query performance with new indexes
5. **Training Required**: Team must understand new schema structure

This enhanced schema provides enterprise-grade functionality while maintaining the flexibility and performance required for a modern POS system. The normalized structure enables better reporting, ensures data integrity, and supports advanced features like multi-location inventory, comprehensive returns management, and sophisticated promotional campaigns.