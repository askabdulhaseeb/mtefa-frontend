class DoubleConstants {
  static const double mobileWidth = 375;
  static const double tabletWidth = 768;
  static const double desktopWidth = 1024;

  // Common spacing values
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border radius values
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusCircular = 50.0;

  // Icon sizes
  static const double iconXS = 12.0;
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Animation durations (in milliseconds)
  static const double animationFast = 150.0;
  static const double animationNormal = 300.0;
  static const double animationSlow = 500.0;

  // Elevation values
  static const double elevationNone = 0.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;
}

class IntConstants {
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int minPageSize = 5;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 50;

  // Cache durations (in seconds)
  static const int cacheShortDuration = 300; // 5 minutes
  static const int cacheMediumDuration = 1800; // 30 minutes
  static const int cacheLongDuration = 3600; // 1 hour

  // Network timeouts (in seconds)
  static const int shortTimeout = 10;
  static const int normalTimeout = 30;
  static const int longTimeout = 120;

  // Retry attempts
  static const int maxRetryAttempts = 3;
  static const int maxUploadRetries = 5;
}