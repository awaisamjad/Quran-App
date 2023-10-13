// ignore_for_file: use_build_context_synchronously

import 'package:Quran/signup-login/log_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: const Text('Navigation Drawer Header'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle navigation to settings
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle navigation to Item 2
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Handle navigation to Item 3
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help and Support'),
            onTap: () {
              // Handle navigation to Item 4
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Rate Us'),
            onTap: () {
              // Handle navigation to Item 5
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {
              // Handle navigation to Item 6
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy and Security'),
            onTap: () {
              // Handle navigation to Item 7
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
