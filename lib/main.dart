import 'package:flutter/material.dart';
import 'quran_page.dart';
import 'dhikr_dua_page.dart';
import 'hadith_page.dart';
import 'recitation_page.dart';
import 'settings_page.dart';
import 'test_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    QuranPage(),
    RecitationPage(),
    HadithPage(),
    DhikrDuaPage(),
    SettingsPage(),
    //TestPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 94, 7, 255),
          //selectedLabelStyle: TextStyle(color: Colors.amber), // Customize selected label color
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/quran-icon-png-1.png',
                width: 48,
                height: 48,
              ),
              label: 'Quran',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/recitation.png',
                width: 42,
                height: 42,
              ),
              label: 'Recitations',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/settings.png',
                  width: 38, height: 38),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/settings.png',
                width: 38,
                height: 38,
              ),
              label: 'Hadith',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/settings.png',
                width: 38,
                height: 38,
              ),
              label: 'Dhikr & Dua',
            ),
          ],
        ),
      ),
    );
  }
}
