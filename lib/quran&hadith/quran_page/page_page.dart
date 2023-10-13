import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

class PagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thickness: 20,
        interactive: true,
        child: ListView.builder(
          itemCount: quran.totalPagesCount,
          itemBuilder: (context, index) {
            final pageNumber = index + 1;
            final pageSurahs = quran.getSurahPages(pageNumber);
            final pageStartSurah = pageSurahs.first;
            final pageEndSurah = pageSurahs.last;
            final verseCount = quran.getVerseCountByPage(pageNumber);
            Color buttonColour = Color.fromARGB(255, 226, 236, 228);

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: buttonColour,
                  backgroundColor: buttonColour,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageDetailsPage(
                        pageNumber: pageNumber.toString(),
                        pageStartSurah: pageStartSurah.toString(),
                        pageEndSurah: pageEndSurah.toString(),
                        verseCount: verseCount.toString(),
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    'Page $pageNumber\nVerses: $verseCount\nStarts from: $pageStartSurah\nEnds with: $pageEndSurah',
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

class PageDetailsPage extends StatelessWidget {
  final String pageNumber;
  final String pageStartSurah;
  final String pageEndSurah;
  final String verseCount;

  PageDetailsPage({
    required this.pageNumber,
    required this.pageStartSurah,
    required this.pageEndSurah,
    required this.verseCount,
  });

  @override
  Widget build(BuildContext context) {
    final int verseCount = int.parse(this.verseCount);

    return Scaffold(
      appBar: AppBar(
        title: Text('Page $pageNumber'),
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
                  padding: const EdgeInsets.fromLTRB(21.0, 21.0, 21.0, 2.0),
                  child: Text(
                    quran.getVerse(
                      int.parse(pageStartSurah),
                      verseNumber,
                      verseEndSymbol: true,
                    ),
                    style: TextStyle(color: Colors.black,fontFamily: 'KFGQPC Uthmanic Script HAFS Regular', fontSize: 24),
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
