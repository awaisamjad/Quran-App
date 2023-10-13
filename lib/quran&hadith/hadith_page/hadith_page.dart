import 'package:Quran/quran&hadith/hadith_page/abu_dawud_page.dart';
import 'package:Quran/quran&hadith/hadith_page/bukhari_page.dart';
import 'package:Quran/quran&hadith/hadith_page/ibn_majah_page.dart';
import 'package:Quran/quran&hadith/hadith_page/muslim_page.dart';
import 'package:Quran/quran&hadith/hadith_page/nasai_page.dart';
import 'package:Quran/quran&hadith/hadith_page/tirmidhi_page.dart';
import 'package:flutter/material.dart';

class HadithPage extends StatelessWidget {
  HadithPage();
  final buttonSize = MaterialStateProperty.all(Size(160, 120));
  final spacingBtwnBoxes = SizedBox(height: 30);
  final spacingFromSides = SizedBox(width: 20);
  final buttonRadius = BorderRadius.circular(12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 108, 155, 123),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  spacingBtwnBoxes,
                  //~~~~~~~~~~~~~~~~ Bukhari ~~~~~~~~~~~~~~~~~~~~
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: buttonSize,
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: buttonRadius)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BukhariPage()),
                      );
                    },
                    child: Text('Bukhari'),
                  ),
                  spacingBtwnBoxes,
                  //~~~~~~~~~~~~~~~~ Muslim ~~~~~~~~~~~~~~~~~~~~
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: buttonSize,
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: buttonRadius)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MuslimPage(),
                        ),
                      );
                    },
                    child: Text('Muslim'),
                  ),
                  spacingBtwnBoxes,
                  //~~~~~~~~~~~~~~~~ Abu Dawud ~~~~~~~~~~~~~~~~~~~~
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: buttonSize,
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: buttonRadius)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AbuDawudPage(),
                        ),
                      );
                    },
                    child: Text('Abu Dawud'),
                  ),
                  spacingBtwnBoxes,
                ],
              ),
            ),
            spacingFromSides,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  spacingBtwnBoxes,
                  //~~~~~~~~~~~~~~~~ Tirmidhi ~~~~~~~~~~~~~~~~~~~~
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: buttonSize,
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: buttonRadius)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TirmidhiPage(),
                        ),
                      );
                    },
                    child: Text('Tirmidhi'),
                  ),
                  spacingBtwnBoxes,
                  //~~~~~~~~~~~~~~~~ Nasai ~~~~~~~~~~~~~~~~~~~~
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: buttonSize,
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: buttonRadius)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NasaiPage(),
                        ),
                      );
                    },
                    child: Text('Nasai'),
                  ),
                  spacingBtwnBoxes,
                  //~~~~~~~~~~~~~~~~ Ibn Majah ~~~~~~~~~~~~~~~~~~~~
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: buttonSize,
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: buttonRadius)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IbnMajahPage(),
                        ),
                      );
                    },
                    child: Text('Ibn Majah'),
                  ),
                  spacingBtwnBoxes,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
