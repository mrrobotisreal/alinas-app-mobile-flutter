import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
// import 'package:carousel_slider/carousel_slider.dart';

import '../settings/settings_controller.dart';
import 'photo_carousel.dart';

enum ContainerPosition { hidden, left, center, right, }
enum Album { portugal, photoshoot, austria, paris, frankfurt, }

class PhotosMainView extends StatefulWidget {
  const PhotosMainView({super.key, required this.controller});

  static const routeName = '/photos';
  final SettingsController controller;

  @override
  State<PhotosMainView> createState() => _PhotosMainViewState();
}

class _PhotosMainViewState extends State<PhotosMainView> {
  static const List<String> _albums = <String>[
    '🇵🇹 Portugal ❤️',
    '📸🇵🇹 Photoshoot ❤️',
    '🇦🇹 Austria ❤️',
    '🇫🇷🗼 Paris ❤️',
    '🇩🇪 Frankfurt ❤️',
  ];
  // static const List<String> _albumIds = <String>[
  //   'portugal',
  //   'portugalPhotoshoot',
  //   'austria',
  //   'paris',
  //   'frankfurt',
  // ];
  // static const List<int> _albumLengths = <int>[
  //   40,
  //   57,
  //   63,
  //   31,
  //   112,
  // ];
  String _currentAlbum = '🇵🇹 Portugal ❤️';
  String _currentAlbumId = 'portugal';
  int _currentAlbumLength = 40;
  // ContainerPosition _containerPosition = ContainerPosition.hidden;
  late SettingsController controller;
  Color? _lightColor;
  String _currentFont = 'NexaScript';
  ContainerPosition _visibleContainer = ContainerPosition.hidden;

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

  void _openAlbum(String album) {
    String newAlbumId;
    int newAlbumLength;
    switch (album) {
      case '🇵🇹 Portugal ❤️':
        newAlbumId = 'portugal';
        newAlbumLength = 40;
        break;
      case '📸🇵🇹 Photoshoot ❤️':
        newAlbumId = 'portugalPhotoshoot';
        newAlbumLength = 57;
        break;
      case '🇦🇹 Austria ❤️':
        newAlbumId = 'austria';
        newAlbumLength = 63;
        break;
      case '🇫🇷🗼 Paris ❤️':
        newAlbumId = 'paris';
        newAlbumLength = 31;
        break;
      case '🇩🇪 Frankfurt ❤️':
        newAlbumId = 'frankfurt';
        newAlbumLength = 112;
        break;
      default:
        newAlbumId = 'portugal';
        newAlbumLength = 40;
    }

    setState(() {
      _visibleContainer = ContainerPosition.center;
      _currentAlbum = album;
      _currentAlbumId = newAlbumId;
      _currentAlbumLength = newAlbumLength;
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
            title: Text('Photos... 📸', style: TextStyle(fontFamily: _currentFont, fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40.0),),
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
                      // color: const Color.fromRGBO(201, 232, 254, 1),
                      color: _lightColor,
                      border: Border.all(color: Colors.white, width: 8.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListView.builder(
                      itemCount: _albums.length,
                      itemBuilder: (BuildContext context, int index) {
                        String font = _albums[index];
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
                                onPressed: () => _openAlbum(_albums[index]),
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
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        _currentAlbum,
                        style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.86,
                        height: MediaQuery.of(context).size.height * 0.60,
                        decoration: BoxDecoration(
                          // color: const Color.fromRGBO(201, 232, 254, 1),
                          color: _lightColor,
                          border: Border.all(color: Colors.white, width: 8.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: PhotoCarousel(albumId: _currentAlbumId, albumLength: _currentAlbumLength, currentFont: _currentFont,),
                      ),
                      // const SizedBox(
                      //   height: 6,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            iconSize: 42.0,
                            icon: const Icon(Icons.arrow_circle_left, color: Colors.white,),
                          ),
                          IconButton(
                            onPressed: () {},
                            iconSize: 42.0,
                            icon: const Icon(Icons.arrow_circle_right, color: Colors.white,),
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 6,
                      // ),
                    ],
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
              IconButton(
                onPressed: () => _toggleContainer(_visibleContainer == ContainerPosition.center ? ContainerPosition.hidden : ContainerPosition.center),
                iconSize: _visibleContainer == ContainerPosition.center ? 70.0 : 50.0,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  elevation: MaterialStateProperty.all<double>(_visibleContainer == ContainerPosition.center ? 12.0 : 0.0),
                ),
                icon: const Icon(Icons.camera, color: Colors.white),
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