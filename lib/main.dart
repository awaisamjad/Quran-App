import 'package:Quran/quran&hadith/hadith_page/bukhari_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dhikr_dua/dhikr_dua_page.dart';
import 'signup-login/log_in_page.dart';
import 'splash_screen.dart';
import 'firebase_options.dart';
import 'test_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(child: LogInPage())
    );
  }
}

