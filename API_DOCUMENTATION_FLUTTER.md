# MTEFA Backend API Documentation for Flutter Developers

## 📱 Overview

This documentation is specifically designed for Flutter developers integrating with the MTEFA Backend API. It includes all endpoints, request/response formats, authentication flows, and Flutter-specific code examples.

**Base URL:** `http://localhost:3000/api` (Development)
**API Version:** 1.0.0

## 🔐 Authentication Overview

The API uses JWT-based authentication with the following flow:

1. **Sign Up/Sign In** → Get access & refresh tokens
2. **Include Bearer token** in all authenticated requests
3. **Refresh tokens** when they expire
4. **Handle rate limiting** and security responses

### Flutter HTTP Client Setup

```dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:3000/api';
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    // Add auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        options.headers['Content-Type'] = 'application/json';
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, try to refresh
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry the original request
            return handler.resolve(await _dio.fetch(error.requestOptions));
          }
        }
        handler.next(error);
      },
    ));
  }
}
```

---

## 🔑 Authentication Endpoints

### 1. User Registration

**Endpoint:** `POST /auth/signup`
**Rate Limit:** 3 requests per hour per IP
**Access:** Public

#### Request Body:

```json
{
  "email": "user@example.com",
  "password": "SecurePass123!",
  "confirmPassword": "SecurePass123!",
  "fullName": "John Doe"
}
```

#### Flutter Implementation:

```dart
class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
  }) async {
    try {
      final response = await _apiClient._dio.post('/auth/signup', data: {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'fullName': fullName,
      });

      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
}
```

#### Success Response (201):

```json
{
  "success": true,
  "data": {
    "user": {
      "id": "123e4567-e89b-12d3-a456-426614174000",
      "email": "user@example.com",
      "fullName": "John Doe",
      "role": "USER",
      "status": "ACTIVE",
      "emailVerified": false
    },
    "tokens": {
      "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "expiresIn": 3600,
      "tokenType": "Bearer"
    }
  },
  "timestamp": "2024-01-15T10:30:00.000Z",
  "correlationId": "req-123-abc-456"
}
```

### 2. User Sign In

**Endpoint:** `POST /auth/signin`
**Rate Limit:** 10 requests per 15 minutes per IP
**Access:** Public
**Security:** Brute force protection (5 failed attempts = 30 min lockout)

#### Request Body:

