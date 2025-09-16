import 'package:flutter/material.dart';

/// Application theme configuration following Material Design 3
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light theme configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Color scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2196F3), // Professional blue
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFF2196F3),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFE3F2FD),
      onPrimaryContainer: const Color(0xFF0D47A1),
      
      secondary: const Color(0xFF4CAF50),
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFE8F5E9),
      onSecondaryContainer: const Color(0xFF1B5E20),
      
      tertiary: const Color(0xFFFF9800),
      onTertiary: Colors.white,
      tertiaryContainer: const Color(0xFFFFF3E0),
      onTertiaryContainer: const Color(0xFFE65100),
      
      error: const Color(0xFFD32F2F),
      onError: Colors.white,
      errorContainer: const Color(0xFFFFEBEE),
      onErrorContainer: const Color(0xFFB71C1C),
      
      surface: Colors.white,
      onSurface: const Color(0xFF1A1C1E),
      surfaceContainerLowest: const Color(0xFFFAFAFA),
      surfaceContainerLow: const Color(0xFFF5F5F5),
      surfaceContainer: const Color(0xFFF0F0F0),
      surfaceContainerHigh: const Color(0xFFEAEAEA),
      surfaceContainerHighest: const Color(0xFFE0E0E0),
      
      outline: const Color(0xFF79747E),
      outlineVariant: const Color(0xFFCAC4D0),
    ),
    
    // Typography
    textTheme: const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
      ),
      
      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.33,
      ),
      
      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      
      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      
      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    ),
    
    // Component themes
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 3,
    ),
    
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
      ),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      ),
    ),
    
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
    
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
    ),
    
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      elevation: 8,
    ),
    
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 6,
      highlightElevation: 12,
    ),
  );
  
  /// Dark theme configuration
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF2196F3),
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFF90CAF9),
      onPrimary: const Color(0xFF003258),
      primaryContainer: const Color(0xFF004A77),
      onPrimaryContainer: const Color(0xFFD0E4FF),
      
      secondary: const Color(0xFF81C784),
      onSecondary: const Color(0xFF003A02),
      secondaryContainer: const Color(0xFF005302),
      onSecondaryContainer: const Color(0xFFC5EFBF),
      
      tertiary: const Color(0xFFFFB74D),
      onTertiary: const Color(0xFF4A2800),
      tertiaryContainer: const Color(0xFF6A3C00),
      onTertiaryContainer: const Color(0xFFFFDCC2),
      
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
      
      surface: const Color(0xFF1A1C1E),
      onSurface: const Color(0xFFE2E2E6),
      surfaceContainerLowest: const Color(0xFF0F1113),
      surfaceContainerLow: const Color(0xFF1A1C1E),
      surfaceContainer: const Color(0xFF1E2022),
      surfaceContainerHigh: const Color(0xFF282A2C),
      surfaceContainerHighest: const Color(0xFF333537),
      
      outline: const Color(0xFF8F909A),
      outlineVariant: const Color(0xFF43474E),
    ),
    
    textTheme: const TextTheme(
      // Same typography as light theme
      // but colors will be automatically adjusted for dark mode
    ),
    
    // Component themes inherit from light theme with dark adjustments
  );
  
  /// Border radius constants
  static const BorderRadius radiusSmall = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radiusMedium = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusLarge = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusXLarge = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radiusRound = BorderRadius.all(Radius.circular(100));
  
  /// Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  /// Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  /// Elevation values
  static const double elevationLevel0 = 0;
  static const double elevationLevel1 = 1;
  static const double elevationLevel2 = 3;
  static const double elevationLevel3 = 6;
  static const double elevationLevel4 = 8;
  static const double elevationLevel5 = 12;
}