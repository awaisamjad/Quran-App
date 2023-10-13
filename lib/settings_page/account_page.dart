// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../signup-login/log_in_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
        ),
        body: Center(
          child: //~ Sign Out Button
              ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                // Use pushReplacement to clear the navigation stack
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LogInPage()), // Navigate to the log-in page
              );
            },
            child: Text("Sign Out"),
          ),
        ));
  }
}
