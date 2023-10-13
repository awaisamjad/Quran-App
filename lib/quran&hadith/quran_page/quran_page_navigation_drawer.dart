import 'package:flutter/material.dart';

class QuranPageNavigationDrawer extends StatefulWidget {

  final ValueChanged<double> onFontSizeChanged;
  const QuranPageNavigationDrawer({Key? key, required this.onFontSizeChanged})
      : super(key: key);

  @override
  _QuranPageNavigationDrawerState createState() =>
      _QuranPageNavigationDrawerState();
}

class _QuranPageNavigationDrawerState extends State<QuranPageNavigationDrawer> {
  double _fontSize = 1.0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: const Text('Modify settings'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Font Size'),
            subtitle: Text('Adjust the font size'),
          ),
          SizedBox(
            child: Slider(
              value: _fontSize,
              min: 1,
              max: 20,
              divisions: 19,
              onChanged: (newValue) {
                setState(() {
                  _fontSize = newValue;
                  widget.onFontSizeChanged(newValue);
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Translation'),
            onTap: () {
              // Handle navigation to Item 2
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Transliteration'),
            onTap: () {
              // Handle navigation to Item 3
            },
          ),
        ],
      ),
    );
  }
}
