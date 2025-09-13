# API Client Usage Guide

## Overview

This API client implementation provides a robust, scalable foundation for handling HTTP requests in Flutter applications using the `http` package. It follows Clean Architecture principles and includes comprehensive error handling, token management, and interceptor support.

## Key Features

- ✅ Built with `http` package (not dio)
- ✅ Clean Architecture pattern implementation
- ✅ JWT token management with automatic refresh
- ✅ Secure token storage using `flutter_secure_storage`
- ✅ Comprehensive error handling with DataState pattern
- ✅ Network connectivity checking
- ✅ Request/Response interceptors
- ✅ Rate limiting support
- ✅ Timeout handling
- ✅ Logging in debug mode
- ✅ Type-safe API responses

## File Structure

```
lib/core/
├── config/
│   └── api_config.dart          # Environment configuration
├── error/
│   ├── exceptions.dart          # Custom exceptions
│   └── failures.dart            # Failure classes
├── resources/
│   ├── api_client.dart          # Main HTTP client
│   ├── auth_interceptor.dart    # Authentication interceptor
│   ├── base_api_service.dart    # Base service class
│   └── data_state.dart          # DataState pattern
└── utils/
    └── token_manager.dart       # JWT token management

lib/data/sources/remote/
└── auth_api_service.dart       # Authentication service example
```

## Setup

### 1. Environment Configuration

Create `.env` files for different environments:

```env
# .env.development
API_BASE_URL=http://localhost:3000/api
API_VERSION=1.0.0
CONNECT_TIMEOUT=30
RECEIVE_TIMEOUT=30
ENABLE_LOGGING=true
```

### 2. Initialize Configuration

In your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'core/config/api_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize API configuration
  await ApiConfig.initialize(
    environment: const String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'development',
    ),
  );
  
  runApp(MyApp());
}
```

## Usage Examples

### 1. Basic API Call

```dart
import 'core/resources/api_client.dart';
import 'core/resources/data_state.dart';

class MyService {
  final ApiClient _apiClient = ApiClient();
  
  Future<void> fetchData() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/endpoint');
    
    response.when(
      success: (data) {
        print('Success: $data');
      },
      failed: (error, errorCode, statusCode, errorDetails) {
        print('Error: $error');
      },
      loading: () {
        print('Loading...');
      },
    );
  }
}
```

### 2. Authentication Service

```dart
import 'data/sources/remote/auth_api_service.dart';

class AuthExample {
  final AuthApiService _authService = AuthApiService();
  
  Future<void> signIn() async {
    final result = await _authService.signIn(
      email: 'user@example.com',
      password: 'password123',
    );
    
    if (result.isSuccess) {
      print('Login successful');
      // Navigate to home screen
    } else if (result.isFailed) {
      final failed = result as DataFailed;
      print('Login failed: ${failed.error}');
      // Show error message
    }
  }
}
```

### 3. Creating Custom Service

```dart
import 'core/resources/base_api_service.dart';
import 'core/resources/data_state.dart';

class ProductService extends BaseApiService {
  Future<DataState<List<Product>>> getProducts({
    int page = 1,
    int limit = 10,
  }) async {
    return execute(() async {
      final response = await apiClient.get<Map<String, dynamic>>(
        '/products',
        queryParameters: {'page': page, 'limit': limit},
      );
      
      return response.when(
        success: (data) {
          final products = (data['products'] as List)
              .map((json) => Product.fromJson(json))
              .toList();
          return DataSuccess(products);
        },
        failed: (error, errorCode, statusCode, errorDetails) {
          return DataFailed(
            error: error,
            errorCode: errorCode,
            statusCode: statusCode,
            errorDetails: errorDetails,
          );
        },
        loading: () => const DataLoading(),
      );
    });
  }
}
```

### 4. Using with Provider

```dart
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService;
  DataState<List<Product>> _productsState = const DataLoading();
  
  DataState<List<Product>> get productsState => _productsState;
  
  ProductProvider(this._productService);
  
  Future<void> loadProducts() async {
    _productsState = const DataLoading();
    notifyListeners();
    
    _productsState = await _productService.getProducts();
    notifyListeners();
  }
}

// In your widget
class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return provider.productsState.when(
          success: (products) => ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(products[index].name),
            ),
          ),
          failed: (error, _, __, ___) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
