import 'package:flutter/material.dart';

import 'settings_service.dart';

enum CustomTheme {
  purple,
  coral,
  mint,
  rose,
  ocean,
  sun,
  beach,
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

final MaterialColor alinasAppPurple = createMaterialColor(const Color.fromRGBO(107, 59, 203, 1));
final MaterialColor alinasAppPurpleAccent = createMaterialColor(const Color.fromRGBO(56, 12, 107, 1));
final MaterialColor alinasAppCoral = createMaterialColor(const Color.fromRGBO(255, 127, 80, 1));
final MaterialColor alinasAppCoralAccent = createMaterialColor(const Color.fromRGBO(123, 55, 41, 1));
final MaterialColor alinasAppMint = createMaterialColor(const Color.fromRGBO(90, 161, 127, 1));
final MaterialColor alinasAppMintAccent = createMaterialColor(const Color.fromRGBO(10, 58, 42, 1));
final MaterialColor alinasAppRose = createMaterialColor(const Color.fromRGBO(215, 9, 79, 1));
final MaterialColor alinasAppRoseAccent = createMaterialColor(const Color.fromRGBO(126, 3, 21, 1));
final MaterialColor alinasAppOcean = createMaterialColor(const Color.fromRGBO(0, 139, 244, 1));
final MaterialColor alinasAppOceanAccent = createMaterialColor(const Color.fromRGBO(0, 69, 122, 1));
final MaterialColor alinasAppSun = createMaterialColor(const Color.fromRGBO(195, 188, 0, 1));
final MaterialColor alinasAppSunAccent = createMaterialColor(const Color.fromRGBO(187, 103, 0, 1));
final MaterialColor alinasAppBeach = createMaterialColor(const Color.fromRGBO(225, 191, 146, 1));
final MaterialColor alinasAppBeachAccent = createMaterialColor(const Color.fromRGBO(0, 111, 138, 1));

Map<CustomTheme, ThemeData> customThemeData = {
  CustomTheme.purple: ThemeData(
    primarySwatch: alinasAppPurple,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: alinasAppPurple, accentColor: alinasAppPurpleAccent),
    scaffoldBackgroundColor: alinasAppPurple[50],
  ),
  CustomTheme.coral: ThemeData(
    primarySwatch: alinasAppCoral,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: alinasAppCoral, accentColor: alinasAppCoralAccent),
    scaffoldBackgroundColor: alinasAppCoral[50],
  ),
  CustomTheme.mint: ThemeData(
    primarySwatch: alinasAppMint,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: alinasAppMint, accentColor: alinasAppMintAccent),
    scaffoldBackgroundColor: alinasAppMint[50],
  ),
  CustomTheme.rose: ThemeData(
    primarySwatch: alinasAppRose,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: alinasAppRose, accentColor: alinasAppRoseAccent),
    scaffoldBackgroundColor: alinasAppRose[50],
  ),
  CustomTheme.ocean: ThemeData(
    primarySwatch: alinasAppOcean,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: alinasAppOcean, accentColor: alinasAppOceanAccent),
    scaffoldBackgroundColor: alinasAppOcean[50],
  ),
  CustomTheme.sun: ThemeData(
    primarySwatch: alinasAppSun,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: alinasAppSun, accentColor: alinasAppSunAccent),
    scaffoldBackgroundColor: alinasAppSun[50],
  ),
  CustomTheme.beach: ThemeData(
    primarySwatch: alinasAppBeach,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: alinasAppBeach, accentColor: alinasAppBeachAccent),
    scaffoldBackgroundColor: alinasAppBeach[50],
  ),
};

// Theme strings
const String purpleString = 'purple';
const String coralString = 'coral';
const String mintString = 'mint';
const String roseString = 'rose';
const String oceanString = 'ocean';
const String sunString = 'sun';
const String beachString = 'beach';

// Book image IDs
const String myExternalCause = 'my_external_cause_front_cover_';
const String theJudge = 'The_Judge_front_cover_';
const String theDreamyMan = 'The_Dreamy_Man_front_cover_';
const String passportal = 'Passportal_front_cover_';
const String loveDrunk = 'Love_Drunk_front_cover_';
// Book image IDs Map
Map<int, String> bookImageIds = {
  0: 'my_external_cause_front_cover_',
  1: 'The_Judge_front_cover_',
  2: 'The_Dreamy_Man_front_cover_',
  3: 'Passportal_front_cover_',
  4: 'Love_Drunk_front_cover_',
};

// Fonts
const List<String> fonts = <String>[
  'NexaScript',
  'Angelina',
  'Ananias',
  'Bauhaus',
  'Frank',
  'Hummingbird',
  'Corruption',
  'Roboto',
  'NotoSerif',
  'Ubuntu',
];
const List<String> fontIds = <String>[
  'nexa',
  'angelina',
  'ananias',
  'bauhaus_medium',
  'frank',
  'hummingbird',
  'corruption',
  'roboto',
  'serif',
  'ubuntu',
];

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;
  // Make ThemeData a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeData? _theme;
  late String _themeString;
  late String _bookId;
  late List<String> _fonts;
  late List<String> _fontIds;
  late String _font;
  late String _fontId;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;
  // Allow Widgets to read the user's preferred ThemeData.
  ThemeData? get theme => _theme;
  String get themeString => _themeString;
  String get bookId => _bookId;
  List<String> get fonts => _fonts;
  List<String> get fontIds => _fontIds;
  String get font => _font;
  String get fontId => _fontId;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _theme = await _settingsService.theme();
    _themeString = _theme == customThemeData[CustomTheme.purple] ? purpleString :
      _theme == customThemeData[CustomTheme.coral] ? coralString :
      _theme == customThemeData[CustomTheme.mint] ? mintString :
      _theme == customThemeData[CustomTheme.rose] ? roseString :
      _theme == customThemeData[CustomTheme.ocean] ? oceanString :
      _theme == customThemeData[CustomTheme.sun] ? sunString :
      _theme == customThemeData[CustomTheme.beach] ? beachString : purpleString;
    _bookId = await _settingsService.bookId();
    // _fontId = await _settingsService.fontId();
    _font = await _settingsService.font();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  /// Update and persist the ThemeData based on the user's selection.
  Future<void> updateTheme(ThemeData? newTheme) async {
    if (newTheme == null) return;

    // Do not perform any work if new and old ThemeData are identical
    if (newTheme == _theme) return;

    // Otherwise, store the new ThemeData in memory
    _theme = newTheme;

    _themeString = newTheme == customThemeData[CustomTheme.purple] ? purpleString :
      newTheme == customThemeData[CustomTheme.coral] ? coralString :
      newTheme == customThemeData[CustomTheme.mint] ? mintString :
      newTheme == customThemeData[CustomTheme.rose] ? roseString :
      newTheme == customThemeData[CustomTheme.ocean] ? oceanString :
      newTheme == customThemeData[CustomTheme.sun] ? sunString :
      newTheme == customThemeData[CustomTheme.beach] ? beachString : purpleString;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateTheme(newTheme);
  }

  /// Update and persist the book ID based on the user's selection.
  Future<void> updateBookId(String newBookId) async {
    if (newBookId == _bookId) return;

    _bookId = newBookId;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateBookId(newBookId);
  }

  Future<void> updateFont(String newFont) async {
    if (newFont == _font) return;

    _font = newFont;
    // _fontId = fontIds[fonts.indexOf(newFont)];

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateFont(newFont);
    // await _settingsService.updateFontId(_fontId);
  }
}