```json
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}
```

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> signIn({
  required String email,
  required String password,
}) async {
  try {
    final response = await _apiClient._dio.post('/auth/signin', data: {
      'email': email,
      'password': password,
    });

    // Store tokens securely
    final tokens = response.data['data']['tokens'];
    await _storage.write(key: 'access_token', value: tokens['accessToken']);
    await _storage.write(key: 'refresh_token', value: tokens['refreshToken']);

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

### 3. Token Refresh

**Endpoint:** `POST /auth/refresh`
**Rate Limit:** 50 requests per 15 minutes per IP
**Access:** Public (with refresh token)

#### Request Body:

```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Flutter Implementation:

```dart
Future<bool> _refreshToken() async {
  try {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) return false;

    final response = await _dio.post('/auth/refresh', data: {
      'refreshToken': refreshToken,
    });

    final tokens = response.data['data']['tokens'];
    await _storage.write(key: 'access_token', value: tokens['accessToken']);
    await _storage.write(key: 'refresh_token', value: tokens['refreshToken']);

    return true;
  } catch (e) {
    // Clear invalid tokens
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    return false;
  }
}
```

### 4. Get Current User

**Endpoint:** `GET /auth/user`
**Rate Limit:** 50 requests per 15 minutes per IP
**Access:** Authenticated users only

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> getCurrentUser() async {
  try {
    final response = await _apiClient._dio.get('/auth/user');
    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

### 5. Password Reset

**Endpoint:** `POST /auth/reset-password`
**Rate Limit:** 5 requests per hour per IP
**Access:** Public

#### Request Body:

```json
{
  "email": "user@example.com"
}
```

### 6. Update Password

**Endpoint:** `PATCH /auth/update-password`
**Rate Limit:** 50 requests per 15 minutes per IP
**Access:** Authenticated users only

#### Request Body:

```json
{
  "currentPassword": "OldPass123!",
  "newPassword": "NewPass456!",
  "confirmPassword": "NewPass456!"
}
```

---

## 🏢 Business Management Endpoints

### 1. Create Business

**Endpoint:** `POST /businesses`
**Rate Limit:** 10 requests per hour per IP
**Access:** Business Owners & Super Admins
**Security:** CSRF Protection, Input validation

#### Request Body:

```json
{
  "name": "My Restaurant",
  "logo": "https://example.com/logo.png",
  "description": "Fine dining experience",
  "industry": "restaurant",
  "settings": {
    "currency": "PKR", // default
    "tax_rate": 8.5,
    "timezone": "America/New_York",
    "business_hours": {
      "monday": { "open": "09:00", "close": "18:00", "closed": false },
      "tuesday": { "open": "09:00", "close": "18:00", "closed": false },
      "wednesday": { "open": "09:00", "close": "18:00", "closed": false },
      "thursday": { "open": "09:00", "close": "18:00", "closed": false },
      "friday": { "open": "09:00", "close": "18:00", "closed": false },
      "saturday": { "open": "10:00", "close": "16:00", "closed": false },
      "sunday": { "open": "10:00", "close": "16:00", "closed": true }
    }
  }
}
```

#### Flutter Implementation:

```dart
class BusinessService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> createBusiness({
    required String name,
    String? logo,
    String? description,
    required String industry,
    Map<String, dynamic>? settings,
  }) async {
    try {
      final response = await _apiClient._dio.post('/businesses', data: {
        'name': name,
        'logo': logo,
        'description': description,
        'industry': industry,
        'settings': settings ?? {},
      });

      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
}
```

#### Success Response (201):

```json
{
  "success": true,
  "data": {
    "business": {
      "business_id": "123e4567-e89b-12d3-a456-426614174000",
      "bku_id": "BKU001234",
      "name": "My Restaurant",
      "logo": "https://example.com/logo.png",
      "description": "Fine dining experience",
      "industry": "restaurant",
      "status": "ACTIVE",
      "verification_status": "PENDING",
      "settings": {
        "currency": "PKR", // default
        "tax_rate": 8.5,
        "timezone": "America/New_York"
      },
      "created_at": "2024-01-15T10:30:00.000Z",
      "updated_at": "2024-01-15T10:30:00.000Z"
    },
    "membership": {
      "role": "BUSINESS_OWNER",
      "permissions": ["business:read", "business:write", "business:delete"],
      "joined_at": "2024-01-15T10:30:00.000Z"
    }
  },
  "timestamp": "2024-01-15T10:30:00.000Z",
  "correlationId": "req-123-abc-456"
}
```

### 2. Get Business by ID

**Endpoint:** `GET /businesses/{businessId}`
**Rate Limit:** 50 requests per 15 minutes per IP
**Access:** Business members (VIEWER role or higher)

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> getBusinessById(String businessId) async {
  try {
    final response = await _apiClient._dio.get('/businesses/$businessId');
    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

### 3. Update Business

**Endpoint:** `PATCH /businesses/{businessId}`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Business Admin/Owner
**Security:** Audit logging, Input validation

#### Request Body:

```json
{
  "name": "Updated Restaurant Name",
  "description": "Updated description",
  "settings": {
    "tax_rate": 9.0
  }
}
```

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> updateBusiness(
  String businessId,
  Map<String, dynamic> updates,
) async {
  try {
    final response = await _apiClient._dio.patch('/businesses/$businessId', data: updates);
    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

<!-- ### 4. Search Businesses

**Endpoint:** `GET /businesses/search`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Authenticated users

#### Query Parameters:

- `q` (string): Search term for name/description
- `industry` (string): Filter by industry type
- `status` (string): Filter by business status
- `verified` (boolean): Filter verified businesses only
- `rating` (number): Minimum rating filter
- `location` (string): Lat,lng for location-based search
- `radius` (number): Search radius in kilometers
- `sortBy` (string): Sort field (name, rating, created_at)
- `sortOrder` (string): asc or desc
- `page` (number): Page number (default: 1)
- `limit` (number): Results per page (default: 10, max: 50) -->

<!-- #### Flutter Implementation:

```dart
Future<Map<String, dynamic>> searchBusinesses({
  String? query,
  String? industry,
  String? status,
  bool? verified,
  double? rating,
  String? location,
  double? radius,
  String? sortBy,
  String? sortOrder,
  int page = 1,
  int limit = 10,
}) async {
  try {
    final queryParams = <String, dynamic>{};
    if (query != null) queryParams['q'] = query;
    if (industry != null) queryParams['industry'] = industry;
    if (status != null) queryParams['status'] = status;
    if (verified != null) queryParams['verified'] = verified;
    if (rating != null) queryParams['rating'] = rating;
    if (location != null) queryParams['location'] = location;
    if (radius != null) queryParams['radius'] = radius;
    if (sortBy != null) queryParams['sortBy'] = sortBy;
    if (sortOrder != null) queryParams['sortOrder'] = sortOrder;
    queryParams['page'] = page;
    queryParams['limit'] = limit;

    final response = await _apiClient._dio.get('/businesses/search', queryParameters: queryParams);
    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
``` -->

### 5. Business Analytics

**Endpoint:** `GET /businesses/{businessId}/analytics`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Business Admin/Owner

#### Query Parameters:

- `period` (string): Time period (7d, 30d, 90d, 1y)
- `metrics` (string): Comma-separated metrics (sales, revenue, customers)
- `granularity` (string): Data granularity (hourly, daily, weekly, monthly)

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> getBusinessAnalytics(
  String businessId, {
  String period = '30d',
  List<String>? metrics,
  String granularity = 'daily',
}) async {
  try {
    final queryParams = {
      'period': period,
      'granularity': granularity,
    };
    if (metrics != null && metrics.isNotEmpty) {
      queryParams['metrics'] = metrics.join(',');
    }

    final response = await _apiClient._dio.get(
      '/businesses/$businessId/analytics',
      queryParameters: queryParams,
    );
    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

---

## 👥 User Management Endpoints

### 1. Get All Users (Admin Only)

**Endpoint:** `GET /users`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Super Admin only

### 2. Get User by ID

**Endpoint:** `GET /users/{userId}`
**Rate Limit:** 50 requests per 15 minutes per IP
**Access:** Self or Admin

### 3. Update User Profile

**Endpoint:** `PATCH /users/{userId}`
**Rate Limit:** 50 requests per 15 minutes per IP
**Access:** Self or Admin

#### Request Body:

```json
{
  "fullName": "Updated Name",
  "profilePicture": "https://example.com/avatar.png"
}
```

---

## 🔧 Industry Types

Valid industry values for business creation:

- `garments`
- `retail`
- `restaurant`
- `healthcare`
- `technology`
- `automotive`
- `beauty_wellness`
- `education`
- `professional_services`
- `other`

## 💱 Supported Currencies

Over 57 currencies supported including:

- `PKR`, `USD`, `EUR`, `GBP`, `JPY`, `CAD`, `AUD`, `CHF`, `CNY`, `INR`, `BRL`

---

## ❌ Error Handling

### Standard Error Response Format:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "statusCode": 400,
    "timestamp": "2024-01-15T10:30:00.000Z",
    "correlationId": "req-123-abc-456",
    "details": {
      "field": "email",
      "message": "Email is required",
      "value": ""
    }
  }
}
```

### Flutter Error Handling:

```dart
Map<String, dynamic> _handleError(DioException e) {
  if (e.response != null) {
    final errorData = e.response!.data;
    return {
      'success': false,
      'error': errorData['error'],
      'statusCode': e.response!.statusCode,
    };
  } else {
    return {
      'success': false,
      'error': {
        'code': 'NETWORK_ERROR',
        'message': 'Network connection failed',
        'statusCode': 0,
      },
    };
  }
}
```

### Common HTTP Status Codes:

- **200**: Success
- **201**: Created successfully
- **400**: Bad Request (validation error)
- **401**: Unauthorized (invalid/expired token)
- **403**: Forbidden (insufficient permissions)
- **404**: Not Found
- **423**: Locked (brute force protection active)
- **429**: Too Many Requests (rate limit exceeded)
- **500**: Internal Server Error

### Rate Limiting Response:

```json
{
  "success": false,
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests from this IP, please try again later",
    "statusCode": 429,
    "retryAfter": 900
  }
}
```

---

## 🛡️ Security Headers

All requests should include these security considerations:

### Required Headers:

```dart
final headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $accessToken', // For authenticated endpoints
  'User-Agent': 'Flutter Mobile App v1.0.0',
};
```

### CSRF Protection:

For state-changing operations (POST, PATCH, DELETE), the API may require CSRF tokens. Handle CSRF responses:

```dart
// If you receive a 403 with CSRF token requirement
if (error.response?.statusCode == 403 &&
    error.response?.data['error']['code'] == 'CSRF_TOKEN_REQUIRED') {
  // Request CSRF token and retry
  final csrfToken = await _getCsrfToken();
  // Add to headers and retry request
}
```

---

## 📱 Flutter Complete Example

Here's a complete Flutter service class example:

```dart
class MtefaApiService {
  final ApiClient _apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Authentication methods
  Future<ApiResponse<User>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
  }) async {
    final response = await _apiClient.post('/auth/signup', data: {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'fullName': fullName,
    });

    if (response.success) {
      final userData = response.data['data'];
      await _storeTokens(userData['tokens']);
      return ApiResponse.success(User.fromJson(userData['user']));
    }
    return ApiResponse.error(response.error!);
  }

  // Business methods
  Future<ApiResponse<List<Business>>> searchBusinesses({
    String? query,
    String? industry,
    int page = 1,
    int limit = 10,
  }) async {
    final response = await _apiClient.get('/businesses/search', queryParams: {
      if (query != null) 'q': query,
      if (industry != null) 'industry': industry,
      'page': page,
      'limit': limit,
    });

    if (response.success) {
      final businesses = (response.data['data']['businesses'] as List)
          .map((b) => Business.fromJson(b))
          .toList();
      return ApiResponse.success(businesses);
    }
    return ApiResponse.error(response.error!);
  }

  Future<void> _storeTokens(Map<String, dynamic> tokens) async {
    await _storage.write(key: 'access_token', value: tokens['accessToken']);
    await _storage.write(key: 'refresh_token', value: tokens['refreshToken']);
  }
}

class ApiResponse<T> {
  final bool success;
  final T? data;
  final ApiError? error;

  ApiResponse.success(this.data) : success = true, error = null;
  ApiResponse.error(this.error) : success = false, data = null;
}

class ApiError {
  final String code;
  final String message;
  final int statusCode;
  final Map<String, dynamic>? details;

  ApiError({
    required this.code,
    required this.message,
    required this.statusCode,
    this.details,
  });
}
```

---

## 📦 Inventory Management Endpoints

### Overview

The inventory system follows a hierarchical structure:

- **InventoryLine** → Product/Item with SKU
- **Category** → Classification belonging to an InventoryLine
- **Subcategory** → Sub-classification belonging to a Category

### 1. Get Inventory Lines

**Endpoint:** `GET /inventory-lines`
**Rate Limit:** 1000 requests per 15 minutes per IP
**Access:** Authenticated users

#### Query Parameters:

- `page` (number): Page number (default: 1)
- `limit` (number): Results per page (default: 10, max: 100)
- `search` (string): Search by SKU, name, or description
- `status` (string): Filter by status (active, inactive, discontinued)
- `category` (string): Filter by category
- `lowStock` (boolean): Filter items with low stock

#### Flutter Implementation:

```dart
class InventoryService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getInventoryLines({
    int page = 1,
    int limit = 10,
    String? search,
    String? status,
    String? category,
    bool? lowStock,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (search != null) queryParams['search'] = search;
      if (status != null) queryParams['status'] = status;
      if (category != null) queryParams['category'] = category;
      if (lowStock != null) queryParams['lowStock'] = lowStock;

      final response = await _apiClient._dio.get('/inventory-lines', queryParameters: queryParams);
      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
}
```

### 2. Get Categories for Inventory Line

**Endpoint:** `GET /inventory-lines/{inventoryLineId}/categories`
**Rate Limit:** 1000 requests per 15 minutes per IP
**Access:** Authenticated users

#### Query Parameters:

- `includeSubcategories` (boolean): Include subcategories in response
- `status` (string): Filter by category status

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> getCategoriesForInventoryLine(
  String inventoryLineId, {
  bool includeSubcategories = false,
  String? status,
}) async {
  try {
    final queryParams = <String, dynamic>{
      'includeSubcategories': includeSubcategories,
    };
    if (status != null) queryParams['status'] = status;

    final response = await _apiClient._dio.get(
      '/inventory-lines/$inventoryLineId/categories',
      queryParameters: queryParams,
    );

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

#### Success Response:

```json
{
  "success": true,
  "data": {
    "categories": [
      {
        "id": "550e8400-e29b-41d4-a716-446655440000",
        "name": "Electronics",
        "description": "Electronic items and components",
        "slug": "electronics",
        "status": "active",
        "inventoryLineId": "550e8400-e29b-41d4-a716-446655440001",
        "subcategories": [
          {
            "id": "550e8400-e29b-41d4-a716-446655440002",
            "name": "Smartphones",
            "description": "Mobile phones and accessories",
            "slug": "smartphones",
            "status": "active"
          }
        ],
        "createdAt": "2024-01-01T10:00:00.000Z",
        "updatedAt": "2024-01-01T10:00:00.000Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 1,
      "totalItems": 1,
      "hasNext": false,
      "hasPrev": false
    }
  }
}
```

### 3. Create Category for Inventory Line

**Endpoint:** `POST /inventory-lines/{inventoryLineId}/categories`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Authenticated users

#### Request Body:

```json
{
  "name": "Electronics",
  "description": "Electronic items and components",
  "status": "active",
  "metadata": {
    "priority": "high",
    "tags": ["tech", "gadgets"]
  }
}
```

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> createCategoryForInventoryLine(
  String inventoryLineId,
  Map<String, dynamic> categoryData,
) async {
  try {
    final response = await _apiClient._dio.post(
      '/inventory-lines/$inventoryLineId/categories',
      data: categoryData,
    );

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

### 4. Get Category Hierarchy

**Endpoint:** `GET /inventory-lines/{inventoryLineId}/categories/hierarchy`
**Rate Limit:** 1000 requests per 15 minutes per IP
**Access:** Authenticated users

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> getCategoryHierarchy(String inventoryLineId) async {
  try {
    final response = await _apiClient._dio.get('/inventory-lines/$inventoryLineId/categories/hierarchy');

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

#### Success Response:

```json
{
  "success": true,
  "data": {
    "inventoryLine": {
      "id": "550e8400-e29b-41d4-a716-446655440001",
      "sku": "PROD-001",
      "name": "Premium Smartphone",
      "description": "High-end smartphone with advanced features"
    },
    "hierarchy": [
      {
        "id": "550e8400-e29b-41d4-a716-446655440000",
        "name": "Electronics",
        "description": "Electronic items and components",
        "subcategories": [
          {
            "id": "550e8400-e29b-41d4-a716-446655440002",
            "name": "Smartphones",
            "description": "Mobile phones and accessories"
          },
          {
            "id": "550e8400-e29b-41d4-a716-446655440003",
            "name": "Accessories",
            "description": "Phone cases, chargers, etc."
          }
        ]
      }
    ]
  }
}
```

### 5. Bulk Create Categories

**Endpoint:** `POST /inventory-lines/{inventoryLineId}/categories/bulk`
**Rate Limit:** 50 requests per 15 minutes per IP
**Access:** Authenticated users

#### Request Body:

```json
{
  "categories": [
    {
      "name": "Electronics",
      "description": "Electronic items",
      "status": "active"
    },
    {
      "name": "Accessories",
      "description": "Phone accessories",
      "status": "active"
    }
  ]
}
```

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> bulkCreateCategories(
  String inventoryLineId,
  List<Map<String, dynamic>> categories,
) async {
  try {
    final response = await _apiClient._dio.post(
      '/inventory-lines/$inventoryLineId/categories/bulk',
      data: {'categories': categories},
    );

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

## 🏷️ Category Management Endpoints

### 1. Update Category

**Endpoint:** `PUT /categories/{categoryId}`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Authenticated users

#### Request Body:

```json
{
  "name": "Updated Electronics",
  "description": "Updated description",
  "status": "active",
  "metadata": {
    "priority": "medium"
  }
}
```

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> updateCategory(
  String categoryId,
  Map<String, dynamic> updates,
) async {
  try {
    final response = await _apiClient._dio.put('/categories/$categoryId', data: updates);

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

### 2. Delete Category

**Endpoint:** `DELETE /categories/{categoryId}`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Authenticated users

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> deleteCategory(String categoryId) async {
  try {
    final response = await _apiClient._dio.delete('/categories/$categoryId');

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

## 🔖 Subcategory Management Endpoints

### 1. Get Subcategories by Category

**Endpoint:** `GET /subcategories/category/{categoryId}`
**Rate Limit:** 1000 requests per 15 minutes per IP
**Access:** Authenticated users

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> getSubcategoriesByCategory(String categoryId) async {
  try {
    final response = await _apiClient._dio.get('/subcategories/category/$categoryId');

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

### 2. Create Subcategory

**Endpoint:** `POST /subcategories`
**Rate Limit:** 100 requests per 15 minutes per IP
**Access:** Authenticated users

#### Request Body:

```json
{
  "name": "Smartphones",
  "description": "Mobile phones and accessories",
  "categoryId": "550e8400-e29b-41d4-a716-446655440000",
  "status": "active"
}
```

## Enhanced Cashier Sessions Management

### Get All Sessions (Enhanced)

**GET** `/`

Retrieve cashier sessions with advanced filtering and business isolation.

**Query Parameters:**

```
?businessId=uuid&branchId=uuid&registerId=uuid&status=active&startDate=2024-01-01&endDate=2024-12-31&page=1&limit=20
```

**Response:**

```dart
{
  "success": true,
  "data": {
    "sessions": [
      {
        "sessionId": "uuid",
        "sessionNumber": "CS-2024-001-001",
        "registerId": "uuid",
        "registerName": "Counter 1",
        "cashierId": "uuid",
        "cashierName": "John Doe",
        "loginTime": "2024-12-31T09:00:00Z",
        "logoutTime": null,
        "status": "active",
        "openingCash": 500.00,
        "currentCash": 650.00,
        "totalSales": 150.00,
        "totalTransactions": 8,
        "businessContext": {
          "businessId": "uuid",
          "branchId": "uuid",
          "businessName": "My Store"
        }
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 45,
      "hasMore": true
    },
    "analytics": {
      "activeSessions": 3,
      "totalCashInDrawers": 1850.00,
      "averageSessionDuration": "6.5 hours"
    }
  },
  "meta": {
    "timestamp": "2024-12-31T10:00:00Z",
    "correlationId": "req_123"
  }
}
```

### Start Cashier Session (Enhanced)

**POST** `/start`

Start a new cashier session with comprehensive validation and business context.

**Required Permission:** `cashier:create`  
**Minimum Role:** CASHIER

**Request Body:**

```dart
{
  "businessId": "uuid", // required - business context
  "branchId": "uuid", // required - branch context
  "registerId": "uuid", // required - cash register
  "openingCashAmount": 500.00, // required
  "expectedLogoutTime": "2024-12-31T18:00:00Z", // optional
  "notes": "Morning shift start", // optional
  "denominations": { // optional but recommended
    "bills": {
      "100": {"count": 5, "total": 500.00},
      "50": {"count": 2, "total": 100.00},
      "20": {"count": 5, "total": 100.00}
    },
    "coins": {
      "1": {"count": 25, "total": 25.00},
      "0.25": {"count": 40, "total": 10.00}
    }
  },
  "metadata": {
    "deviceInfo": {
      "type": "tablet",
      "model": "iPad Pro",
      "os": "iOS 17.0"
    },
    "shiftType": "morning"
  }
}
```

**Response:**

```dart
{
  "success": true,
  "data": {
    "sessionId": "uuid",
    "sessionNumber": "CS-2024-001-001", // Auto-generated unique number
    "registerId": "uuid",
    "registerName": "Counter 1",
    "cashierId": "uuid",
    "loginTime": "2024-12-31T09:00:00Z",
    "openingCashAmount": 500.00,
    "status": "active",
    "businessContext": {
      "businessId": "uuid",
      "businessName": "My Store",
      "branchId": "uuid",
      "branchName": "Main Branch"
    },
    "permissions": ["cashier:read", "cashier:update", "sales:create"],
    "security": {
      "sessionToken": "secure-session-token",
      "lastActivity": "2024-12-31T09:00:00Z",
      "ipAddress": "192.168.1.100"
    }
  },
  "meta": {
    "timestamp": "2024-12-31T09:00:00Z",
    "correlationId": "req_123"
  }
}
```

### End Cashier Session (Enhanced)

**POST** `/:sessionId/end`

End current session with comprehensive cash reconciliation and validation.

**Required Permission:** `cashier:update`  
**Minimum Role:** CASHIER (own session) / BRANCH_MANAGER (any session)

**Request Body:**

```dart
{
  "closingCashAmount": 750.00, // required
  "notes": "End of evening shift", // optional
  "denominations": { // recommended for accurate reconciliation
    "bills": {
      "100": {"count": 7, "total": 700.00},
      "50": {"count": 1, "total": 50.00},
      "20": {"count": 0, "total": 0.00}
    },
    "coins": {
      "1": {"count": 0, "total": 0.00},
      "0.25": {"count": 0, "total": 0.00}
    }
  },
  "reconciliationData": {
    "cardTips": 25.00,
    "voids": 0.00,
    "overages": 0.00,
    "shortages": 0.00
  },
  "deviceInfo": {
    "logoutMethod": "normal", // normal, force, timeout
    "batteryLevel": 85
  }
}
```

**Response:**

```dart
{
  "success": true,
  "data": {
    "sessionId": "uuid",
    "sessionNumber": "CS-2024-001-001",
    "logoutTime": "2024-12-31T18:00:00Z",
    "duration": "9 hours 15 minutes",
    "cashReconciliation": {
      "openingCash": 500.00,
      "closingCash": 750.00,
      "expectedCash": 745.00, // calculated from transactions
      "difference": 5.00,
      "reconciliationStatus": "over", // balanced, over, short
      "variancePercentage": 0.67
    },
    "salesSummary": {
      "totalSales": 2890.50,
      "totalTransactions": 127,
      "averageTransaction": 22.76,
      "cashSales": 245.00,
      "cardSales": 2645.50
    },
    "sessionMetrics": {
      "transactionsPerHour": 14.1,
      "peakHour": "14:00-15:00",
      "downtimeMinutes": 45,
      "efficiency": 92.5
    },
    "auditInfo": {
      "voids": 2,
      "refunds": 1,
      "priceOverrides": 0,
      "discountsGiven": 5
    }
  },
  "meta": {
    "timestamp": "2024-12-31T18:00:00Z",
    "correlationId": "req_456"
  }
}
```

### Get Active Session (Enhanced)

**GET** `/active`

Get current active session for logged-in cashier with real-time data.

**Required Permission:** `cashier:read`  
**Minimum Role:** CASHIER

**Response:**

```dart
{
  "success": true,
  "data": {
    "sessionId": "uuid",
    "sessionNumber": "CS-2024-001-001",
    "registerId": "uuid",
    "registerName": "Counter 1",
    "loginTime": "2024-12-31T09:00:00Z",
    "currentCashAmount": 650.00,
    "openingCashAmount": 500.00,
    "sessionStatus": "active",
    "realTimeData": {
      "totalSales": 150.00,
      "totalTransactions": 8,
      "lastTransactionTime": "2024-12-31T15:45:00Z",
      "averageTransactionValue": 18.75,
      "hourlyTransactionCount": [2, 1, 3, 2] // last 4 hours
    },
    "businessContext": {
      "businessId": "uuid",
      "businessName": "My Store",
      "branchId": "uuid",
      "branchName": "Main Branch"
    },
    "cashBreakdown": {
      "cashSales": 85.00,
      "cardSales": 65.00,
      "mobilePayments": 0.00,
      "currentCashInDrawer": 585.00
    },
    "permissions": ["cashier:read", "cashier:update", "sales:create"],
    "security": {
      "lastActivity": "2024-12-31T15:45:00Z",
      "sessionExpiry": "2024-12-31T21:00:00Z",
      "inactivityWarning": false
    }
  },
  "meta": {
    "timestamp": "2024-12-31T15:50:00Z",
    "correlationId": "req_789"
  }
}
```

### Get Session Analytics (New)

**GET** `/:sessionId/analytics`

Get comprehensive analytics for a specific session.

**Required Permission:** `reports:read`  
**Minimum Role:** BRANCH_MANAGER

**Response:**

```dart
{
  "success": true,
  "data": {
    "sessionOverview": {
      "sessionId": "uuid",
      "duration": "8 hours 30 minutes",
      "totalSales": 2890.50,
      "totalTransactions": 127,
      "averageTransaction": 22.76
    },
    "timeAnalysis": {
      "hourlyBreakdown": [
        {"hour": "09:00", "transactions": 8, "sales": 180.50},
        {"hour": "10:00", "transactions": 12, "sales": 275.25},
        // ... more hours
      ],
      "peakHour": "14:00-15:00",
      "slowestHour": "11:00-12:00",
      "transactionTrends": "increasing"
    },
    "paymentAnalysis": {
      "cash": {"count": 45, "amount": 890.25, "percentage": 30.8},
      "card": {"count": 75, "amount": 1820.50, "percentage": 62.9},
      "mobile": {"count": 7, "amount": 179.75, "percentage": 6.2}
    },
    "performanceMetrics": {
      "transactionsPerHour": 14.9,
      "averageTransactionTime": "3.2 minutes",
      "idleTime": "45 minutes",
      "efficiency": 91.5,
      "customerSatisfactionScore": 4.2
    },
    "inventoryImpact": {
      "itemsSold": 267,
      "topSellingProducts": [
        {"productName": "Coffee", "quantity": 23, "revenue": 115.00},
        {"productName": "Sandwich", "quantity": 18, "revenue": 144.00}
      ],
      "lowStockAlerts": 2
    }
  }
}
```

### Suspend Session

**POST** `/sessions/:session_id/suspend`

Temporarily suspend active session.

**Request Body:**

```dart
{
  "suspension_reason": "Break time" // required
}
```

### Resume Session

**POST** `/sessions/:session_id/resume`

Resume a suspended session.

**Response:**

```dart
{
  "success": true,
  "data": {
    "session_id": "session_123",
    "session_status": "active",
    "resumed_at": "2024-12-31T14:30:00Z"
  }
}
```

### Get Session History

**GET** `/sessions/history`

Get historical sessions with filtering options.

**Query Parameters:**

```
?start_date=2024-12-01&end_date=2024-12-31&limit=50&offset=0
```

**Response:**

```dart
{
  "success": true,
  "data": {
    "sessions": [
      {
        "session_id": "session_123",
        "session_number": "S001-20241231",
        "login_time": "2024-12-31T09:00:00Z",
        "logout_time": "2024-12-31T18:00:00Z",
        "opening_cash_amount": 500.00,
        "closing_cash_amount": 750.00,
        "reconciliation_status": "over",
        "total_sales": 250.00
      }
    ],
    "pagination": {
      "total": 150,
      "limit": 50,
      "offset": 0,
      "has_more": true
    }
  }
}
```

## Cash Movements

### Record Cash Movement

**POST** `/sessions/:session_id/movements`

Record a cash transaction during active session.

**Request Body:**

```dart
{
  "movement_type": "sale", // sale, refund, deposit, withdrawal
  "amount": 25.00,
  "reference_id": "sale_456", // optional
  "reference_type": "sale", // optional
  "description": "Product sale",
  "payment_method": "cash",
  "cash_amount": 25.00 // actual cash portion
}
```

**Response:**

```dart
{
  "success": true,
  "data": {
    "movement_id": "movement_789",
    "running_total": 525.00,
    "transaction_time": "2024-12-31T10:15:00Z"
  }
}
```

### Get Session Movements

**GET** `/sessions/:session_id/movements`

Get all cash movements for a specific session.

**Query Parameters:**

```
?movement_type=sale&start_time=2024-12-31T09:00:00Z
```

**Response:**

```dart
{
  "success": true,
  "data": {
    "movements": [
      {
        "movement_id": "movement_789",
        "movement_type": "sale",
        "amount": 25.00,
        "running_total": 525.00,
        "description": "Product sale",
        "transaction_time": "2024-12-31T10:15:00Z"
      }
    ],
    "summary": {
      "total_sales": 150.00,
      "total_refunds": -10.00,
      "net_cash_flow": 140.00
    }
  }
}
```

## Cash Registers

### Get Available Registers

**GET** `/registers/branch/:branch_id`

Get available cash registers for a specific branch.

**Response:**

```dart
{
  "success": true,
  "data": [
    {
      "register_id": "register_456",
      "register_name": "Counter 1",
      "register_code": "C001",
      "register_location": "Front desk",
      "is_active": true,
      "is_occupied": false
    }
  ]
}
```

### Get Register Details

**GET** `/registers/:register_id`

Get specific cash register details.

**Response:**

```dart
{
  "success": true,
  "data": {
    "register_id": "register_456",
    "register_name": "Counter 1",
    "register_code": "C001",
    "register_location": "Front desk",
    "is_active": true,
    "current_session": null, // or session object if occupied
    "device_info": {
      "type": "tablet",
      "model": "iPad Pro"
    }
  }
}
```

## Float Requests

### Create Float Request

**POST** `/float/request`

Request cash float adjustment between registers.

**Request Body:**

```dart
{
  "to_register_id": "register_456",
  "from_register_id": "register_789", // optional for central float
  "request_type": "increase", // increase, decrease, transfer
  "amount": 200.00,
  "reason": "Need more change for busy period"
}
```

**Response:**

```dart
{
  "success": true,
  "data": {
    "float_request_id": "float_123",
    "request_status": "pending",
    "request_time": "2024-12-31T11:30:00Z"
  }
}
```

### Get Pending Float Requests

**GET** `/float/pending`

Get pending float adjustment requests.

**Response:**

```dart
{
  "success": true,
  "data": [
    {
      "float_request_id": "float_123",
      "to_register_name": "Counter 1",
      "from_register_name": "Counter 2",
      "amount": 200.00,
      "reason": "Need more change",
      "request_time": "2024-12-31T11:30:00Z",
      "requested_by_name": "John Doe"
    }
  ]
}
```

### Approve Float Request

**PATCH** `/float/:float_request_id/approve`

Approve and process float request (manager only).

**Response:**

```dart
{
  "success": true,
  "data": {
    "float_request_id": "float_123",
    "request_status": "approved",
    "approved_by": "manager_456",
    "approval_time": "2024-12-31T11:45:00Z"
  }
}
```

## Session Analytics

### Get Session Summary

**GET** `/sessions/:session_id/summary`

Get comprehensive session summary and analytics.

**Response:**

```dart
{
  "success": true,
  "data": {
    "session_info": {
      "session_id": "session_123",
      "duration_hours": 8.5,
      "session_status": "closed"
    },
    "cash_summary": {
      "opening_cash": 500.00,
      "closing_cash": 750.00,
      "expected_cash": 740.00,
      "difference": 10.00,
      "reconciliation_status": "over"
    },
    "transaction_summary": {
      "total_sales": 250.00,
      "total_refunds": 10.00,
      "total_transactions": 15,
      "average_transaction": 16.67
    },
    "payment_breakdown": {
      "cash": 180.00,
      "card": 60.00,
      "mobile": 10.00
    }
  }
}
```

## Error Responses

All endpoints return consistent error format:

```dart
{
  "success": false,
  "error": {
    "code": "INVALID_REQUEST",
    "message": "Opening cash amount is required",
    "details": {
      "field": "opening_cash_amount"
    }
  },
  "correlation_id": "req_12345"
}
```

## Common Error Codes

- `INVALID_REQUEST` - Validation error
- `SESSION_ALREADY_ACTIVE` - User already has active session
- `REGISTER_OCCUPIED` - Register already in use
- `INSUFFICIENT_PERMISSIONS` - User lacks required permissions
- `SESSION_NOT_FOUND` - Invalid session ID
- `SESSION_ALREADY_CLOSED` - Attempting to modify closed session

#### Flutter Implementation:

```dart
Future<Map<String, dynamic>> createSubcategory(
  Map<String, dynamic> subcategoryData,
) async {
  try {
    final response = await _apiClient._dio.post('/subcategories', data: subcategoryData);

    return {
      'success': true,
      'data': response.data,
    };
  } on DioException catch (e) {
    return _handleError(e);
  }
}
```

### Flutter Models for Type Safety

```dart
class InventoryLine {
  final String id;
  final String sku;
  final String name;
  final String description;
  final String status;
  final int quantity;
  final double unitPrice;
  final List<Category> categories;
  final DateTime createdAt;
  final DateTime updatedAt;

  InventoryLine({
    required this.id,
    required this.sku,
    required this.name,
    required this.description,
    required this.status,
    required this.quantity,
    required this.unitPrice,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InventoryLine.fromJson(Map<String, dynamic> json) {
    return InventoryLine(
      id: json['id'],
      sku: json['sku'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'].toDouble(),
      categories: (json['categories'] as List?)
          ?.map((c) => Category.fromJson(c))
          .toList() ?? [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;
  final String slug;
  final String status;
  final String inventoryLineId;
  final List<Subcategory> subcategories;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.status,
    required this.inventoryLineId,
    required this.subcategories,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      slug: json['slug'],
      status: json['status'],
      inventoryLineId: json['inventoryLineId'],
      subcategories: (json['subcategories'] as List?)
          ?.map((s) => Subcategory.fromJson(s))
          .toList() ?? [],
      metadata: json['metadata'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Subcategory {
  final String id;
  final String name;
  final String description;
  final String slug;
  final String status;
  final String categoryId;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.status,
    required this.categoryId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      slug: json['slug'],
      status: json['status'],
      categoryId: json['categoryId'],
      metadata: json['metadata'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
```

---

## 🔍 Testing Your Integration

### Health Check

Test your connection with the health endpoint:

```dart
Future<bool> testConnection() async {
  try {
    final response = await _dio.get('/health');
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
```

This documentation provides everything needed for Flutter developers to successfully integrate with the MTEFA Backend API. All endpoints include proper error handling, security considerations, and real-world Flutter implementation examples.
