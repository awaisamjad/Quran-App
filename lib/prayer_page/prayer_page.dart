import 'package:flutter/material.dart';
import 'package:adhan_dart/adhan_dart.dart';

import '../custom_navigation_drawer.dart';

double latitude = 51.5072; // London's latitude
double longitude = -0.1276; // London's longitude

Coordinates coordinates = Coordinates(latitude, longitude);
DateTime timeRn = DateTime.now();
CalculationParameters params = CalculationMethod.Other();
PrayerTimes prayerTimes =
    PrayerTimes(coordinates, timeRn, params, precision: true);

class PrayerPage extends StatefulWidget {
  const PrayerPage();

  @override
  PrayerPageState createState() => PrayerPageState();
}

class PrayerPageState extends State<PrayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: CustomNavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fajr: ${prayerTimes.fajr!.toLocal()}'),
            Text('Sunrise: ${prayerTimes.sunrise!.toLocal()}'),
            Text('Dhuhr: ${prayerTimes.dhuhr!.toLocal()}'),
            Text('Asr: ${prayerTimes.asr!.toLocal()}'),
            Text('Maghrib: ${prayerTimes.maghrib!.toLocal()}'),
            Text('Isha: ${prayerTimes.isha!.toLocal()}'),
            Text(
                'Tomorrow Fajr: ${prayerTimes.fajr!.toLocal().add(Duration(days: 1))}'),
            Text(
                'Tomorrow Sunrise: ${prayerTimes.sunrise!.toLocal().add(Duration(days: 1))}'),
          ],
        ),
      ),
    );
  }
}
