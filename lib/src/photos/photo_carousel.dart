import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class _Photo {
  final String _url;
  final ImageProvider _imageProvider;
  final Image _image;
  final int _index;
  const _Photo(this._url, this._imageProvider, this._image, this._index);

  String get url => _url;
  NetworkImage get imageProvider => _imageProvider as NetworkImage;
  Image get image => _image;
  int get index => _index;
}

class PhotoCarousel extends StatefulWidget {
  final String albumId;
  final int albumLength;
  final String currentFont;
  const PhotoCarousel({super.key, required this.albumId, required this.albumLength, required this.currentFont});

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  // Uint8List? _photoBytes;
  ImageProvider? _photoProvider;
  late String _albumId = widget.albumId;
  late int _currentAlbumLength = widget.albumLength;
  late String _currentPhotoUrl;
  late String _currentFont = widget.currentFont;
  final List<String> _photoUrls = [];
  final List<_Photo> _photos = [];

  @override
  void initState() {
    super.initState();
    _albumId = widget.albumId;
    _currentAlbumLength = widget.albumLength;
    int idx = 1;
    String photoIndex = _getPhotoIndex(idx);
    _currentPhotoUrl = 'http://3.76.7.134:9090/assets/photosAlbums/$_albumId/$_albumId$photoIndex';
    _fetchPhoto();
    _fetchPhotos(_albumId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String newAlbumId = widget.albumId;

    if (_albumId != newAlbumId) {
      _albumId = newAlbumId;
      _fetchPhotos(newAlbumId);
    }
  }

  @override
  void didUpdateWidget(covariant PhotoCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.albumId != widget.albumId) {
      _albumId = widget.albumId;
      _currentAlbumLength = widget.albumLength;
      _currentFont = widget.currentFont;
      _photoUrls.clear();
      _photos.clear();
      _fetchPhotos(_albumId);
    }
  }

  String _getPhotoIndex(int index) {
    if (index < 10) {
      return '00$index.jpg';
    } else if (index >= 10 && index < 100) {
      return '0$index.jpg';
    } else {
      return '$index.jpg';
    }
  }

  Future<void> _fetchPhotos(String albumId) async {
    for(var i = 1; i <= _currentAlbumLength; i++) {
      String photoIndex = _getPhotoIndex(i);
      String url = 'http://3.76.7.134:9090/assets/photosAlbums/$albumId/$albumId$photoIndex';
      _photoUrls.add(url);
      setState(() {
        _photoProvider = NetworkImage(url);
        precacheImage(_photoProvider!, context);
        // Image image = Image.network(url, width: double.infinity, fit: BoxFit.cover,);
        Image cachedImage = Image(image: _photoProvider!, fit: BoxFit.cover, width: double.infinity,);
        // _photos.add(_Photo(url, _photoProvider!, image,));
        _photos.add(_Photo(url, _photoProvider!, cachedImage, i,));
      });
    }
  }

  Future<void> _fetchPhoto() async {
    try {
      final response = await http.get(Uri.parse(_currentPhotoUrl));
      if (response.statusCode == 200) {
        // setState(() {
        //   _photoBytes = response.bodyBytes;
        // });
      } else {
        throw Exception('Failed to load photo');
      }
    } catch (e) {
      print('Failed to load photo. See error below:');
      print(e);
    }
  }

  // void _nextPhoto() {}

  // void _previousPhoto() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              enlargeFactor: 2.0,
            ),
            items: _photos.map((photo) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 8.0,
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    photo.image,
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Text(
                        'Photo ${photo.index} of $_currentAlbumLength',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: _currentFont,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
      ),
    );
  }
}
