import 'package:flutter/material.dart';
import 'surah_page.dart';
import 'juz_page.dart';
import 'page_page.dart';
import 'hizb_page.dart';

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 108, 155, 123),
        appBar: AppBar(
          title: Text('Quran'),
          backgroundColor: appBarBackgroundColour,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Surah'),
              Tab(text: 'Juz'),
              Tab(text: 'Page'),
              Tab(text: 'Hizb'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SurahPage(),
            JuzPage(),
            PagePage(),
            HizbPage(),
          ],
        ),
      ),
    );
  }
}
