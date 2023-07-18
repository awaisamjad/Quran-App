import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

final Color appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

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

class SurahPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thickness: 20,
        interactive: true,
        child: ListView.builder(
          itemCount: quran.totalSurahCount,
          itemBuilder: (context, index) {
            final surahNumber = index + 1;
            final surahName = quran.getSurahName(surahNumber);
            final surahNameEnglish = quran.getSurahNameEnglish(surahNumber);
            final surahNameArabic = quran.getSurahNameArabic(surahNumber);
            final verseCount = quran.getVerseCount(surahNumber);
            Color buttonColour = Color.fromARGB(255, 226, 236, 228);

            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: buttonColour,
                  backgroundColor: buttonColour,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahDetailsPage(
                        surahNumber: surahNumber.toString(),
                        surahNameEnglish: surahNameEnglish,
                        surahNameArabic: surahNameArabic,
                        verseCount: verseCount.toString(),
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    '$surahName\nVerses: $verseCount\n$surahNameEnglish\n$surahNameArabic',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SurahDetailsPage extends StatelessWidget {
  final String surahNumber;
  final String surahNameEnglish;
  final String surahNameArabic;
  final String verseCount;

  SurahDetailsPage({
    required this.surahNumber,
    required this.surahNameEnglish,
    required this.surahNameArabic,
    required this.verseCount,
  });

  @override
  Widget build(BuildContext context) {
    final int verseCount = quran.getVerseCount(int.parse(surahNumber));

    return Scaffold(
      appBar: AppBar(
        title: Text('$surahNameArabic - $surahNameEnglish'),
        backgroundColor: appBarBackgroundColour,
      ),
      body: Scrollbar(
        thickness: 20,
        interactive: true,
        child: ListView.builder(
          itemCount: verseCount,
          itemBuilder: (context, index) {
            final int verseNumber = index + 1;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                  child: Text(
                    quran.getVerse(
                      int.parse(surahNumber),
                      verseNumber,
                      verseEndSymbol: true,
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 24),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class JuzPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thickness: 20,
        interactive: true,
        child: ListView.builder(
          itemCount: quran.totalJuzCount,
          itemBuilder: (context, index) {
            final juzNumber = index + 1;
            final surahAndVerses = quran.getSurahAndVersesFromJuz(juzNumber);
            final surahNumber = surahAndVerses.keys.first;
            final surahNameEnglish = quran.getSurahNameEnglish(surahNumber);
            final surahNameArabic = quran.getSurahNameArabic(surahNumber);
            final verseStart = surahAndVerses[surahNumber]![0];
            final verseEnd = surahAndVerses[surahNumber]![1];

            Color buttonColour = Color.fromARGB(255, 0, 236, 228);

            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: buttonColour,
                  backgroundColor: buttonColour,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JuzDetailsPage(
                        surahNumber: surahNumber.toString(),
                        surahAndVerses: surahAndVerses,
                        surahNameArabic: surahNameArabic,
                        surahNameEnglish: surahNameEnglish,

                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    'Juz $juzNumber',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class JuzDetailsPage extends StatelessWidget {
  final Map<int, List<int>> surahAndVerses;
  final String surahNameEnglish;
  final String surahNameArabic;
  final String surahNumber;
  JuzDetailsPage({
    required this.surahAndVerses,
    required this.surahNameEnglish,
    required this.surahNameArabic,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Juz Details'),
          backgroundColor: appBarBackgroundColour,
        ),
        body: Scrollbar(
          thickness: 20,
          interactive: true,
          child: ListView.builder(
            itemCount: surahAndVerses.length,
            itemBuilder: (context, index) {
              final surahNumber = surahAndVerses.keys.elementAt(index);
              final verseStart = surahAndVerses[surahNumber]![0];
              final verseEnd = surahAndVerses[surahNumber]![1];

              return Column(
                children: [
                  ListTile(
                    title: Text(
                      'Surah $surahNumber $surahNameEnglish $surahNameArabic ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: verseEnd - verseStart + 1,
                    itemBuilder: (context, index) {
                      final verseNumber = verseStart + index;
                      return ListTile(
                        title: Text(
                          quran.getVerse(
                            surahNumber,
                            verseNumber,
                            verseEndSymbol: true,
                          ),
                          style: TextStyle(
                              color: Colors.black, fontSize: 34, height: 1.5),
                          textAlign: TextAlign.right,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ));
  }
}

class PagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the PagePage content here
    return Center(
      child: Text('Page Page'),
    );
  }
}

class HizbPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the HizbPage content here
    return Center(
      child: Text('Hizb Page'),
    );
  }
}
