import 'package:flutter/material.dart';
import 'quran_page/quran_page.dart';
import 'dhikr_dua_page.dart';
import 'hadith_page.dart';
import 'recitation_page.dart';
import 'settings_page/settings_page.dart';
import 'signup-login/log_in_page.dart';
import 'test_page.dart';

class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    QuranPage(),
    RecitationPage(),
    HadithPage(),
    DhikrDuaPage(),
    SettingsPage(),
    // TestPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Color.fromARGB(255, 80, 155, 102),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black, // Change to black
          unselectedLabelStyle:
              TextStyle(color: Colors.grey), // Unselected text color
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
              icon: Image.asset('assets/images/hadith.png',
                  width: 38, height: 38),
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
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/settings.png',
                width: 38,
                height: 38,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
