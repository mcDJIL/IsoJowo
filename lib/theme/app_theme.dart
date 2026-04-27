import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────
// AppColors – custom ThemeExtension carrying all brand-specific colors
// ─────────────────────────────────────────────────────────────────

class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color cardBackground;
  final Color navBarBackground;
  final Color navBarIconInactive;
  final Color navBarIconActive;
  final Color titleText;
  final Color sectionText;
  final Color cardText;
  final Color accent;
  final Color primary;
  final Color inputBackground;
  final Color divider;

  const AppColors({
    required this.background,
    required this.cardBackground,
    required this.navBarBackground,
    required this.navBarIconInactive,
    required this.navBarIconActive,
    required this.titleText,
    required this.sectionText,
    required this.cardText,
    required this.accent,
    required this.primary,
    required this.inputBackground,
    required this.divider,
  });

  // ── Convenience accessor ──────────────────────────────────────
  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;

  // ── Dark palette (current design) ────────────────────────────
  static const dark = AppColors(
    background: Color(0xFF13324E),
    cardBackground: Color(0xFFF9EAD7),
    navBarBackground: Color(0xFFF9EAD7),
    navBarIconInactive: Color(0xFF1A1A1A),
    navBarIconActive: Color(0xFFC6964B),
    titleText: Color(0xFFFFFFFF),
    sectionText: Color(0xFFF3EDE7),
    cardText: Color(0xFF000000),
    accent: Color(0xFFC6964B),
    primary: Color(0xFF13324E),
    inputBackground: Color(0xFF1E4A6E),
    divider: Color(0x33FFFFFF),
  );

  // ── Light palette ────────────────────────────────────────────
  static const light = AppColors(
    background: Color(0xFFFEF9F0),
    cardBackground: Color(0xFFFFFFFF),
    navBarBackground: Color(0xFF13324E),
    navBarIconInactive: Color(0xFFD9C9B8),
    navBarIconActive: Color(0xFFC6964B),
    titleText: Color(0xFF13324E),
    sectionText: Color(0xFF13324E),
    cardText: Color(0xFF13324E),
    accent: Color(0xFFC6964B),
    primary: Color(0xFF13324E),
    inputBackground: Color(0xFFEEE5D8),
    divider: Color(0x33000000),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? cardBackground,
    Color? navBarBackground,
    Color? navBarIconInactive,
    Color? navBarIconActive,
    Color? titleText,
    Color? sectionText,
    Color? cardText,
    Color? accent,
    Color? primary,
    Color? inputBackground,
    Color? divider,
  }) {
    return AppColors(
      background: background ?? this.background,
      cardBackground: cardBackground ?? this.cardBackground,
      navBarBackground: navBarBackground ?? this.navBarBackground,
      navBarIconInactive: navBarIconInactive ?? this.navBarIconInactive,
      navBarIconActive: navBarIconActive ?? this.navBarIconActive,
      titleText: titleText ?? this.titleText,
      sectionText: sectionText ?? this.sectionText,
      cardText: cardText ?? this.cardText,
      accent: accent ?? this.accent,
      primary: primary ?? this.primary,
      inputBackground: inputBackground ?? this.inputBackground,
      divider: divider ?? this.divider,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      navBarBackground:
          Color.lerp(navBarBackground, other.navBarBackground, t)!,
      navBarIconInactive:
          Color.lerp(navBarIconInactive, other.navBarIconInactive, t)!,
      navBarIconActive:
          Color.lerp(navBarIconActive, other.navBarIconActive, t)!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      sectionText: Color.lerp(sectionText, other.sectionText, t)!,
      cardText: Color.lerp(cardText, other.cardText, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// AppTheme – produces ThemeData for light and dark
// ─────────────────────────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.dark.background,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC6964B),
          secondary: Color(0xFFC6964B),
          surface: Color(0xFF1E4A6E),
          error: Color(0xFFD02E2E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        extensions: const [AppColors.dark],
      );

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.light.background,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF13324E),
          secondary: Color(0xFFC6964B),
          surface: Color(0xFFEEE5D8),
          error: Color(0xFFD02E2E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF13324E)),
          titleTextStyle: TextStyle(
            color: Color(0xFF13324E),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        extensions: const [AppColors.light],
      );
}
