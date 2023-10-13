// ignore_for_file: must_be_immutable
import 'package:Quran/quran&hadith/quran_page/quran_page_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);
var quranTextStyle = TextStyle(
    color: Colors.black, fontFamily: 'Amiri', fontSize: 28);

class SurahPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromARGB(255, 45, 99, 54),
      child: Scrollbar(
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
            Color buttonColour = Color.fromARGB(255, 165, 214, 175);

            Widget revelationIcon;
            if (placeOfRevelation == "Makkah") {
              revelationIcon = Image.asset(
                'assets/images/makkah.png',
                width: 22,
                height: 22,
              );
            } else if (placeOfRevelation == "Madinah") {
              revelationIcon = Image.asset(
                'assets/images/madinah.png',
                width: 30,
                height: 30,
              );
            } else {
              revelationIcon = Icon(Icons.location_on); // Use a default icon
            }

            return Padding(
              padding: const EdgeInsets.all(1.5),
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
                  title: Row(
                    children: [
                      Text(
                        surahNumber.toString(),
                        style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize:
                                20, // Increase font size to 20 for SurahName
                            fontWeight:
                                FontWeight.w600, // Set desired font weight
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ), // Add a space between the surah number and the surah name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              surahName,
                              style: GoogleFonts.mukta(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      20, // Increase font size to 20 for SurahName
                                  fontWeight: FontWeight
                                      .w600, // Set desired font weight
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            revelationIcon,
                          ]),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '$surahNameEnglish   $verseCount', // Display verse count at the bottom left
                              style: GoogleFonts.mukta(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    surahNameArabic,
                    style: TextStyle(
                      fontFamily:
                          'Al Qalam Quran Majeed', // Apply the desired font family
                      fontSize: 30,
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
    ));
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

  bool isWrapMode = false; // Set this based on your toggle logic

  @override
  Widget build(BuildContext context) {
    final int verseCount = quran.getVerseCount(int.parse(surahNumber));
    int fontSize = 1;
    return Scaffold(
      endDrawer:  QuranPageNavigationDrawer(onFontSizeChanged: (value) {
        fontSize = value.toInt();
        quranTextStyle.copyWith(fontSize: fontSize.toDouble());
        // print(fontSize);
      }),
      
      appBar: AppBar(
        title: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: surahNameArabic,
                  style: quranTextStyle, // Arabic style
                ),
                TextSpan(
                  text: '   ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: surahNameEnglish,
                  style: GoogleFonts.mukta(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ), // English style
                ),
              ],
            ),
          ),
        ),
        backgroundColor: appBarBackgroundColour,
      ),
      body: Scrollbar(
        
        thickness: 20,
        interactive: true,
        child: isWrapMode
            ? Wrap(
                //crossAxisAlignment: WrapCrossAlignment.end,
                //direction: Axis.horizontal,
                //spacing: 1.0,
                //runSpacing: 1.0,
                textDirection: TextDirection.rtl,
                children: List.generate(verseCount, (index) {
                  final int verseNumber = index + 1;
                  return Container(
                    padding: EdgeInsets.all(0),
                    //constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
                    child: Text(
                      quran.getVerse(
                        int.parse(surahNumber),
                        verseNumber,
                        verseEndSymbol: true,
                      ),
                      style: quranTextStyle,
                      textAlign: TextAlign.right,
                    ),
                  );
                }),
              )
            : ListView.builder(
                itemCount: verseCount,
                itemBuilder: (context, index) {
                  final int verseNumber = index + 1;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 21.0, 12.0, 2.0),
                    child: Column(
                      children: [
                        // Arabic Text
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            quran.getVerse(
                              int.parse(surahNumber),
                              verseNumber,
                              verseEndSymbol: true,
                            ),
                            style: quranTextStyle,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(height: 20),
                        // English Translation Text
                        Align(
                          alignment: Alignment.topLeft,
                          child:
                        Text(
                          quran.getVerseTranslation(
                            int.parse(surahNumber),
                            verseNumber,
                            translation: quran.Translation.enSaheeh,
                          ),
                          style: TextStyle(
                              fontSize:10),
                          textAlign: TextAlign.left, // Align English translation to the left
                        ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
