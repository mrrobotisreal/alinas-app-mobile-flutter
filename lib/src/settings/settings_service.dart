import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'settings_controller.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;
  // Future<CustomThemeMode> themeMode() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final themeIndex = prefs.getInt('themeMode') ?? 0;

  //   return CustomThemeMode.values[0];
  // }

  /// Loads the User's preferred Theme from local or remote storage.
  Future<ThemeData?> theme() async => customThemeData[CustomTheme.ocean];
    // ThemeData? theme() => customThemeData[CustomTheme.ocean];

  Future<String> bookId() async => theDreamyMan;

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('themeMode', CustomThemeMode.values.indexOf(theme));
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateTheme(ThemeData theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('theme', theme.index);
  }

  Future<void> updateBookId(String bookId) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('bookId', bookId);
  }
}
