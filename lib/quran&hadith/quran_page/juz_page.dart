import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'dart:collection';

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

class JuzPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 45, 99, 54),
        child: Scrollbar(
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
              final juzNameEnglish = juzNames.keys
                  .elementAt(index); // Accessing the English juz name
              final juzNameArabic =
                  juzNames[juzNameEnglish]!; // Accessing the Arabic juz name
              Color buttonColour = Color.fromARGB(255, 165, 214, 175);

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
                          juzNameEnglish: juzNameEnglish,
                          juzNameArabic: juzNameArabic,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Row(children: [
                      Text(
                        juzNumber.toString(),
                        style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(
                          width:
                              10), // Added space between juz number and names
                      Text(juzNameEnglish),
                    ]),
                    trailing: Text(
                      juzNameArabic,
                      style: TextStyle(
                        fontFamily:
                            'KFGQPC Uthmanic Script HAFS Regular', // Apply the desired font family
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class JuzDetailsPage extends StatelessWidget {
  final String juzNameEnglish;
  final String juzNameArabic;
  final Map<int, List<int>> surahAndVerses;
  final String surahNameEnglish;
  final String surahNameArabic;
  final String surahNumber;
  JuzDetailsPage({
    required this.surahAndVerses,
    required this.surahNameEnglish,
    required this.surahNameArabic,
    required this.surahNumber,
    required this.juzNameEnglish,
    required this.juzNameArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$juzNameArabic  $juzNameEnglish'),
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
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: 'KFGQPC Uthmanic Script HAFS Regular',
                              height: 1.5),
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

LinkedHashMap<String, String> juzNames = LinkedHashMap<String, String>.from({
  "Alif-Lam-Mim": "آلم",
  "Sayaqulu": "سَيَقُولُ",
  "Tilka'r-Rusulu": "تِلْكَ ٱلْرُّسُلُ",
  "Lan Tana Lu": "لن تنالوا",
  "Wa'l-muhsanatu": "وَٱلْمُحْصَنَاتُ",
  "La yuhibbu-'llahu": "لَا يُحِبُّ ٱللهُ",
  "Wa 'Idha Sami'u": "وَإِذَا سَمِعُوا",
  "Wa-law annana": "وَلَوْ أَنَّنَا",
  "Qala 'l-mala'u": "قَالَ ٱلْمَلَأُ",
  "Wa-'a'lamu": "وَٱعْلَمُواْ",
  "Ya'tazerun": "يَعْتَذِرُونَ",
  "Wa ma min dabbatin": "وَمَا مِنْ دَآبَّةٍ",
  "Wa ma ubarri'u": "وَمَا أُبَرِّئُ",
  "Alif-Lam-Ra' / Rubama": "رُبَمَا",
  "Subhana 'lladhi": "سُبْحَانَ ٱلَّذِى",
  "Qala 'alam": "قَالَ أَلَمْ",
  "Iqtaraba li'n-nasi": "ٱقْتَرَبَ لِلْنَّاسِ",
  "Qad 'aflaha": "قَدْ أَفْلَحَ",
  "Wa-qala 'lladhina": "وَقَالَ ٱلَّذِينَ",
  "'A'man Khalaqa": "أَمَّنْ خَلَقَ",
  "Otlu ma oohiya": "أُتْلُ مَاأُوْحِیَ",
  "Wa-man yaqnut": "وَمَنْ يَّقْنُتْ",
  "Wa-Mali": "وَمَآ لي",
  "Fa-man 'azlamu": "فَمَنْ أَظْلَمُ",
  "Ilayhi yuraddu": "إِلَيْهِ يُرَدُّ",
  "Ha' Mim": "حم",
  '''Qala fa-ma \nkhatbukum''': 'قَالَ فَمَا خَطْبُكُم',
  "Qad sami'a 'llahu": "قَدْ سَمِعَ ٱللهُ",
  "Tabaraka 'lladhi": "تَبَارَكَ ٱلَّذِى",
  "'Amma": "عَمَّ",
});
