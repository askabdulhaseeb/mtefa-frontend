# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter POS (Point of Sale) system with multi-brand support, stock control, and activity tracking. The application uses Restful API for backend services and implements Clean Architecture with responsive design patterns.
Local Database will be "Drift (SQLite)"

## Development Commands

### Initial Setup

```bash
# Complete setup with dependencies and iOS pods
flutter clean && flutter pub get && cd macos && pod install && cd ..

# Environment setup (creates .env files from template)
dart scripts/setup_env.dart development
dart scripts/setup_env.dart staging
dart scripts/setup_env.dart production
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
```

### Quality Assurance

```bash
# Run linter
flutter analyze

# Run tests
flutter test
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
- Concrete implementations in `lib/data/sources/repositories/`

#### Responsive Design

- Uses `MyScaffold` widget for responsive layouts
- Breakpoints: Desktop (>1000px), Tablet (600-1000px), Mobile (<600px)
- Each screen has separate view files: `*_desktop_view.dart`, `*_tablet_view.dart`, `*_mobile_view.dart`

#### State Management

- Provider pattern with dedicated provider classes
- Providers registered globally in `lib/configs/providers/my_providers.dart`
- State classes follow naming convention: `*Provider`

#### Dependency Injection

- Uses GetIt for service locator pattern
- Configuration in `lib/injection_container.dart`
- Services registered by feature modules (e.g., `_auth()`)

### Data State Management

The app uses a custom `DataState<T>` system for handling async operations:

- `DataSuccess<T>`: Successful operation with data
- `DataFailed<T>`: Failed operation with failure details
- `DataLoading<T>`: Loading state
- Extensions provide convenient methods: `isSuccess`, `isFailed`, `isLoading`, `when()`

### Environment Configuration

- Multi-environment support through `.env` files
- Environment-specific API configurations
- Configuration loaded through `AppConfig.initialize()`
- Environment setup script: `dart scripts/setup_env.dart [environment]`

## Key Directories

### Core Infrastructure

- `lib/core/`: Framework-level utilities, configs, and base classes
  - `config/`: Environment and API configuration
  - `resources/`: Data state, repository base, API clients
  - `utils/`: Validators, permissions, logging
  - `error/`: Exception and failure handling

### Feature Organization

- `lib/domain/`: Business logic layer (entities, repositories, use cases)
- `lib/data/`: Data access layer (repository implementations, APIs)
- `lib/presentation/`: UI layer organized by features
  - Each feature has: `screens/`, `widgets/`, `providers/`, `params/`

### Configuration

- `lib/configs/`: App-wide configuration (routing, providers, localization)
- Localization files in `assets/lang/`

## Development Guidelines

### Creating New Features

1. Start with domain layer: entities, repository interface, use cases
2. Implement data layer: repository implementation, API classes
3. Create presentation layer: providers, screens, widgets
4. Follow responsive design pattern with separate view files
5. Register dependencies in `injection_container.dart`
6. Add provider to `my_providers.dart`

### File Naming Conventions

- Screens: `*_screen.dart`
- Views: `*_desktop_view.dart`, `*_tablet_view.dart`, `*_mobile_view.dart`
- Providers: `*_provider.dart`
- Use cases: `*_usecase.dart`
- Entities: `*_entity.dart`
- Repository implementations: `*_repository_impl.dart`

### Environment Variables

Required variables in `.env.[environment]` files:

### Security Notes

- Never commit `.env.*` files to version control
- Use different API projects for each environment
- Environment files are gitignored by default
