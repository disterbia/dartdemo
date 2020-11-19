import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_midi_example/noteParser.dart';
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
    if (isFirst) {
      int madiNotes;
      if (song.rhythmUpper == 3 && song.rhythmUnder == 4) {
        madiNotes = 3000;
      } else if (song.rhythmUpper == 4 && song.rhythmUnder == 4) {
        madiNotes = 4000;
      } else if (song.rhythmUpper == 6 && song.rhythmUnder == 8) {
        madiNotes = 3000;
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
          if (song.notes.length == list.length) {
            sheet.add(list.sublist(count));
            check.add(score.sublist(count));
          }
        }
      });
      isFirst = false;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Text(song.title, style: TextStyle(fontSize: 20)),
                margin: EdgeInsets.only(top: 40, bottom: 20),
              ),
              flex: 0,
            ),
            Expanded(
              child: ScrollablePositionedList.separated(
                itemScrollController: scrollController,
                itemBuilder: (context, index) {
                  index == 0 ? isStart = 0 : isStart = 1;
                  return madi(
                      sheet.sublist(index * (song.rhythmUpper == 6 ? 3 : 4)),
                      song.rhythmUnder,
                      song.rhythmUpper,
                      song.tempo,
                      check.sublist(index * (song.rhythmUpper == 6 ? 3 : 4)),
                      index);
                },
                itemCount:
                    (sheet.length / (song.rhythmUpper == 6 ? 3 : 4)).ceil(),
                separatorBuilder: (context, index) {
                  return Text("  ");
                },
              ),
            ),
            RaisedButton(
                child: !isRecording ? Text("Go!") : Text("Stop!"),
                onPressed: () async {
                  scrollController.scrollTo(
                      index: 0, duration: Duration(milliseconds: 300));
                  isRecording ? stopRecording() : startRecording();
                })
          ],
        ),
      ),
    );
  }

  Widget madi(List<List<Note>> body, int rhythmUnder, int rhythmUpper,
      int tempo, List<List<int>> scoreCheck, int row) {
    bool isDefault = rhythmUpper == 6 ? false : true;
    var orientation = MediaQuery.of(context).orientation;
    double containerWidth = MediaQuery.of(context).size.width *
        (isDefault
            ? row == 0
                ? 3 / 9
                : 4 / 13
            : row == 0
                ? 3 / 7
                : 4 / 10);
    double containerHeight = MediaQuery.of(context).size.height /
        (orientation == Orientation.portrait ? 12 : 3.5);
    List<Widget> list = List<Widget>();
    list.add(Container(
      width: containerWidth,
      height: containerHeight,
      child: SvgPicture.asset(
        "assets/base2.svg",
        fit: BoxFit.fill,
      ),
    ));
    list.add(Positioned(
      child: SvgPicture.asset(
        "assets/start.svg",
        height: containerHeight * 0.7,
      ),
      height: containerHeight,
    ));
    if (isStart == 0) {
      list.add(Positioned(
          child: Text(
            rhythmUpper.toString(),
            style: TextStyle(fontSize: containerHeight / 2.9),
          ),
          left: containerWidth * 1 / 7,
          top: containerHeight / 5.7));
      list.add(Positioned(
          child: Text(
            rhythmUnder.toString(),
            style: TextStyle(fontSize: containerHeight / 2.9),
          ),
          left: containerWidth * 1 / 7,
          top: containerHeight / 2.35));
    }

    List<Widget> list2 = List<Widget>();
    list2.add(Container(
      width: containerWidth,
      height: containerHeight,
      child: SvgPicture.asset(
        "assets/base2.svg",
        fit: BoxFit.fill,
      ),
    ));

    List<Widget> list3 = List<Widget>();
    list3.add(Container(
      width: containerWidth,
      height: containerHeight,
      child: SvgPicture.asset(
        "assets/base2.svg",
        fit: BoxFit.fill,
      ),
    ));

    List<Widget> list4 = List<Widget>();
    list4.add(Container(
      width: containerWidth,
      height: containerHeight,
      child: SvgPicture.asset(
        "assets/base2.svg",
        fit: BoxFit.fill,
      ),
    ));

    if (body.length > 0) {
      var startPos = containerWidth * 0.6;
      startPos = startPos;
      var endPos = containerWidth * 0.44;
      var nextPos = startPos;
      var interval = (startPos - endPos) / 8;

      for (var i = 0; i < body[0].length; i++) {
        print(
            "test ${startPos} ${endPos} ${(startPos - endPos) / 16} ${nextPos}");
        list.add(Positioned(
          bottom: containerHeight * pitchParser(body[0][i].pitch),
          right: nextPos,
          child: SvgPicture.asset(
            body[0][i].pitch < 71
                ? body[0][i].pitch != 60
                    ? "assets/note${body[0][i].leng}.svg"
                    : "assets/note${body[0][i].leng}_c.svg"
                : body[0][i].pitch != 60
                    ? "assets/note${body[0][i].leng}_2.svg"
                    : "assets/note${body[0][i].leng}_2c.svg",
            color: scoreCheck[0][i] == 0
                ? Colors.black
                : scoreCheck[0][i] == 1
                    ? Colors.orange
                    : scoreCheck[0][i] == 2
                        ? Colors.greenAccent
                        : Colors.red,
            height: body[0][i].leng == 4000
                ? containerHeight / 10
                : containerHeight / 2,
          ),
        ));
        nextPos =
            nextPos - (1 - beatParser(body[0][i].leng) / 2) * interval * 4;
      }
    }
    if (body.length > 1) {
      double pos = containerWidth;
      double beforePos = 0;
      for (var i = 0; i < body[1].length; i++) {
        beforePos = beforePos + beatParser(body[1][i].leng);
        list2.add(Positioned(
          bottom: containerHeight * pitchParser(body[1][i].pitch),
          right: containerWidth * beforePos,
          child: SvgPicture.asset(
            body[1][i].pitch < 71
                ? body[1][i].pitch != 60
                    ? "assets/note${body[1][i].leng}.svg"
                    : "assets/note${body[1][i].leng}_c.svg"
                : body[1][i].pitch != 60
                    ? "assets/note${body[1][i].leng}_2.svg"
                    : "assets/note${body[1][i].leng}_2c.svg",
            color: scoreCheck[1][i] == 0
                ? Colors.black
                : scoreCheck[1][i] == 1
                    ? Colors.orange
                    : scoreCheck[1][i] == 2
                        ? Colors.greenAccent
                        : Colors.red,
            height: body[1][i].leng == 4000
                ? containerHeight / 10
                : containerHeight / 2,
          ),
        ));
      }
    }

    if (body.length > 2) {
      for (var i = 0; i < body[2].length; i++) {
        list3.add(Positioned(
          bottom: containerHeight * pitchParser(body[2][i].pitch),
          right: containerWidth * beatParser(body[2][i].leng),
          child: SvgPicture.asset(
            body[2][i].pitch < 71
                ? body[2][i].pitch != 60
                    ? "assets/note${body[2][i].leng}.svg"
                    : "assets/note${body[2][i].leng}_c.svg"
                : body[2][i].pitch != 60
                    ? "assets/note${body[2][i].leng}_2.svg"
                    : "assets/note${body[2][i].leng}_2c.svg",
            color: scoreCheck[2][i] == 0
                ? Colors.black
                : scoreCheck[2][i] == 1
                    ? Colors.orange
                    : scoreCheck[2][i] == 2
                        ? Colors.greenAccent
                        : Colors.red,
            height: body[2][i].leng == 4000
                ? containerHeight / 10
                : containerHeight / 2,
          ),
        ));
      }
    }

    if (body.length > 3) {
      for (var i = 0; i < body[3].length; i++) {
        list4.add(Positioned(
          bottom: containerHeight * pitchParser(body[3][i].pitch),
          right: containerWidth * beatParser(body[3][i].leng),
          child: SvgPicture.asset(
            body[3][i].pitch < 71
                ? body[3][i].pitch != 60
                    ? "assets/note${body[3][i].leng}.svg"
                    : "assets/note${body[3][i].leng}_c.svg"
                : body[3][i].pitch != 60
                    ? "assets/note${body[3][i].leng}_2.svg"
                    : "assets/note${body[3][i].leng}_2c.svg",
            color: scoreCheck[3][i] == 0
                ? Colors.black
                : scoreCheck[3][i] == 1
                    ? Colors.orange
                    : scoreCheck[3][i] == 2
                        ? Colors.greenAccent
                        : Colors.red,
            height: body[3][i].leng == 4000
                ? containerHeight / 10
                : containerHeight / 2,
          ),
        ));
      }
    }

    if (isDefault) {
      return IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: list,
              ),
              flex: row == 0 ? 3 : 4,
            ),
            Container(
              width: containerWidth * 0.005,
              height: containerHeight / 1.97,
              color: Colors.black,
            ),
            Expanded(
              child: Stack(
                children: list2,
              ),
              flex: row == 0 ? 2 : 3,
            ),
            Container(
              width: containerWidth * 0.005,
              height: containerHeight / 1.97,
              color: Colors.black,
            ),
            Expanded(
              child: Stack(children: list3),
              flex: row == 0 ? 2 : 3,
            ),
            Container(
              width: containerWidth * 0.005,
              height: containerHeight / 1.97,
              color: Colors.black,
            ),
            Expanded(
              child: Stack(children: list4),
              flex: row == 0 ? 2 : 3,
            ),
            Container(
              width: containerWidth * 0.005,
              height: containerHeight / 1.97,
              color: Colors.black,
            ),
            Text(" "),
          ],
        ),
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: list,
              ),
              flex: row == 0 ? 3 : 4,
            ),
            Container(
              width: containerWidth * 0.005,
              height: containerHeight / 1.97,
              color: Colors.black,
            ),
            Expanded(
              child: Stack(
                children: list2,
              ),
              flex: row == 0 ? 2 : 3,
            ),
            Container(
              width: containerWidth * 0.005,
              height: containerHeight / 1.97,
              color: Colors.black,
            ),
            Expanded(
              child: Stack(children: list3),
              flex: row == 0 ? 2 : 3,
            ),
            Container(
              width: containerWidth * 0.005,
              height: containerHeight / 1.97,
              color: Colors.black,
            ),
            Text(" "),
          ],
        ),
      );
    }
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
