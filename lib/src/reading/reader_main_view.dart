import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_material_icon/community_material_icon.dart';

import '../settings/settings_controller.dart';
import '../custom_icons/my_flutter_app_icons.dart';

enum ContainerPosition { hidden, left, center, right, }

class ReaderMainView extends StatefulWidget {
  const ReaderMainView({super.key, required this.controller});

  static const routeName = '/reader';
  final SettingsController controller;

  @override
  State<ReaderMainView> createState() => _ReaderMainViewState();
}

class _ReaderMainViewState extends State<ReaderMainView> {
  late SettingsController controller;
  Color? _lightColor;
  String _currentFont = 'NexaScript';
  ContainerPosition _visibleContainer = ContainerPosition.hidden;
  List<String> _chapters = <String>[
    'Chapter 1',
    'Chapter 2',
    'Chapter 3',
    'Chapter 4',
    'Chapter 5',
    'Chapter 6',
    'Chapter 7',
    'Chapter 8',
    'Chapter 9',
    'Chapter 10',
  ];
  String _currentChapter = 'Chapter 1';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Provider.of<SettingsController>(context);

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
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text('Reading... 📖', style: TextStyle(fontFamily: _currentFont, fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40.0),),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: _visibleContainer == ContainerPosition.left ? 0 : -MediaQuery.of(context).size.width,
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
                      color: _lightColor,
                      border: Border.all(color: Colors.white, width: 8.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListView.builder(
                      itemCount: _chapters.length,
                      itemBuilder: (BuildContext context, int index) {
                        String font = _chapters[index];
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
                                  font,
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
                        width: MediaQuery.of(context).size.width * 0.86,
                        height: MediaQuery.of(context).size.height * 0.68,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 8.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text('Center container... for now', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 24.0, fontFamily: _currentFont,),)
                      ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            right: _visibleContainer == ContainerPosition.right ? 0 : -MediaQuery.of(context).size.width,
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
                    child: Text('Right Container', style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,)),
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
                icon: const Icon(Icons.photo_album, color: Colors.white),
              ),
              IconButton(onPressed: _visibleContainer == ContainerPosition.center ? () {} : null, icon: Icon(CommunityMaterialIcons.page_previous, color: _visibleContainer == ContainerPosition.center ? Colors.white : Colors.grey), iconSize: 40.0,),
              IconButton(
                onPressed: () => _toggleContainer(_visibleContainer == ContainerPosition.center ? ContainerPosition.hidden : ContainerPosition.center),
                iconSize: _visibleContainer == ContainerPosition.center ? 70.0 : 50.0,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all<double>(_visibleContainer == ContainerPosition.center ? 12.0 : 0.0),
                ),
                icon: Icon(_visibleContainer == ContainerPosition.center ? MyFlutterApp.book_open : CommunityMaterialIcons.book_alphabet , color: Colors.white),
              ),
              IconButton(onPressed: _visibleContainer == ContainerPosition.center ? () {} : null, icon: Icon(CommunityMaterialIcons.page_next, color: _visibleContainer == ContainerPosition.center ? Colors.white : Colors.grey), iconSize: 40.0,),
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
