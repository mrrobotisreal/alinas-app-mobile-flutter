import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import '../settings/settings_controller.dart';

class ImageFromServer extends StatefulWidget {
  const ImageFromServer({super.key});

  @override
  State<ImageFromServer> createState() => _ImageFromServerState();
}

class _ImageFromServerState extends State<ImageFromServer> {
  Uint8List? _imageBytes;
  String? _lastThemeName;
  String? _lastBookId;
  ImageProvider? _myExternalCauseImage;
  String _myExternalCauseImageString = 'http://3.76.7.134:9090/assets/backgrounds/my_external_cause_front_cover_ocean.png';
  ImageProvider? _theJudgeImage;
  String _theJudgeImageString = 'http://3.76.7.134:9090/assets/backgrounds/The_Judge_front_cover_ocean.png';
  ImageProvider? _theDreamyManImage;
  String _theDreamyManImageString = 'http://3.76.7.134:9090/assets/backgrounds/The_Dreamy_Man_front_cover_ocean.png';
  ImageProvider? _passportalImage;
  String _passportalImageString = 'http://3.76.7.134:9090/assets/backgrounds/Passportal_front_cover_ocean.png';
  ImageProvider? _loveDrunkImage;
  String _loveDrunkImageString = 'http://3.76.7.134:9090/assets/backgrounds/Love_Drunk_front_cover_ocean.png';
  String _currentBookImageString = 'http://3.76.7.134:9090/assets/backgrounds/The_Dreamy_Man_front_cover_ocean.png';
  // ImageProvider _currentBookImage = NetworkImage(_currentBookImageString);
  Image? _currentBookImage;

  @override
  void initState() {
    super.initState();
    _fetchImage(newTheme: null, newBookId: null);
    _fetchImages(newTheme: null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final settings = Provider.of<SettingsController>(context, listen: true);
    final newTheme = settings.themeString;
    final newBookId = settings.bookId;

    if (_lastThemeName != newTheme && _lastBookId != settings.bookId) {
      _lastThemeName = newTheme;
      _lastBookId = settings.bookId;
      _fetchImage(newTheme: newTheme, newBookId: settings.bookId);
      _fetchImages(newTheme: newTheme);
      setState(() {
        _currentBookImageString = 'http://3.76.7.134:9090/assets/backgrounds/$newBookId$newTheme.png';
      });
    } else if (_lastThemeName != newTheme) {
      _lastThemeName = newTheme;
      _fetchImage(newTheme: newTheme, newBookId: _lastBookId);
      _fetchImages(newTheme: newTheme);
      setState(() {
        _currentBookImageString = 'http://3.76.7.134:9090/assets/backgrounds/$_lastBookId$newTheme.png';
      });
    } else if (_lastBookId != settings.bookId) {
      _lastBookId = settings.bookId;
      _fetchImage(newTheme: _lastThemeName, newBookId: settings.bookId);
      setState(() {
        _currentBookImageString = 'http://3.76.7.134:9090/assets/backgrounds/$newBookId$_lastThemeName.png';
      });
    } else {
      print('No new theme or bookId. Not fetching image.');
    }
  }

  Future<void> _fetchImage({newTheme, newBookId}) async {
    String themeString = Provider.of<SettingsController>(context, listen: false).themeString;
    String bookId = Provider.of<SettingsController>(context, listen: false).bookId;

    try {
      var response = await http.get(Uri.parse(newTheme != null && newBookId != null
      ? 'http://3.76.7.134:9090/assets/backgrounds/$newBookId$newTheme.png'
      : 'http://3.76.7.134:9090/assets/backgrounds/$bookId$themeString.png'));
      if (response.statusCode == 200) {
        setState(() {
          _imageBytes = response.bodyBytes;
        });
      } else {
        // Handle server error
        print('Failed to load image. See response code below:');
        print(response.statusCode);
      }
    } catch (e) {
      // Handle network error
      print('Failed to load image: $e');
    }
  }

  Future<void> _fetchImages({newTheme}) async {
    String themeString = Provider.of<SettingsController>(context, listen: false).themeString;

    try {
      setState(() {
        _myExternalCauseImage = NetworkImage(newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/my_external_cause_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/my_external_cause_front_cover_$themeString.png');
        _myExternalCauseImageString = newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/my_external_cause_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/my_external_cause_front_cover_$themeString.png';
        precacheImage(_myExternalCauseImage!, context);

        _theJudgeImage = NetworkImage(newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/The_Judge_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/The_Judge_front_cover_$themeString.png');
        _theJudgeImageString = newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/The_Judge_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/The_Judge_front_cover_$themeString.png';
        precacheImage(_theJudgeImage!, context);

        _theDreamyManImage = NetworkImage(newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/The_Dreamy_Man_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/The_Dreamy_Man_front_cover_$themeString.png');
        _theDreamyManImageString = newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/The_Dreamy_Man_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/The_Dreamy_Man_front_cover_$themeString.png';
        precacheImage(_theDreamyManImage!, context);

        _passportalImage = NetworkImage(newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/Passportal_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/Passportal_front_cover_$themeString.png');
        _passportalImageString = newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/Passportal_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/Passportal_front_cover_$themeString.png';
        precacheImage(_passportalImage!, context);

        _loveDrunkImage = NetworkImage(newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/Love_Drunk_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/Love_Drunk_front_cover_$themeString.png');
        _loveDrunkImageString = newTheme != null
        ? 'http://3.76.7.134:9090/assets/backgrounds/Love_Drunk_front_cover_$newTheme.png'
        : 'http://3.76.7.134:9090/assets/backgrounds/Love_Drunk_front_cover_$themeString.png';
        precacheImage(_loveDrunkImage!, context);

      });
    } catch (e) {
      //
      print('Failed to load images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenWith = MediaQuery.of(context).size.width;
    // double containerWidth = screenWith * 0.99;


    return Container(
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
      // width: containerWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: _imageBytes == null
          ? const Center(
            child: CircularProgressIndicator(color: Colors.white,) // Show loading spinner while fetching,
          )
          : FittedBox(
            child: Center(
              // child: Image.memory(_imageBytes!),
              // child: Image.memory(_imageBytes!, fit: BoxFit.cover,)
              child: Image.network(_currentBookImageString, fit: BoxFit.cover,),
            ),
          ),
      ),
    );
  }
}
