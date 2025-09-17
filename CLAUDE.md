# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter POS (Point of Sale) system with multi-brand support, stock control, and activity tracking. The application implements a **local-first architecture** using Drift (SQLite) for primary data operations, with Supabase backend for cloud synchronization. Uses flutter_secure_storage for secure data persistence and implements Clean Architecture with responsive design patterns.

**Database Schema**: Complete database structure and entity relationships are documented in `backend.md` - refer to this file for understanding the full data model before implementing new features.

## Development Commands

### Initial Setup

```bash
# Complete setup with dependencies and iOS pods  
flutter clean && flutter pub get && cd macos && pod install && cd ..
```

### Running the Application

```bash
# Development environment (default)
flutter run

# Staging environment
flutter run --dart-define=ENVIRONMENT=staging

# Production environment
flutter run --dart-define=ENVIRONMENT=production
```

### Build Commands

```bash
# Clean and rebuild
flutter clean && flutter pub get

# Build for iOS
flutter build ios

# Build for Android
flutter build apk

# Generate code (for Drift database) - Required after table changes
dart run build_runner build

# Watch mode for continuous code generation during development
dart run build_runner watch
```

### Quality Assurance

```bash
# Run linter
flutter analyze

# Run tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

## Architecture Overview

### Clean Architecture Implementation

- **Domain Layer**: Contains entities, repositories (abstractions), and use cases
- **Data Layer**: Repository implementations, data sources (API, local storage)
- **Presentation Layer**: UI components, providers (state management), screens with responsive views

### Key Architectural Patterns

#### Use Case Pattern

- All business logic flows through use cases that extend `UseCase<T, P>`
- Use cases return `DataState<T>` for consistent error handling
- Located in `lib/domain/usecases/`

#### Repository Pattern

- Abstract repositories in `lib/domain/repositories/`
- Concrete implementations in `lib/data/repositories/`
- Supports both API and local database operations

#### Component-Driven UI Architecture

- **Widget Composition**: Small, focused widgets under 100-150 lines
- **Reusable Components**: Shared components in dedicated folders
- **Example**: Login form broken into `LoginFormHeader`, `LoginFormFields`, `LoginErrorMessage`, etc.
- **Benefits**: Better testability, reusability, and maintainability

#### Responsive Design

- Uses `MyScaffold` widget for responsive layouts
- Breakpoints: Desktop (>1000px), Tablet (600-1000px), Mobile (<600px)
- Each screen has separate view files: `*_desktop_view.dart`, `*_tablet_view.dart`, `*_mobile_view.dart`
- Responsive components adapt to screen size automatically

#### State Management

- Provider pattern with dedicated provider classes
- Providers registered globally in `lib/configs/providers/my_providers.dart`
- State classes follow naming convention: `*Provider`
- Three-tier provider strategy: Global, Route-Specific, Screen-Specific

#### Dependency Injection

- Uses GetIt for service locator pattern
- Configuration in `lib/injection_container.dart`
- Services registered by feature modules (e.g., `_auth()`)
- Database and secure storage registered as singletons

### Data State Management

The app uses a custom `DataState<T>` system for handling async operations:

- `DataSuccess<T>`: Successful operation with data
- `DataFailed<T>`: Failed operation with failure details and error codes
- `DataLoading<T>`: Loading state
- Extensions provide convenient methods: `isSuccess`, `isFailed`, `isLoading`, `when()`, `whenOrNull()`

### Local Database (Drift) - Primary Data Store

- **Local-First Architecture**: SQLite serves as the primary database with immediate data access
- Uses Drift ORM for type-safe SQLite operations
- Database file: `AppDatabase` in `lib/core/database/database.dart`
- Code generation required: `dart run build_runner build`
- Tables defined using Drift annotations in `lib/core/database/tables/`
- Tables registered in `@DriftDatabase` decorator
- Current tables: `Users` (for local testing/signup)
- Complete schema available in `backend.md` - implement additional tables as needed
- Migrations handled through `MigrationStrategy`

### Cloud Synchronization Strategy

- **Action Tracking**: Local actions are tracked and queued for cloud sync
- **Conflict Resolution**: Local data takes precedence, with merge strategies for conflicts  
- **Background Sync**: Automatic synchronization when network is available
- **Offline-First**: Full functionality available without internet connection
- **Supabase Integration**: Backend documented in `backend.md` for reference

### Secure Storage

- Uses `flutter_secure_storage` for sensitive data (tokens, credentials)
- Configured in dependency injection (`injection_container.dart`)
- Encrypts data using platform-specific secure storage (iOS Keychain, Android Keystore)
- No usage of SharedPreferences for sensitive data

### Environment Configuration

- Multi-environment support through `.env` files
- Environment-specific API configurations
- Configuration loaded through `AppConfig.initialize()`

## Key Directories

### Core Infrastructure

- `lib/core/`: Framework-level utilities, configs, and base classes
  - `config/`: Environment and API configuration
  - `resources/`: Data state, repository base, API clients, use case base
  - `utils/`: Validators, permissions, logging, responsive utilities
  - `error/`: Exception and failure handling
  - `database/`: Drift database setup, helpers, and table definitions
  - `enums/`: 14+ domain enums with serialization support (StatusType, UserRole, PaymentMethod, etc.)

### Feature Organization

- `lib/domain/`: Business logic layer (entities, repositories, use cases)
- `lib/data/`: Data access layer (repository implementations, API sources)
- `lib/presentation/`: UI layer organized by features
  - Each feature has: `screens/`, `widgets/`, `providers/`, `params/`
  - Widget components further organized: `widgets/components/` for reusable pieces
  - Shared widgets in `lib/presentation/widgets/` (core, popups)

### Configuration

- `lib/configs/`: App-wide configuration (providers, localization)
- Localization files in `assets/lang/`

## Development Guidelines

### Creating New Features

1. Start with domain layer: entities, repository interface, use cases
2. Implement data layer: repository implementation, API classes
3. Create presentation layer: providers, screens, widgets
4. Follow responsive design pattern with separate view files
5. Break down complex widgets into focused components (<150 lines each)
6. Register dependencies in `injection_container.dart`
7. Use lazy provider registration in `ProviderRegistry` for route-specific providers

### Provider Management Strategy

- **Global Providers**: Minimal set in `MyProviders.globalProviders` (theme, auth state)
- **Route-Specific Providers**: Register in `ProviderRegistry` with lazy loading
- **Screen-Specific Providers**: Use `ProviderScopeMixin` for temporary state
- Always implement proper `dispose()` methods and clear sensitive data

### File Naming Conventions

- Screens: `*_screen.dart`
- Views: `*_desktop_view.dart`, `*_tablet_view.dart`, `*_mobile_view.dart`
- Providers: `*_provider.dart`
- Use cases: `*_usecase.dart`
- Entities: `*_entity.dart`
- Repository implementations: `*_repository_impl.dart`
- Enums: `*_type.dart` or descriptive names like `user_role.dart`

### Database Development

- **Reference `backend.md` first**: Complete entity relationships and schema documented
- Define tables using Drift annotations in `lib/core/database/tables/`
- Register tables in `@DriftDatabase` decorator in `database.dart`
- Run `dart run build_runner build` after table changes
- Use proper foreign key relationships matching backend schema
- Implement migrations for schema changes
- **Local-First Approach**: All operations should work offline first, sync later
- Track data changes for synchronization (created_at, updated_at, sync_status)
- Local database supports fallback authentication for testing

### Data Synchronization Implementation

- **Action Queue**: Implement action tracking table for sync operations
- **Timestamp Tracking**: Every table should have created_at, updated_at fields
- **Sync Status Fields**: Track sync state (pending, synced, conflict)
- **Conflict Resolution**: Local changes take precedence in conflicts
- **Batch Operations**: Queue actions and sync in batches when online

### Widget Component Architecture

- Keep widgets under 100-150 lines maximum
- Create reusable components in `components/` subdirectories
- Use widget composition over large monolithic widgets
- Example component structure:
  ```
  login/widgets/
    ├── login_form_card.dart (main compositor)
    └── components/
        ├── login_form_header.dart
        ├── login_form_fields.dart
        ├── login_error_message.dart
        └── signup_button.dart
  ```
- Components should have single responsibility and be testable independently

### Security Best Practices

- Use `flutter_secure_storage` for sensitive data (never SharedPreferences)
- Store API tokens, user credentials securely
- Never commit `.env.*` files to version control
- Environment files are gitignored by default
- default currency for this system will be PKR
- Don't use hardcoded data until I asked you to do so