import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
import 'dart:typed_data';

class PhotoFromServer extends StatefulWidget {
  const PhotoFromServer({super.key});

  @override
  State<PhotoFromServer> createState() => _PhotoFromServerState();
}

class _PhotoFromServerState extends State<PhotoFromServer> {
  Uint8List? _photoBytes;
  // late String _albumId;
  late String _currentPhotoString;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (_albumId != newAlbumId) {
    //   _albumId = newAlbumId;
    //   _fetchPhotos(newAlbumId);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: _photoBytes == null
          ? Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,) // Show loading spinner while fetching,
          )
          : FittedBox(
            child: Center(
              child: Image.network(_currentPhotoString, fit: BoxFit.cover,),
            ),
          ),
      ),
    );
  }
}
