# Clean Infrastructure Setup

This Flutter project now has a clean, minimal infrastructure setup with:

## Database (Drift/SQLite)
- **Location**: `/lib/core/database/`
- **Main File**: `database.dart` - Empty database ready for your tables
- **Helper**: `database_helper.dart` - Database instance management
- **Initializer**: `database_initializer.dart` - App-level initialization

### To Add Tables:
1. Define your table classes in `database.dart`
2. Add them to the `@DriftDatabase(tables: <Type>[YourTable])` annotation
3. Run `dart run build_runner build` to generate code

## API Client
- **Location**: `/lib/core/resources/`
- **Main File**: `api_client.dart` - Full-featured HTTP client with:
  - GET, POST, PUT, PATCH, DELETE methods
  - Request/Response interceptors
  - Error handling
  - Token management support
  - Connectivity checking

### Supporting Files:
- `base_api_service.dart` - Base service class for API services
- `data_state.dart` - Data state wrapper for API responses
- `auth_interceptor.dart` - Authentication and rate limiting interceptors

## Configuration
- **API Config**: `/lib/core/config/api_config.dart`
- **Environment Files**: `.env`, `.env.staging`, `.env.production`
- **Token Manager**: `/lib/core/utils/token_manager.dart`

## Usage

### Database:
```dart
// After adding tables and generating code:
final db = GetIt.instance<AppDatabase>();
```

### API Client:
```dart
final apiClient = ApiClient();
final response = await apiClient.get<YourModel>(
  '/endpoint',
  fromJson: (json) => YourModel.fromJson(json),
);
```

## Next Steps
1. Define your database tables
2. Create your API service classes extending BaseApiService
3. Implement your business logic
4. Run `dart run build_runner build` to generate database code