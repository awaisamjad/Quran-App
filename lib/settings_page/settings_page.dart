// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:Quran/settings_page/about_page.dart';
import 'package:Quran/settings_page/account_page.dart';
import 'package:Quran/settings_page/general_settings_page.dart';
import 'package:Quran/settings_page/help_support_page.dart';
import 'package:Quran/settings_page/notifications_page.dart';
import 'package:Quran/settings_page/privacy_security_page.dart';

double buttonSpace = 20;

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  Widget customElevatedButton({
    required VoidCallback onPressed,
    required String buttonText,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(300, 70),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 185, 228, 198),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountPage()),
                  );
                },
                buttonText: "Account",
              ),
              SizedBox(height: buttonSpace),
              customElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GeneralSettingsPage()),
                  );
                },
                buttonText: "General Settings",
              ),
              SizedBox(height: buttonSpace),
              customElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsPage()),
                  );
                },
                buttonText: "Notifications",
              ),
              SizedBox(height: buttonSpace),
              customElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacySecurityPage()),
                  );
                },
                buttonText: "Privacy and Security",
              ),
              SizedBox(height: buttonSpace),
              customElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpSupportPage()),
                  );
                },
                buttonText: "Help and Support",
              ),
              SizedBox(height: buttonSpace),
              customElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                buttonText: "About",
              ),
            ],
          ),
        ));
  }
}
