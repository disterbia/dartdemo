import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchdetector/pitchdetector.dart';

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
  List<List<int>> check= [];
  int isFirst = 0;
  Song song;
  bool isDisposed = false;

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
    if(isRecording==true)detector.stopRecording();
  }

  @override
  Widget build(BuildContext context) {
    // if (MediaQuery.of(context).orientation == Orientation.portrait)
    //   return Container();

    var width = MediaQuery.of(context).size.width;
    song = ModalRoute.of(context).settings.arguments;
    if (isFirst == 0) {
      int madiNotes;
      if (song.rhythmUpper == 3 && song.rhythmUnder == 4) {
        madiNotes = 60;
      } else if (song.rhythmUpper == 4 && song.rhythmUnder == 4) {
        madiNotes = 80;
      } else if (song.rhythmUpper == 6 && song.rhythmUnder == 8) {
        madiNotes = 60;
      }

      song.notes.forEach((note) {
        madiCheck += note.leng;
        if (madiCheck <= madiNotes) {
          list.add(note);
          score.add(0);
          if (song.notes.length == list.length) {
            sheet.add(list.sublist(count));
            check.add(score.sublist(count));
          }
        } else {
          sheet.add(list.sublist(count));
          check.add(score.sublist(count));
          count = list.length;
          list.add(note);
          score.add(0);
          madiCheck = note.leng;
        }
      });
      isFirst++;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async{
          print(isRecording);
          isRecording ? stopRecording() : startRecording();
          if (!isDisposed) {
            for(var j = 0;j <check.length;j++){
              for (var i = 0; i < check[j].length; i++){
                await Future.delayed(Duration(seconds: 1),(){
                  if(!isDisposed){
                    setState(() {
                      check[j][i] = 1;
                      print(check[j][i]);
                    });
                  }
                });

              }
            }
          }
        }),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Text(song.title, style: TextStyle(fontSize: 20)),margin: EdgeInsets.only(top: 40,bottom: 20),
              ),
              flex: 0,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  index == 0 ? isStart = 0 : isStart = 1;
                  return madi(sheet.sublist(index * 3), song.rhythmUnder,
                      song.rhythmUpper, song.tempo,check.sublist(index*3));
                },
                itemCount: (sheet.length / 3).ceil(),
                separatorBuilder: (context, index) {
                  return Text("  ");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget madi(
      List<List<Note>> body, int rhythmUnder, int rhythmUpper, int tempo,List<List<int>> scoreCheck) {
    List<Widget> list = List<Widget>();
    list.add(Container(
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/base.svg",
        fit: BoxFit.fill,
      ),
    ));
    list.add(Positioned(
      child: SvgPicture.asset(
        "assets/start.svg",
        height: 70,
      ),
      height: 100,
    ));

    if (isStart == 0) {
      list.add(Positioned(
          child: Text(
            rhythmUpper.toString(),
            style: TextStyle(fontSize: 35),
          ),
          left: 35,
          top: 20));
      list.add(Positioned(
          child: Text(
            rhythmUnder.toString(),
            style: TextStyle(fontSize: 35),
          ),
          left: 35,
          top: 46));
    }

    List<Widget> list2 = List<Widget>();
    list2.add(Container(
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/base.svg",
        fit: BoxFit.fill,
      ),
    ));

    List<Widget> list3 = List<Widget>();
    list3.add(Container(
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/base.svg",
        fit: BoxFit.fill,
      ),
    ));

    var s = 0.0;
    for (var i = 0; i < body[0].length; i++) {
      list.add(Positioned(
        bottom: body[0][i].pitch < 46
            ? body[0][i].pitch.toDouble()
            : body[0][i].pitch.toDouble() - 40,
        left: i != 0
            ? s += body[0][i].leng.toDouble() + 20
            : s = isStart == 0 ? 80 : 60,
        child: SvgPicture.asset(
            body[0][i].pitch < 47
                ? "assets/note${body[0][i].leng}.svg"
                : "assets/note${body[0][i].leng}_2.svg",
            color: scoreCheck[0][i] == 0 ? Colors.black : Colors.orange),
      ));
    }

    if (body.length > 1) {
      var s2 = 0.0;
      for (var i = 0; i < body[1].length; i++) {
        list2.add(Positioned(
          bottom: body[1][i].pitch < 47
              ? body[1][i].pitch.toDouble()
              : body[1][i].pitch.toDouble() - 40,
          left: i != 0 ? s2 += body[1][i].leng.toDouble() + 20 : s2 = 20,
          child: SvgPicture.asset(
              body[1][i].pitch < 47
                  ? "assets/note${body[1][i].leng}.svg"
                  : "assets/note${body[1][i].leng}_2.svg",
              color: scoreCheck[1][i] == 0 ? Colors.black : Colors.orange),
        ));
      }
    }

    if (body.length > 2) {
      var s3 = 30.0;
      for (var i = 0; i < body[2].length; i++) {
        list3.add(Positioned(
          bottom: body[2][i].pitch < 46
              ? body[2][i].pitch.toDouble()
              : body[2][i].pitch.toDouble() - 40,
          left: i != 0 ? s3 += body[2][i].leng.toDouble() + 20 : s3 = 20,
          child: SvgPicture.asset(
              body[2][i].pitch < 46
                  ? "assets/note${body[2][i].leng}.svg"
                  : "assets/note${body[2][i].leng}_2.svg",
              color: scoreCheck[2][i] == 0 ? Colors.black : Colors.orange),
        ));
      }
    }

    return Container(
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: list,
            ),
          ),
          Expanded(
            child: Stack(
              children: list2,
            ),
          ),
          Expanded(
            child: Stack(children: list3),
          ),
          Text(" ")
        ],
      ),
    );
  }

  void startRecording() async {
    await detector.startRecording();
    if (detector.isRecording) {
      setState(() {
        isRecording = true;
      });
    }
  }

  void stopRecording() async {
    detector.stopRecording();
    setState(() {
      isRecording = false;
      pitch = detector.pitch;
    });
  }
}
