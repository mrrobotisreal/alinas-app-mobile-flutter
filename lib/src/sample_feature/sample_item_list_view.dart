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

  int _selectedBookIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settings = Provider.of<SettingsController>(context, listen: true);
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
            title: const Text('Main Menu', style: TextStyle(fontFamily: 'NexaScript', fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
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

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      // body: ListView.builder(
      //   // Providing a restorationId allows the ListView to restore the
      //   // scroll position when a user leaves and returns to the app after it
      //   // has been killed while running in the background.
      //   restorationId: 'sampleItemListView',
      //   itemCount: items.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final item = items[index];

      //     return ListTile(
      //       title: Text('SampleItem ${item.id}'),
      //       leading: const CircleAvatar(
      //         // Display the Flutter Logo image asset.
      //         // foregroundImage: AssetImage('assets/images/flutter_logo.png'),
      //         foregroundImage: AssetImage('assets/images/I_Love_You_Alina_icon.png'),
      //       ),
      //       onTap: () {
      //         // Navigate to the details page. If the user leaves and returns to
      //         // the app after it has been killed while running in the
      //         // background, the navigation stack is restored.
      //         Navigator.restorablePushNamed(
      //           context,
      //           SampleItemDetailsView.routeName,
      //         );
      //       }
      //     );
      //   },
      // ),
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
                    height: 600,
                    color: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Epic bottom drawer dude!', style: TextStyle(color: Colors.black,),),
                            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Close', style: TextStyle(color: Colors.black),),),
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
