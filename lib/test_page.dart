// import 'package:flutter/material.dart';
// import 'package:dzikr/dzikr.dart';

// void main() {
//   runApp(Dzikr());
// }

// class Dzikr extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dzikr',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DzikrPage(),
//     );
//   }
// }

// class DzikrPage extends StatefulWidget {
//   @override
//   _DzikrPageState createState() => _DzikrPageState();
// }

// class _DzikrPageState extends State<DzikrPage> {
//   PrayerTime prayer; // Declare prayer variable

//   @override
//   void initState() {
//     super.initState();
//     // Call the getPrayerTime function to initialize the prayer variable
//     getPrayerTime().then((prayerData) {
//       setState(() {
//         prayer = prayerData;
//       });
//     });
//   }

//   Future<PrayerTime> getPrayerTime() async {
//     try {
//       PrayerTimeTool prayerTimeTool = await PrayerTimeTool.init();
//       PrayerTime prayer = prayerTimeTool.prayer;
//       return prayer;
//     } on DzikrErrorConfig catch (error) {
//       // Handle error
//       print(error.message);
//     }
//     return PrayerTime(monthlySchedule: 3, placeLong: '3', placeLat: '3', placeName: 'london', todaySchedule: 1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dzikr'),
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (prayer != null) ...[
//               Text(
//                 prayer.todaySchedule.closestPrayer.closestPrayer,
//                 style: Theme.of(context).textTheme.headline1,
//               ),
//               Text(
//                 prayer.todaySchedule.closestPrayer.closestTime,
//                 style: Theme.of(context).textTheme.headline2,
//               ),
//               Text(
//                 "${PrayerTimeTool.findClosestPrayerTime(prayer).todaySchedule.closestPrayer.durationToClosestPrayer.inMinutes} Minute to ${prayer.todaySchedule.closestPrayer.closestPrayer}",
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final surahName = quran.getSurahName(1);

  @override
  Widget build(BuildContext context) {
    final verses = quran.getVerse(114, 1); // Get the verses

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300),
            Text(
              verses.length.toString(),
            ),
            Row(
              children: [
                for (int i = verses.length - 1; i >= 0; i--) // Reverse the order of verses
                  Row(
                    children: [
                      for (int j = 0; j < verses[i].length; j++)
                        Text(
                          verses[i][j],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
