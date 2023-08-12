import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

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
            // final verseStart = surahAndVerses[surahNumber]![0];
            // final verseEnd = surahAndVerses[surahNumber]![1];

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
                              color: Colors.black, fontSize: 34, fontFamily: 'KFGQPC Uthmanic Script HAFS Regular', height: 1.5),
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
