import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_midi_example/noteParser.dart';
import 'package:flutter_midi_example/shit_music.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchdetector/pitchdetector.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'noteParser.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int madiCheck = 0;
  int count = 0;
  List<List<Note>> sheet = [];
  List<Note> list = [];
  int isStart = 0;
  List<int> score = [];
  List<List<int>> check = [];
  bool isFirst = true;
  Song song;
  bool isDisposed = false;
  ItemScrollController scrollController = ItemScrollController();

  Pitchdetector detector;
  bool isRecording = false;
  double pitch;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    detector = Pitchdetector(sampleRate: 44100, sampleSize: 4096);
    isRecording = isRecording;
    detector.onRecorderStateChanged.listen((event) {
      if (!isDisposed) {
        setState(() {
          pitch = event["pitch"];
          print(pitch);
        });
      }
    });
  }

  @override
  void dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
    isDisposed = true;
    if (isRecording == true) detector.stopRecording();
  }

  @override
  Widget build(BuildContext context) {
    // if (MediaQuery.of(context).orientation == Orientation.portrait)
    //   return Container();
    song = ModalRoute.of(context).settings.arguments;

    song.notes.forEach((note) {
      print("${note.leng} ${note.pitch}");
    });
    return Scaffold(
        appBar: AppBar(title: Text("악보선택")),
        body: createSong(8, song, context));
  }

  void startRecording() async {
    await detector.startRecording();
    if (detector.isRecording) {
      setState(() {
        isRecording = true;
      });
    }
    if (!isDisposed) {
      for (var j = 0; j < check.length; j++) {
        if (!isRecording) break;
        for (var i = 0; i < check[j].length; i++) {
          if (!isRecording) break;
          await Future.delayed(Duration(milliseconds: 500), () {
            if (isRecording) {
              if (!isDisposed) {
                setState(() {
                  check[j][i] = 1;
                });
              }
            }
          });
          if (!isDisposed) if ((j + 1) % 4 == 1 && j != 0)
            scrollController.scrollTo(
                index: (j + 1) ~/ 4, duration: Duration(milliseconds: 500));
          await Future.delayed(Duration(milliseconds: 500), () {
            if (!isDisposed) {
              if (isRecording) {
                setState(() {
                  print((pitch ?? 0).ceil());
                  (pitch ?? 0).ceil().toInt() > 300
                      ? check[j][i] = 2
                      : check[j][i] = 3;
                  pitch = 0;
                });
              }
            }
          });
        }
      }
    }
  }

  void stopRecording() async {
    detector.stopRecording();
    setState(() {
      isRecording = false;
      pitch = detector.pitch;
      for (var j = 0; j < check.length; j++) {
        for (var i = 0; i < check[j].length; i++) {
          check[j][i] = 0;
        }
      }
    });
  }
}
