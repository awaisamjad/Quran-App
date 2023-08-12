import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:camera/camera.dart';

final appBarBackgroundColour = Color.fromARGB(255, 130, 186, 130);

class RecitationPage extends StatefulWidget {
  @override
  RecitationPageState createState() => RecitationPageState();
}

class RecitationPageState extends State<RecitationPage> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  // Audio
  bool audioIsRecording = false;
  String audioPath = '';

  // Camera / Video
  bool _videoIsLoading = true;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    audioRecord = Record();
    audioPlayer = AudioPlayer();
    listenForRecitations();
    _initCamera();
  }

  Future<void> audioUploadRecording() async {
    if (audioPath.isNotEmpty) {
      // Get a reference to the Firebase Storage bucket
      var storageRef = firebase_storage.FirebaseStorage.instance.ref();

      // Set the path for the audio file in Firebase Storage
      var audioRef = storageRef
          .child('audio/${DateTime.now().millisecondsSinceEpoch}.mp3');

      // Create a File object from the recorded audio path
      var audioFile = File(audioPath);

      try {
        // Upload the audio file to Firebase Storage
        await audioRef.putFile(audioFile);

        // Get the download URL for the uploaded audio
        String downloadURL = await audioRef.getDownloadURL();

        // Now you can save the downloadURL to the Firebase Realtime Database or Firestore,
        // associating it with the user who recorded the audio or any other relevant data.
        // For example:
        DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
        databaseReference.child('recitations').push().set({
          'url': downloadURL,
          'user': 'user_id_here',
          'timestamp': DateTime.now().toIso8601String(),
        });

        // Show a success message or navigate to another screen if needed.
        print('Audio uploaded successfully: $downloadURL');
      } catch (e) {
        // Handle errors here
        print('Error uploading audio: $e');
      }
    } else {
      print('No audio recorded.');
    }
  }

  void listenForRecitations() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('recitations').onChildAdded.listen((event) {
      // New recitation added
      if (event.snapshot.value != null) {
        var recitationMap = event.snapshot.value as Map<String, dynamic>;
        var recitation = Recitation.fromJson(recitationMap);
        // You can do something with the recitation data here
        print('New recitation added: $recitation');
      }
    });
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> audioStartRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          audioIsRecording = true;
        });
      }
    } catch (e) {
      print('Error in Start Recording: $e');
    }
  }

  Future<void> audioStopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        audioIsRecording = false;
        audioPath = path!;
      });

      // Perform the recording and upload process in the background
      await Future.delayed(Duration(
          milliseconds: 100)); // Add a small delay to let the UI update
      await audioUploadRecording();
    } catch (e) {
      print('Error in Stopping Recording: $e');
    }
  }

  Future<void> audioPlayRecording() async {
    try {
      Source urlsource = UrlSource(audioPath);
      await audioPlayer.play(urlsource);
    } catch (e) {
      print('Error playing Recording: $e');
    }
  }

  Future<void> saveRecitationToFirebase() async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      String userId =
          ''; // Get the current user's ID (you can use FirebaseAuth or any other authentication method)
      Recitation recitation = Recitation(
        userId: userId,
        recitationUrl: audioPath,
        timestamp: DateTime.now(),
      );
      await databaseReference
          .child('recitations')
          .push()
          .set(recitation.toJson());
    } catch (e) {
      print('Error saving recitation to Firebase: $e');
    }
  }

  // Init Camera
  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _videoIsLoading = false);
  }

  bool _isAudioOnlyMode = true;

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Recitations"),
      backgroundColor: appBarBackgroundColour,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: !_isAudioOnlyMode
                ? _videoIsLoading
                    ? Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : CameraPreview(_cameraController)
                : SizedBox(), // If audio only mode, make it take no space
          ),
          SizedBox(height: 25),
          if (audioIsRecording) Text('Recording in Progress'),
          ElevatedButton(
            onPressed: audioIsRecording ? audioStopRecording : audioStartRecording,
            child: audioIsRecording
                ? const Text('Stop Recording')
                : const Text('Start Recording'),
          ),
          SizedBox(height: 25),
          if (!audioIsRecording && !_isAudioOnlyMode)
            ElevatedButton(
              onPressed: audioPlayRecording,
              child: Text('Play Recording'),
            ),
          ToggleButtons(
            isSelected: [_isAudioOnlyMode, !_isAudioOnlyMode],
            onPressed: (index) {
              setState(() {
                _isAudioOnlyMode = index == 0;
              });
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Audio Only'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Video with Audio'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}

class Recitation {
  String userId;
  String recitationUrl;
  DateTime timestamp;

  Recitation({
    required this.userId,
    required this.recitationUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'recitationUrl': recitationUrl,
      'timestamp': timestamp.toUtc().toIso8601String(),
    };
  }

  factory Recitation.fromJson(Map<String, dynamic> json) {
    return Recitation(
      userId: json['userId'],
      recitationUrl: json['recitationUrl'],
      timestamp: DateTime.parse(json['timestamp']).toLocal(),
    );
  }
}
