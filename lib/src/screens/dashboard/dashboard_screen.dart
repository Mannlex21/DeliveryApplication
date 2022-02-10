import 'package:delivery_application/src/components/home/drawer_widget.dart';
import 'package:delivery_application/src/screens/home/home_screen.dart';
import 'package:delivery_application/src/screens/search/search_screen.dart';
import 'package:delivery_application/src/screens/settings/setting_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List _widgetOptions = [
      const HomeScreen(),
      SearchScreen(context, false),
      const Text(
        'Index 2: School',
      ),
      const SettingScreen(),
    ];

    return Consumer(
      builder: (context, tokenInfo, _) => Scaffold(
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
          // backgroundColor: const Color(0xFFF9F9F9),
          type: BottomNavigationBarType.fixed,
          elevation: 4,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
