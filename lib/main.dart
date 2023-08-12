import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'signup-login/log_in_page.dart';
import 'splash_screen.dart';
import 'firebase_options.dart';

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
      home: SplashScreen(child: LogInPage()), 
    );
  }
}
