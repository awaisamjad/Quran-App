import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

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
            final placeOfRevelation = quran.getPlaceOfRevelation(surahNumber);
            Color buttonColour = Color.fromARGB(255, 226, 236, 228);

            Widget revelationIcon;
            if (placeOfRevelation == "Makkah") {
              revelationIcon = Image.asset(
                'assets/images/makkah.png',
                width: 42,
                height: 42,
              ); // Use the appropriate icon for Makkah
            } else if (placeOfRevelation == "Madinah") {
              revelationIcon = Image.asset(
                'assets/images/madinah.png',
                width: 42,
                height: 42,
              ); // Use the appropriate icon for Madinah
            } else {
              revelationIcon = Icon(Icons.location_on); // Use a default icon
            }

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
                      builder: (context) => SurahPageDetails(
                        surahNumber: surahNumber.toString(),
                        surahNameEnglish: surahNameEnglish,
                        surahNameArabic: surahNameArabic,
                        verseCount: verseCount.toString(),
                        placeOfRevelation: placeOfRevelation,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: revelationIcon, // Display the appropriate icon
                  title: Text(
                    '$surahName\nVerses: $verseCount\n$surahNameEnglish\n$surahNameArabic\n$placeOfRevelation',
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

class SurahPageDetails extends StatelessWidget {
  final String surahNumber;
  final String surahNameEnglish;
  final String surahNameArabic;
  final String verseCount;
  final String placeOfRevelation;

  SurahPageDetails({
    required this.surahNumber,
    required this.surahNameEnglish,
    required this.surahNameArabic,
    required this.verseCount,
    required this.placeOfRevelation,
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
                  padding: const EdgeInsets.fromLTRB(21.0, 21.0, 21.0, 2.0),
                  child: Text(
                    quran.getVerse(
                      int.parse(surahNumber),
                      verseNumber,
                      verseEndSymbol: true,
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'KFGQPC Uthmanic Script HAFS Regular',
                        fontSize: 24),
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
