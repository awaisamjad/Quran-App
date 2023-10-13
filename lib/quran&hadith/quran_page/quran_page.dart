// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../custom_navigation_drawer.dart';
import '../../signup-login/log_in_page.dart';
import 'surah_page.dart';
import 'juz_page.dart';
import 'page_page.dart';
import 'hizb_page.dart';
import 'package:Quran/quran&hadith/hadith_page/hadith_page.dart';
import 'package:Quran/theme.dart';

class QuranPage extends StatefulWidget {
  const QuranPage();

  @override
  QuranPageState createState() => QuranPageState();
}

class QuranPageState extends State<QuranPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            centerTitle: true,
            title: Text(
              'Quran & Hadith',
              style: GoogleFonts.mukta(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            backgroundColor: AppColours.appBarColour,
            bottom: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
              indicatorColor: Color.fromARGB(255, 199, 214, 204),
              tabs: [
                Tab(text: 'Surah'),
                Tab(text: 'Juz'),
                Tab(text: 'Page'),
                Tab(text: 'Hizb'),
                Tab(
                  text: 'Hadith',
                )
              ],
            ),
          ),
          drawer: CustomNavigationDrawer(),
          
          body: TabBarView(
            controller: _tabController,
            children: [
              SurahPage(),
              JuzPage(),
              PagePage(),
              HizbPage(),
              HadithPage()
            ],
          ),
        ),
      ),
    );
  }
}
