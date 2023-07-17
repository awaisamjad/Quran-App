import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RecitationPage extends StatefulWidget {
  @override
  RecitationPageState createState() => RecitationPageState();
}

class RecitationPageState extends State<RecitationPage> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;

  bool isRecording = false;
  String audioPath = '';

  @override
  void initState() {
    super.initState();
    audioRecord = Record();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error in Start Recording: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print('Error in Stopping Recording: $e');
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlsource = UrlSource(audioPath);
      await audioPlayer.play(urlsource);
    } catch (e) {
      print('Error playing Recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          if (isRecording) Text('Recording in Progress'),
          ElevatedButton(
              onPressed: isRecording ? stopRecording : startRecording,
              child: isRecording
                  ? const Text('Stop Recording')
                  : const Text('Start Recording')),
          SizedBox(
            height: 25,
          ),
          if (!isRecording)
            ElevatedButton(
              onPressed: playRecording,
              child: Text('Play Recording'),
            ),
        ])));
  }
}