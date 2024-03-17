import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_material_icon/community_material_icon.dart';

import 'settings_controller.dart';

enum ContainerPosition { hidden, left, center, right, }

class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';
  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class _SettingsViewState extends State<SettingsView> {
  static const List<String> _fonts = <String>[
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
  static const List<String> _languages = <String>[
    'English 🇺🇸',
    'Russian 🇷🇺',
    'Ukrainian 🇺🇦',
    'French 🇫🇷',
    'German 🇩🇪',
    'Hebrew 🇮🇱',
    'Vietnamese 🇻🇳',
    'Chinese CN 🇨🇳',
    'Chinese TW 🇹🇼',
  ];
  static const List<String> _themes = <String>[
    'Purple Theme 💜',
    'Coral Theme 🪸',
    'Mint Theme 🌿',
    'Rose Theme 🌹',
    'Ocean Theme 🌊',
    'Sun Theme ☀️',
    'Beach Theme 🏖️',
  ];
  late SettingsController controller;
  ContainerPosition _visibleContainer = ContainerPosition.hidden;
  Color? _lightColor;
  String _currentFont = 'NexaScript';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Provider.of<SettingsController>(context, listen: true);

    switch (controller.themeString) {
      case 'purple':
        _lightColor = alinasAppPurple[50];
        break;
      case 'coral':
        _lightColor = alinasAppCoral[50];
        break;
      case 'mint':
        _lightColor = alinasAppMint[50];
        break;
      case 'rose':
        _lightColor = alinasAppRose[50];
        break;
      case 'ocean':
        _lightColor = alinasAppOcean[50];
        break;
      case 'sun':
        _lightColor = alinasAppSun[50];
        break;
      case 'beach':
        _lightColor = alinasAppBeach[50];
        break;
    }

    if (controller.font != _currentFont) {
      _currentFont = controller.font;
    }
  }

  void _toggleContainer(ContainerPosition position) {
    setState(() {
      _visibleContainer = _visibleContainer == position ? ContainerPosition.hidden : position;
    });
  }

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
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Settings', style: TextStyle(fontFamily: _currentFont, fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40.0),),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: _visibleContainer == ContainerPosition.left ? 0 : -MediaQuery.of(context).size.width,
            // top: _visibleContainer == ContainerPosition.left ? MediaQuery.of(context).size.height / 4 : MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(color: Colors.white, width: 8.0),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: const Offset(2, 6),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.96,
                height: MediaQuery.of(context).size.height * 0.73,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                      // color: const Color.fromRGBO(201, 232, 254, 1),
                      color: _lightColor,
                      border: Border.all(color: Colors.white, width: 8.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListView.builder(
                      itemCount: _fonts.length,
                      itemBuilder: (BuildContext context, int index) {
                        String font = _fonts[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              border: Border.all(color: Colors.white, width: 6.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: SizedBox(
                              width: 300.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                  shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                ),
                                onPressed: () => controller.updateFont(font),
                                child: Text(
                                  font,
                                  style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: font,),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            // left: _visibleContainer == ContainerPosition.center ? 0 : -MediaQuery.of(context).size.width,
            // top: _visibleContainer == ContainerPosition.center ? MediaQuery.of(context).size.height / 4 : MediaQuery.of(context).size.height,
            top: _visibleContainer == ContainerPosition.center ? 0 : MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(color: Colors.white, width: 8.0),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: const Offset(2, 6),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.96,
                height: MediaQuery.of(context).size.height * 0.73,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                      // color: const Color.fromRGBO(201, 232, 254, 1),
                      color: _lightColor,
                      border: Border.all(color: Colors.white, width: 8.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListView.builder(
                      itemCount: _languages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              border: Border.all(color: Colors.white, width: 6.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: SizedBox(
                              width: 300.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                  shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                ),
                                onPressed: () {},
                                child: Text(
                                  _languages[index],
                                  style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            right: _visibleContainer == ContainerPosition.right ? 0 : -MediaQuery.of(context).size.width,
            // top: _visibleContainer == ContainerPosition.right ? MediaQuery.of(context).size.height / 4 : MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(color: Colors.white, width: 8.0),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: const Offset(2, 6),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.96,
                height: MediaQuery.of(context).size.height * 0.73,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                      // color: const Color.fromRGBO(201, 232, 254, 1),
                      color: _lightColor,
                      border: Border.all(color: Colors.white, width: 8.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListView.builder(
                      itemCount: _themes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              border: Border.all(color: Colors.white, width: 6.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: SizedBox(
                              width: 300.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                  shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                ),
                                onPressed: () {
                                  switch (_themes[index]) {
                                    case 'Purple Theme 💜':
                                      controller.updateTheme(customThemeData[CustomTheme.purple]);
                                      break;
                                    case 'Coral Theme 🪸':
                                      controller.updateTheme(customThemeData[CustomTheme.coral]);
                                      break;
                                    case 'Mint Theme 🌿':
                                      controller.updateTheme(customThemeData[CustomTheme.mint]);
                                      break;
                                    case 'Rose Theme 🌹':
                                      controller.updateTheme(customThemeData[CustomTheme.rose]);
                                      break;
                                    case 'Ocean Theme 🌊':
                                      controller.updateTheme(customThemeData[CustomTheme.ocean]);
                                      break;
                                    case 'Sun Theme ☀️':
                                      controller.updateTheme(customThemeData[CustomTheme.sun]);
                                      break;
                                    case 'Beach Theme 🏖️':
                                      controller.updateTheme(customThemeData[CustomTheme.beach]);
                                      break;}
                                },
                                child: Text(
                                  _themes[index],
                                  style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: const Border(
            top: BorderSide(
              color: Colors.white,
              width: 8.0,
            ),
          ),
        ),
        child: BottomAppBar(
          color: Theme.of(context).colorScheme.primary,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                onPressed: () => _toggleContainer(_visibleContainer == ContainerPosition.left ? ContainerPosition.hidden : ContainerPosition.left),
                iconSize: _visibleContainer == ContainerPosition.left ? 70.0 : 50.0,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all<double>(_visibleContainer == ContainerPosition.left ? 12.0 : 0.0),
                ),
                icon: const Icon(CommunityMaterialIcons.format_font, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _toggleContainer(_visibleContainer == ContainerPosition.center ? ContainerPosition.hidden : ContainerPosition.center),
                iconSize: _visibleContainer == ContainerPosition.center ? 70.0 : 50.0,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all<double>(_visibleContainer == ContainerPosition.center ? 12.0 : 0.0),
                ),
                icon: const Icon(CommunityMaterialIcons.google_translate, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _toggleContainer(_visibleContainer == ContainerPosition.right ? ContainerPosition.hidden : ContainerPosition.right),
                iconSize: _visibleContainer == ContainerPosition.right ? 70.0 : 50.0,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all<double>(_visibleContainer == ContainerPosition.right ? 12.0 : 0.0),
                ),
                icon: const Icon(CommunityMaterialIcons.theme_light_dark, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
