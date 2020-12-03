import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_midi_example/player.dart';
import 'package:flutter_midi_example/temp.dart';
import 'package:flutter_sequencer/sequence.dart';

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
  Song temp;

  var song = {
    0: [
      Note(pitch: 67, leng: 4000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 67, leng: 500),
      Note(pitch: 67, leng: 250),
      Note(pitch: 62, leng: 4000),
      Note(pitch: 64, leng: 1500),
      Note(pitch: 65, leng: 3000),
      Note(pitch: 64, leng: 4000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 67, leng: 2000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 2000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 67, leng: 2000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 2000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 2000),
    ],
    2: [
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 4000),
      Note(pitch: 65, leng: 4000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 4000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 65, leng: 4000),
      Note(pitch: 65, leng: 4000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 72, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 72, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 72, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 65, leng: 1000),
    ],
  };

  @override
  Widget build(BuildContext context) {
    //temp = midiToSong("assets/midi/wc_test.mid");
    // return Scaffold(
    //     appBar: AppBar(title: Text("악보선택")),
    //     body: createSong(
    //         8,
    //         Song(
    //             id: 0,
    //             notes: song[4],
    //             rhythmUnder: 4,
    //             rhythmUpper: 4,
    //             tempo: 120,
    //             title: "나비야"),
    //         context));
    return Scaffold(
        appBar: AppBar(title: Text("악보선택")),
        body: Column(
          children: [
            RaisedButton(
                child: Text("나비야"),
                onPressed: () {
                  navi("assets/midi/wc_test.mid", context);
                }),
            RaisedButton(
                child: Text("비행기"),
                onPressed: () => Navigator.pushNamed(context, "mainPage",
                    arguments: midiToSong("assets/midi/wc_test.mid"))),
          ],
        ));
  }

  void navi(String path, BuildContext context) {
    Song song = Song(
        id: 0,
        title: "Untitled",
        tempo: 120,
        notes: [],
        rhythmUnder: 4,
        rhythmUpper: 4);
    midiInit(path, song, () {
      Navigator.pushNamed(context, "mainPage", arguments: song);
    });
  }
}
