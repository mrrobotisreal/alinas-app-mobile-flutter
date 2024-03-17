import 'package:alinas_app/src/photos/photos_main_view.dart';
import 'package:alinas_app/src/sample_feature/book_image.dart';
import 'package:alinas_app/src/settings/settings_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

import '../settings/settings_view.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

/// Displays a list of SampleItems.
class _SampleItemListViewState extends State<SampleItemListView> {
  late SettingsController settings;
  String _currentFont = 'NexaScript';

  int _selectedBookIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settings = Provider.of<SettingsController>(context, listen: true);

    if (settings.font != _currentFont) {
      setState(() {
        _currentFont = settings.font;
      });
    }
  }

  void _handleNextBook() {
    if (_selectedBookIndex == 4) {
      _selectedBookIndex = 0;
      settings.updateBookId(bookImageIds[0]!);
    } else {
      _selectedBookIndex = _selectedBookIndex + 1;
      settings.updateBookId(bookImageIds[_selectedBookIndex]!);
    }
  }

  void _handlePreviousBook() {
    if (_selectedBookIndex == 0) {
      _selectedBookIndex = 4;
      settings.updateBookId(bookImageIds[4]!);
    } else {
      _selectedBookIndex = _selectedBookIndex - 1;
      settings.updateBookId(bookImageIds[_selectedBookIndex]!);
    }
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
            title: Text('Main Menu', style: TextStyle(fontFamily: _currentFont, fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Navigate to the settings page. If the user leaves and returns
                  // to the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(context, SettingsView.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          child: ImageFromServer(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
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
              IconButton(onPressed: _handlePreviousBook, icon: const Icon(CommunityMaterialIcons.page_previous, color: Colors.white), iconSize: 60.0,),
              IconButton(onPressed: () {
                showModalBottomSheet(context: context, builder: (BuildContext context) {
                  return Container(
                    height: 1000,
                    color: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
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
                                    Navigator.pop(context);
                                    Navigator.restorablePushNamed(context, PhotosMainView.routeName);
                                  },
                                  child: Text(
                                    'Photos 📸',
                                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
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
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Read 📖',
                                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
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
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Listen 🎧',
                                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
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
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Watch 📺',
                                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
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
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Notes ✍🏻',
                                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
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
                                    Navigator.pop(context);
                                    Navigator.restorablePushNamed(context, SettingsView.routeName);
                                  },
                                  child: Text(
                                    'Settings ⚙️',
                                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: _currentFont,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              }, icon: const Icon(Icons.menu, color: Colors.white), iconSize: 60.0,),
              IconButton(onPressed: _handleNextBook, icon: const Icon(CommunityMaterialIcons.page_next, color: Colors.white), iconSize: 60.0,),
            ],
          ),
        ),
      ),
    );
  }
}
