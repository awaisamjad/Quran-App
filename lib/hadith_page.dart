import 'package:flutter/material.dart';
import 'package:hadith/bukhari/books.dart';
import 'package:hadith/collections.dart';
import 'package:hadith/hadith.dart' as hadith;

final Color appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);


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
      appBar: AppBar(
        title: Text('Quran'),
        backgroundColor: appBarBackgroundColour,
      ),
      body: Row(
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
                    MaterialPageRoute(
                      builder: (context) => HadithPageDetails(

                      ),
                    ),
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
                  onPressed: () {},
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
                  onPressed: () {},
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
                  onPressed: () {},
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
                  onPressed: () {},
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
                  onPressed: () {},
                  child: Text('Ibn Majah'),
                ),
                spacingBtwnBoxes,
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class HadithPageDetails extends StatelessWidget {
  HadithPageDetails();

  final collections = hadith.getCollections();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Bukhari'),
      ),
      body: Text(
        'hello'
      ),
    );
  }
}
