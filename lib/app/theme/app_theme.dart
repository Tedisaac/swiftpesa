import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dividerTheme: _dividerTheme,
      chipTheme: _chipTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      navigationBarTheme: _navigationBarTheme,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColors.bgLightPrimary,
      textTheme: _textTheme,
      appBarTheme: _appBarThemLight,
      cardTheme: _cardThemeLight,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationThemeLight,
      dividerTheme: _dividerTheme,
      chipTheme: _chipTheme,
      bottomNavigationBarTheme: _bottomNavigationBarThemeLight,
      navigationBarTheme: _navigationBarThemeLight,
    );
  }

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryDim,
    secondary: AppColors.primary,
    secondaryContainer: AppColors.primaryDim,
    surface: AppColors.bgCard,
    surfaceContainerLowest: AppColors.bgPrimary,
    surfaceContainerLow: AppColors.bgSecondary,
    surfaceContainer: AppColors.bgCard,
    surfaceContainerHigh: AppColors.bgElevated,
    surfaceContainerHighest: AppColors.bgExtra,
    onPrimary: Color(0xFF000000),
    onPrimaryContainer: AppColors.textPrimary,
    onSecondary: Color(0xFF000000),
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.bgExtra,
    outlineVariant: AppColors.cardBorder,
    error: AppColors.danger,
    onError: AppColors.textPrimary,
    errorContainer: Color(0xFF3E1414),
    onErrorContainer: AppColors.danger,
    tertiary: AppColors.info,
    tertiaryContainer: Color(0xFF1A2C4D),
    onTertiary: AppColors.textPrimary,
    inversePrimary: AppColors.primaryDim,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: Color(0xFFB3F5D1),
    secondary: AppColors.primary,
    secondaryContainer: Color(0xFFB3F5D1),
    surface: AppColors.bgLightCard,
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF5F7FA),
    surfaceContainer: AppColors.bgLightCard,
    surfaceContainerHigh: Color(0xFFF0F4F8),
    surfaceContainerHighest: Color(0xFFE8EDF2),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryContainer: AppColors.textLightPrimary,
    onSecondary: Color(0xFFFFFFFF),
    onSurface: AppColors.textLightPrimary,
    onSurfaceVariant: AppColors.textLightSecondary,
    outline: Color(0xFFD1D5DB),
    outlineVariant: Color(0xFFE5E7EB),
    error: AppColors.danger,
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFE5E5),
    onErrorContainer: Color(0xFF8B0000),
    tertiary: AppColors.info,
    tertiaryContainer: Color(0xFFDDE7FF),
    onTertiary: Color(0xFFFFFFFF),
    inversePrimary: AppColors.primaryDim,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static TextTheme get _textTheme {
    final baseTextTheme = GoogleFonts.dmSansTextTheme();

    return baseTextTheme.copyWith(
      // Display styles - Clash Display local font
      displayLarge: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
        color: AppColors.textPrimary,
      ),
      displayMedium: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 45,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
        color: AppColors.textPrimary,
      ),
      displaySmall: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
        color: AppColors.textPrimary,
      ),

      headlineLarge: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
        color: AppColors.textPrimary,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01,
        color: AppColors.textPrimary,
      ),
      headlineSmall: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      titleLarge: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),

      labelLarge: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelMedium: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelSmall: GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.textMuted,
      ),
    );
  }

  static TextStyle monoTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textSecondary,
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),
    );
  }

  static AppBarTheme get _appBarThemLight {
    return const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.textLightPrimary,
      titleTextStyle: TextStyle(
        fontFamily: 'Clash Display',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textLightPrimary,
      ),
      iconTheme: IconThemeData(
        color: AppColors.textLightPrimary,
        size: 24,
      ),
    );
  }

  static CardThemeData get _cardTheme {
    return const CardThemeData(
      elevation: 0,
      color: AppColors.bgCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      margin: EdgeInsets.zero,
    );
  }

  static CardThemeData get _cardThemeLight {
    return const CardThemeData(
      elevation: 0,
      color: AppColors.bgLightCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      margin: EdgeInsets.zero,
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: const Color(0xFF000000),
        disabledBackgroundColor: AppColors.bgElevated,
        disabledForegroundColor: AppColors.textMuted,
        shadowColor: AppColors.greenGlow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontFamily: 'Clash Display',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.textMuted,
        side: const BorderSide(
          color: Color(0x5900C853), // rgba(0,200,83,0.35)
          width: 1,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontFamily: 'Clash Display',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.textMuted,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgElevated,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.bgExtra, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.bgExtra, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0x8000C853), // rgba(0,200,83,0.5)
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0x80FF4444), // rgba(255,68,68,0.5)
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: 1,
        ),
      ),
      labelStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        letterSpacing: 0.08,
      ),
      hintStyle: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
      ),
      errorStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.danger,
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationThemeLight {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgLightCard,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0x80FF4444),
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: 2,
        ),
      ),
      labelStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textLightSecondary,
        letterSpacing: 0.08,
      ),
      hintStyle: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textLightSecondary,
      ),
      errorStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.danger,
      ),
    );
  }

  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: AppColors.bgExtra,
    thickness: 1,
    space: 1,
  );

  static ChipThemeData get _chipTheme {
    return ChipThemeData(
      backgroundColor: AppColors.bgCard,
      deleteIconColor: AppColors.textSecondary,
      disabledColor: AppColors.bgSecondary,
      selectedColor: AppColors.primary,
      secondarySelectedColor: AppColors.primaryDim,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF000000),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.bgExtra, width: 1),
      ),
    );
  }

  static const BottomNavigationBarThemeData _bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.bgSecondary,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textMuted,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  );

  static const BottomNavigationBarThemeData _bottomNavigationBarThemeLight =
      BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.bgLightCard,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textLightSecondary,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  );

  static NavigationBarThemeData get _navigationBarTheme {
    return NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.bgSecondary,
      indicatorColor: AppColors.primary,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: Color(0xFF000000),
            size: 24,
          );
        }
        return const IconThemeData(
          color: AppColors.textMuted,
          size: 24,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          );
        }
        return GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textMuted,
        );
      }),
    );
  }

  static NavigationBarThemeData get _navigationBarThemeLight {
    return NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.bgLightCard,
      indicatorColor: AppColors.primary,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: Color(0xFF000000),
            size: 24,
          );
        }
        return const IconThemeData(
          color: AppColors.textLightSecondary,
          size: 24,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textLightPrimary,
          );
        }
        return GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textLightSecondary,
        );
      }),
    );
  }
}