```

### 5. Handling Pagination

```dart
class PaginatedService extends BaseApiService {
  Future<DataState<PaginatedResult<Item>>> getItems({
    int page = 1,
    int limit = 20,
  }) async {
    return execute(() async {
      final response = await apiClient.get<Map<String, dynamic>>(
        '/items',
        queryParameters: buildQueryParams(page: page, limit: limit),
      );
      
      return response.when(
        success: (data) {
          final items = (data['items'] as List)
              .map((json) => Item.fromJson(json))
              .toList();
          
          final pagination = parsePagination(data);
          
          return DataSuccess(PaginatedResult(
            items: items,
            pagination: pagination,
          ));
        },
        failed: (error, errorCode, statusCode, errorDetails) {
          return DataFailed(
            error: error,
            errorCode: errorCode,
            statusCode: statusCode,
            errorDetails: errorDetails,
          );
        },
        loading: () => const DataLoading(),
      );
    });
  }
}
```

## Error Handling

### Error Types

1. **NetworkFailure**: No internet connection
2. **ServerFailure**: Server returned an error
3. **AuthenticationFailure**: Authentication failed (401)
4. **ValidationFailure**: Invalid input (400)
5. **RateLimitFailure**: Too many requests (429)
6. **TimeoutFailure**: Request timeout
7. **UnknownFailure**: Unexpected errors

### Error Handling Example

```dart
void handleApiResponse<T>(DataState<T> response) {
  if (response is DataFailed) {
    switch (response.errorCode) {
      case 'NETWORK_ERROR':
        showSnackBar('No internet connection');
        break;
      case 'AUTH_ERROR':
        navigateToLogin();
        break;
      case 'VALIDATION_ERROR':
        showValidationErrors(response.errorDetails);
        break;
      case 'RATE_LIMIT_EXCEEDED':
        showSnackBar('Too many requests. Please try again later.');
        break;
      default:
        showSnackBar(response.error);
    }
  }
}
```

## Token Management

The token manager automatically handles:
- Secure storage of access and refresh tokens
- Token expiry checking
- Automatic token refresh on 401 responses
- Clear tokens on logout

```dart
// Check authentication status
final tokenManager = TokenManager();
final isAuthenticated = await tokenManager.isAuthenticated();

// Manual token refresh
final authService = AuthApiService();
final refreshResult = await authService.refreshToken();

// Clear tokens on logout
await tokenManager.clearTokens();
```

## Custom Interceptors

### Creating a Custom Interceptor

```dart
class CustomHeaderInterceptor implements RequestInterceptor {
  @override
  Future<RequestInterceptorResult> onRequest({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    // Add custom headers
    headers['X-Custom-Header'] = 'CustomValue';
    headers['X-App-Version'] = '1.0.0';
    
    return RequestInterceptorResult(
      headers: headers,
      body: body,
    );
  }
}

// Add to API client
final apiClient = ApiClient();
apiClient.addRequestInterceptor(CustomHeaderInterceptor());
```

## Testing

### Unit Testing Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('AuthApiService', () {
    late AuthApiService authService;
    late MockClient mockClient;
    
    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.path == '/api/auth/signin') {
          return http.Response(
            '{"success": true, "data": {"user": {"id": "123"}, "tokens": {"accessToken": "token123", "refreshToken": "refresh123", "expiresIn": 3600}}}',
            200,
          );
        }
        return http.Response('Not Found', 404);
      });
      
      final apiClient = ApiClient(httpClient: mockClient);
      authService = AuthApiService(apiClient: apiClient);
    });
    
    test('Sign in successfully', () async {
      final result = await authService.signIn(
        email: 'test@example.com',
        password: 'password123',
      );
      
      expect(result.isSuccess, true);
      expect((result as DataSuccess).data.user.id, '123');
    });
  });
}
```

## Best Practices

1. **Always use DataState pattern** for consistent error handling
2. **Extend BaseApiService** for new services to get common functionality
3. **Use type-safe models** with fromJson factories
4. **Handle loading states** in UI appropriately
5. **Implement proper error messages** for user feedback
6. **Use interceptors** for cross-cutting concerns
7. **Test API services** with mock HTTP clients
8. **Configure timeouts** appropriately for your use case
9. **Enable logging** only in debug mode
10. **Secure sensitive data** using flutter_secure_storage

## Troubleshooting

### Common Issues

1. **Token not refreshing**: Check if refresh token is saved properly
2. **Network errors**: Ensure connectivity_plus permissions are set
3. **Timeout errors**: Adjust timeout duration in ApiConfig
4. **CORS errors**: Configure server to allow Flutter app origin
5. **SSL errors**: Use proper certificates in production

### Debug Tips

```dart
// Enable verbose logging
ApiConfig.instance.enableLogging = true;

// Check token status
final token = await TokenManager().getAccessToken();
print('Token: $token');

// Test connectivity
final connectivity = Connectivity();
final result = await connectivity.checkConnectivity();
print('Connection: $result');
```

## Migration from Dio

If migrating from Dio to this HTTP implementation:

1. Replace `Dio()` with `ApiClient()`
2. Replace `dio.get()` with `apiClient.get()`
3. Replace `DioError` with `DataFailed`
4. Replace interceptors with new interceptor classes
5. Update error handling to use DataState pattern

## Summary

This API client provides a production-ready foundation for Flutter apps with:
- Clean Architecture compliance
- Comprehensive error handling
- Automatic token management
- Type safety
- Easy testing
- Scalable design

For questions or issues, refer to the inline documentation in each file.