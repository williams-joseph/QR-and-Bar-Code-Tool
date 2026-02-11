import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the ThemeNotifier.
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

/// Notifier to manage and toggle the application's theme.
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    // Default theme is system
    return ThemeMode.system;
  }

  /// Toggles between light and dark theme.
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
