import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color danger;
  final Color onDanger;
  final Color subtleText;
  final Color cardHighlight;

  const AppColorsExtension({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.danger,
    required this.onDanger,
    required this.subtleText,
    required this.cardHighlight,
  });

  @override
  AppColorsExtension copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? danger,
    Color? onDanger,
    Color? subtleText,
    Color? cardHighlight,
  }) {
    return AppColorsExtension(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      subtleText: subtleText ?? this.subtleText,
      cardHighlight: cardHighlight ?? this.cardHighlight,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      subtleText: Color.lerp(subtleText, other.subtleText, t)!,
      cardHighlight: Color.lerp(cardHighlight, other.cardHighlight, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  static const double radiusSmall = 10.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 22.0;

  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  static const double buttonHeight = 52.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 76.0;

  static const double opacityDisabled = 0.38;
  static const double opacityOverlay = 0.55;
  static const double opacityScrim = 0.35;

  static const double borderDefault = 1.0;
  static const double borderSelected = 1.8;
  static const double borderThick = 2.0;

  static final ThemeData lightTheme = _buildTheme(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F6E5E),
      brightness: Brightness.light,
      secondary: const Color(0xFF1B2A4A),
    ),
    appColors: const AppColorsExtension(
      success: Color(0xFF1F9D6B),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFFC9820B),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFD64545),
      onDanger: Color(0xFFFFFFFF),
      subtleText: Color(0xFF6B7686),
      cardHighlight: Color(0xFFE9F5F1),
    ),
  );

  static ThemeData _buildTheme({required ColorScheme colorScheme, required AppColorsExtension appColors}) {
    final textTheme = _buildTextTheme(colorScheme);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
          side: BorderSide(color: colorScheme.outline),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMedium)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorScheme.primary, width: borderThick),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: spacingMd, vertical: 14),
        labelStyle: textTheme.bodyMedium,
      ),
      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant, space: spacingLg),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: textTheme.labelMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)),
        padding: const EdgeInsets.symmetric(horizontal: spacingSm, vertical: spacingXs),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        elevation: 0,
      ),
      extensions: [appColors],
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final base = GoogleFonts.manropeTextTheme(ThemeData(colorScheme: colorScheme, useMaterial3: true).textTheme);
    final headings = GoogleFonts.plusJakartaSansTextTheme(base);
    return base.copyWith(
      headlineLarge: headings.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
      headlineMedium: headings.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
      headlineSmall: headings.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      titleLarge: headings.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium: headings.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      labelMedium: base.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
      bodyMedium: base.bodyMedium?.copyWith(height: 1.4),
    );
  }
}
