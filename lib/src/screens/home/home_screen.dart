import 'package:delivery_application/src/components/home/drawer_widget.dart';
import 'package:delivery_application/src/components/home/home_wiget.dart';
import 'package:delivery_application/src/screens/search/search_screen.dart';
import 'package:delivery_application/src/screens/settings/setting_screen.dart';

import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List _widgetOptions = [
      const HomeWidget(),
      SearchScreen(context, false),
      const Text(
        'Index 2: School',
      ),
      SettingScreen(context),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: const MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        backgroundColor: const Color(0xFFF9F9F9),
        type: BottomNavigationBarType.fixed,
        elevation: 4,
        onTap: _onItemTapped,
      ),
    );
  }
}
