import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prepping_penguin/article_list_page.dart';
import 'package:prepping_penguin/create_article.dart';
import 'package:prepping_penguin/disaster_supplies.dart';
import 'package:prepping_penguin/injury_treatment.dart';

import 'package:prepping_penguin/inventory.dart';
import 'package:prepping_penguin/inventory_model.dart';
import 'package:prepping_penguin/medical_supplies.dart';
import 'package:prepping_penguin/settings.dart';
import 'package:prepping_penguin/shelter_search.dart';
import 'package:prepping_penguin/skills.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  var path = "/assets/db";
  if (!kIsWeb) {
    var appDocDir = await getApplicationDocumentsDirectory();
    path = appDocDir.path;
  }
  Hive.registerAdapter<Inventory>(InventoryAdapter());
  await Hive.initFlutter();  
  Hive.init(path);

  
  Hive.openLazyBox<Inventory>('inventory');
  
  runApp(ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Prepping Penguin';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var loggedIn = false; /// set to check if logged in, may switch to api key for app
  var current = '';

  void getNext() {
    current = '';
    notifyListeners();
  }

  var favorites = <String>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});
  
  String get title => "Prepping Penguin";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    // replace with pages
    InjuryTreatmentPage(),
    DisasterSuppliesPage(),
    InventoryPage(),
    MedicalSuppliesPage(),
    SettingsPage(),
    ShelterSearchPage(),
    SkillsPage(),
    ArticleListPage(),
    CreateArticlePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          shrinkWrap: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Image.asset('assets/images/nuclear-bomb.jpg'),
            ),
            ListTile(
              title: const Text('Injury Treatment'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Disaster Supplies'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Inventory'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Medical Supplies'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Shelter Search'),
              selected: _selectedIndex == 5,
              onTap: () {
                // Update the state of the app
                _onItemTapped(5);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Skills'),
              selected: _selectedIndex == 6,
              onTap: () {
                // Update the state of the app
                _onItemTapped(6);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Articles'),
              selected: _selectedIndex == 7,
              onTap: () {
                _onItemTapped(7);
                Navigator.pop(context);
              }
            ),
            ListTile(
              title: const Text('Create Article'),
              selected: _selectedIndex == 8,
              onTap: () {
                _onItemTapped(8);
                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
    );
  }
}

///  The model for our app level items
 
class AppModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  
    bool _loggedIn = false;

  /// An unmodifiable view of the items in the cart.
  // UnmodifiableListView<String> get items => UnmodifiableListView(_items);

  /// Current loggedIn State
  bool get loggedIn => _loggedIn;

  /// Change loggedIn state
  void setLogin(bool loggedIn) {
    _loggedIn = loggedIn;
    notifyListeners();
  }

  /// Log Out
  void logOut() {
    _loggedIn = false;
    notifyListeners();
  }
}
