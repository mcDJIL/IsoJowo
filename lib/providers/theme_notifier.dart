import 'package:flutter/material.dart';

/// Global singleton ValueNotifier for ThemeMode.
/// Access anywhere via [ThemeNotifier.instance].
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier._() : super(ThemeMode.dark);

  static final ThemeNotifier instance = ThemeNotifier._();

  bool get isDark => value == ThemeMode.dark;

  void setDark() {
    value = ThemeMode.dark;
  }

  void setLight() {
    value = ThemeMode.light;
  }

  void toggle() {
    value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
