import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

class HizbPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thickness: 20,
        interactive: true,
        child: ListView.builder(
          itemCount: quran.totalJuzCount ~/ 2, // Total Hizb count (Half of total Juz count)
          itemBuilder: (context, index) {
            final hizbNumber = index + 1;
            final surahAndVerses = quran.getSurahAndVersesFromJuz(hizbNumber * 2 - 1); // Surah and verses from 1st half of Juz
            final surahNumber = surahAndVerses.keys.first;
            final surahNameEnglish = quran.getSurahNameEnglish(surahNumber);
            final surahNameArabic = quran.getSurahNameArabic(surahNumber);
            final verseCount = quran.getVerseCountByPage(hizbNumber * 4); // Total verses in the first half of the juz
            final verseEnd = verseCount ~/ 2; // End verse for the current hizb

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
                      builder: (context) => HizbDetailsPage(
                        surahNumber: surahNumber.toString(),
                        surahAndVerses: surahAndVerses,
                        surahNameArabic: surahNameArabic,
                        surahNameEnglish: surahNameEnglish,
                        verseEnd: verseEnd,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    'Hizb $hizbNumber',
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

class HizbDetailsPage extends StatelessWidget {
  final Map<int, List<int>> surahAndVerses;
  final String surahNameEnglish;
  final String surahNameArabic;
  final String surahNumber;
  final int verseEnd;
  HizbDetailsPage({
    required this.surahAndVerses,
    required this.surahNameEnglish,
    required this.surahNameArabic,
    required this.surahNumber,
    required this.verseEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hizb Details'),
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
                              color: Colors.black, fontSize: 34,fontFamily: 'KFGQPC Uthmanic Script HAFS Regular', height: 1.5),
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
