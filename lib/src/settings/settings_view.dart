import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: const Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 8.0,
              ),
              // top: BorderSide(
              //   color: Colors.white,
              //   width: 8.0,
              // ),
              // left: BorderSide(
              //   color: Colors.white,
              //   width: 8.0,
              // ),
              // right: BorderSide(
              //   color: Colors.white,
              //   width: 8.0,
              // ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Settings', style: TextStyle(fontFamily: 'NexaScript', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40.0),),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: const Border(
              top: BorderSide(
                color: Colors.white,
                width: 8.0,
              ),
              bottom: BorderSide(
                color: Colors.white,
                width: 8.0,
              ),
              left: BorderSide(
                color: Colors.white,
                width: 8.0,
              ),
              right: BorderSide(
                color: Colors.white,
                width: 8.0,
              ),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Select Theme Mode', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'NexaScript', color: Colors.white, decoration: TextDecoration.underline, decorationColor: Colors.white),),
                SizedBox(
                  width: 300,
                  child: Center(
                    child: DropdownButton<ThemeMode>(
                      // Read the selected themeMode from the controller
                      value: controller.themeMode,
                      // Call the updateThemeMode method any time the user selects a theme.
                      onChanged: controller.updateThemeMode,
                      items: const [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text('System Theme 💻', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text('Light Theme ☀️', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text('Dark Theme 🌙', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text('Select Theme Mode', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'NexaScript', color: Colors.white, decoration: TextDecoration.underline, decorationColor: Colors.white),),
                SizedBox(
                  width: 300,
                  child: Center(
                    child: DropdownButton<ThemeData>(
                      value: controller.theme,
                      items: [
                        DropdownMenuItem(
                          value: customThemeData[CustomTheme.purple],
                          child: const Text('Purple Theme 💜', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: customThemeData[CustomTheme.coral],
                          child: const Text('Coral Theme 🪸', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: customThemeData[CustomTheme.mint],
                          child: const Text('Mint Theme 🌿', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: customThemeData[CustomTheme.rose],
                          child: const Text('Rose Theme 🌹', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: customThemeData[CustomTheme.ocean],
                          child: const Text('Ocean Theme 🌊', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: customThemeData[CustomTheme.sun],
                          child: const Text('Sun Theme ☀️', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                        DropdownMenuItem(
                          value: customThemeData[CustomTheme.beach],
                          child: const Text('Beach Theme 🏖️', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontFamily: 'NexaScript', color: Colors.white),),
                        ),
                      ],
                      onChanged: controller.updateTheme,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
