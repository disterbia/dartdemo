import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_midi_example/temp.dart';

// import 'web_midi.dart';

// The existing imports
// !! Keep your existing impots here !!

/// main is entry point of Flutter application
void main() {
  return runApp(MaterialApp(
      home: SamplePage(), routes: {"mainPage": (context) => MyApp()}));
}

//도:6레:14미:21파:27솔:34라:40시:47도:54레:64
class SamplePage extends StatelessWidget {
  var song = {
    0: [
      Note(pitch: 34, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 40),

      Note(pitch: 27, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 40),

      Note(pitch: 6, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 27, leng: 20),

      Note(pitch: 34, leng: 20),
      Note(pitch: 34, leng: 20),
      Note(pitch: 34, leng: 40),

      Note(pitch: 34, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),

      Note(pitch: 27, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 40),

      Note(pitch: 6, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 34, leng: 20),
      Note(pitch: 34, leng: 20),

      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 40),

      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 20),

      Note(pitch: 14, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 27, leng: 40),

      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),

      Note(pitch: 21, leng: 20),
      Note(pitch: 27, leng: 20),
      Note(pitch: 34, leng: 40),

      Note(pitch: 34, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 40),

      Note(pitch: 27, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 40),

      Note(pitch: 6, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 34, leng: 20),
      Note(pitch: 34, leng: 20),

      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 40),
    ],
    1: [
      Note(pitch: 21, leng: 40),
      Note(pitch: 14, leng: 10),
      Note(pitch: 6, leng: 10),
      Note(pitch: 14, leng: 20),

      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 40),

      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 40),

      Note(pitch: 21, leng: 20),
      Note(pitch: 34, leng: 20),
      Note(pitch: 34, leng: 40),

      Note(pitch: 21, leng: 40),
      Note(pitch: 14, leng: 10),
      Note(pitch: 6, leng: 10),
      Note(pitch: 14, leng: 20),

      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 40),

      Note(pitch: 14, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 14, leng: 20),

      Note(pitch: 6, leng: 80),
    ],

    2: [
      Note(pitch: 54, leng: 20),
      Note(pitch: 54, leng: 20),
      Note(pitch: 60, leng: 40),

      Note(pitch: 21, leng: 20),
      Note(pitch: 54, leng: 40),
      Note(pitch: 54, leng: 20),

      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 40),

      Note(pitch: 60, leng: 20),
      Note(pitch: 54, leng: 20),
      Note(pitch: 21, leng: 40),

      Note(pitch: 27, leng: 40),
      Note(pitch: 54, leng: 40),

      Note(pitch: 47, leng: 20),
      Note(pitch: 47, leng: 20),
      Note(pitch: 54, leng: 40),

      Note(pitch: 60, leng: 40),
      Note(pitch: 47, leng: 40),
    ],
    3: [
      Note(pitch: 6, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 21, leng: 40),
      Note(pitch: 27, leng: 20),
      Note(pitch: 34, leng: 30),
      Note(pitch: 40, leng: 20),
      Note(pitch: 47, leng: 20),
      Note(pitch: 54, leng: 30),
      Note(pitch: 60, leng: 40),
      Note(pitch: 6, leng: 20),
      Note(pitch: 14, leng: 20),
      Note(pitch: 21, leng: 40),
      Note(pitch: 27, leng: 20),
      Note(pitch: 34, leng: 30),
      Note(pitch: 40, leng: 20),
      Note(pitch: 47, leng: 20),
      Note(pitch: 54, leng: 30),
      Note(pitch: 60, leng: 40),
      Note(pitch: 47, leng: 20),
      Note(pitch: 47, leng: 20),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("악보선택")),
        body: Column(
          children: [
            RaisedButton(
                child: Text("나비야"),
                onPressed: () =>
                    Navigator.pushNamed(context, "mainPage",
                        arguments: Song(id: 0,
                            title: "나비야",
                            notes: song[0],
                            rhythmUnder: 4,
                            rhythmUpper: 4,
                            tempo: 120))),
            RaisedButton(
                child: Text("비행기"),
                onPressed: () =>
                    Navigator.pushNamed(context, "mainPage",
                        arguments: Song(id: 1,
                            title: "비행기",
                            notes: song[1],
                            rhythmUnder: 4,
                            rhythmUpper: 4,
                            tempo: 120))),
            RaisedButton(
                child: Text("쉽지않아"),
                onPressed: () =>
                    Navigator.pushNamed(context, "mainPage",
                        arguments: Song(id: 2,
                            title: "쉽지않아",
                            notes: song[2],
                            rhythmUnder: 4,
                            rhythmUpper: 4,
                            tempo: 120)))
          ],
        ));
  }
}
