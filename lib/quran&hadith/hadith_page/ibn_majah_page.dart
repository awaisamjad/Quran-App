import 'package:flutter/material.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';

class IbnMajahPage extends StatelessWidget {
  Collection hadith = getCollection(Collections.ibnmajah);
  HadithData x = getHadithDataByNumber(Collections.bukhari, '1', Languages.en);

  // String lang = x.getLang();
  // String chapterNumber = x['chapterNumber'];
  // String chapterTitle = x['chapterTitle'];
  // String urn = x['urn'];
  // String body = x['body'];
  // List<Map<String, dynamic>> grades =
  //     List<Map<String, dynamic>>.from(x['grades']);

  @override
  Widget build(BuildContext context) {
    print(x);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ibn Majah Page'),
      ),
      body: Center(
        child: Text('Ibn Majah Page'),
      ),
    );
  }
}
