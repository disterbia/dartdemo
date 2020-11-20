import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_midi_example/temp.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_midi_example/noteParser.dart';

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
      Note(pitch: 67, leng: 1000),
      Note(pitch: 67, leng: 2000),
      Note(pitch: 67, leng: 1000),
      Note(pitch: 65, leng: 1000),
      Note(pitch: 62, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 1000),
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
      Note(pitch: 60, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 54, leng: 20),
      Note(pitch: 54, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 60, leng: 20),
      Note(pitch: 54, leng: 20),
      Note(pitch: 21, leng: 20),
      Note(pitch: 27, leng: 40),
      Note(pitch: 54, leng: 20),
      Note(pitch: 47, leng: 20),
      Note(pitch: 47, leng: 20),
      Note(pitch: 54, leng: 20),
      Note(pitch: 60, leng: 20),
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
    4: [
      Note(pitch: 60, leng: 20),
      Note(pitch: 62, leng: 20),
      Note(pitch: 64, leng: 40),
      Note(pitch: 65, leng: 40),
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
                onPressed: () => Navigator.pushNamed(context, "mainPage",
                    arguments: Song(
                        id: 0,
                        title: "나비야",
                        notes: song[0],
                        rhythmUnder: 4,
                        rhythmUpper: 4,
                        tempo: 120))),
            RaisedButton(
                child: Text("비행기"),
                onPressed: () => Navigator.pushNamed(context, "mainPage",
                    arguments: Song(
                        id: 1,
                        title: "비행기",
                        notes: song[1],
                        rhythmUnder: 4,
                        rhythmUpper: 4,
                        tempo: 120))),
            RaisedButton(
                child: Text("쉽지않아"),
                onPressed: () => Navigator.pushNamed(context, "mainPage",
                    arguments: Song(
                        id: 2,
                        title: "쉽지않아",
                        notes: song[2],
                        rhythmUnder: 8,
                        rhythmUpper: 6,
                        tempo: 120))),
            createMadi(
                Madi(
                    isRhythmShown: true,
                    isClefShown: true,
                    endType: 0,
                    clef: 0,
                    notes: [
                      Note(pitch: 60, leng: 1000),
                      Note(pitch: 64, leng: 1000),
                      Note(pitch: 67, leng: 500),
                      Note(pitch: 69, leng: 500),
                      Note(pitch: 67, leng: 500),
                      Note(pitch: 67, leng: 500),
                    ],
                    scale: 0,
                    rhythmUnder: 4,
                    rhythmUpper: 4),
                200),
          ],
        ));
  }
}

class Madi {
  bool isClefShown; //줄시작여부에 따라 음자리표 그려줄거임
  bool isRhythmShown; //  곡시작여부(박자표)
  int endType; // 0 일반, 1  도돌이표, 2, :곡끝
  int clef; // 1 : 높은음자리표 -1 : 낮은음자리표 0 : 없음
  int scale; // 0 : CMajor 0~7 : #갯수 -1~-7 : b갯수
  int rhythmUnder;
  int rhythmUpper;
  List<Note> notes;
  Madi(
      {@required this.isClefShown,
      @required this.isRhythmShown,
      @required this.endType,
      @required this.clef,
      @required this.scale,
      @required this.rhythmUnder,
      @required this.rhythmUpper,
      @required this.notes});
}

//음자리표 그려주는 함수
Widget drawClef(bool isTreble, widgetHeight) {
  return Positioned(
    child: SvgPicture.asset(
      isTreble ? "assets/start.svg" : "assets/start.svg",
      height: widgetHeight * 0.7,
    ),
    height: widgetHeight,
    left: widgetHeight / 15,
  );
}

//박자표 그려주는 함수
List<Widget> drawRhythem(int upper, int under, double widgetHeight) {
  List<Widget> list = [];
  list.add(Positioned(
      child: Text(
        upper.toString(),
        style: TextStyle(fontSize: widgetHeight / 2.9),
      ),
      left: widgetHeight / 2.5,
      top: widgetHeight / 5.7));
  list.add(Positioned(
      child: Text(
        under.toString(),
        style: TextStyle(fontSize: widgetHeight / 2.9),
      ),
      left: widgetHeight / 2.5,
      top: widgetHeight / 2.35));
  return list;
}

//마디 끝 라인 그려주는 함수
// 0 일반, 1  도돌이표, 2, :곡끝
List<Widget> drawEndLine(double widgetHeight, double widgetWidth, int type) {
  List<Widget> list = [];
  int endLineWidth = type == 0 ? 1 : 2;
  list.add(Positioned(
    child: Container(
      width: widgetHeight * 0.015 * endLineWidth,
      color: Colors.black,
    ),
    height: widgetHeight * 0.51,
    top: widgetHeight * 0.243,
    right: 0,
  ));
  if (type == 2) {
    list.add(Positioned(
      child: Container(
        width: widgetHeight * 0.015,
        color: Colors.black,
      ),
      height: widgetHeight * 0.51,
      top: widgetHeight * 0.243,
      right: widgetHeight * 0.08,
    ));
  }
  return list;
}

Widget createMadi(Madi madi, double madiWidth) {
  List<Widget> widgets = [];
  double widgetHeight = 80; // 디바이스의 크기가져와서 계산 or 고정
  double startPosition = madiWidth * 0.05;
  double endPosition = madiWidth * 0.95;

  //기본 오선보 삽입
  widgets.add(Container(
    width: madiWidth,
    height: widgetHeight,
    child: SvgPicture.asset(
      "assets/base2.svg",
      fit: BoxFit.fill,
    ),
  ));

  // 마디끝 삽입
  drawEndLine(widgetHeight, madiWidth, madi.endType).forEach((wg) {
    widgets.add(wg);
  });

  // 음자리표 삽입
  if (madi.isClefShown) {
    widgets.add(drawClef(true, widgetHeight));
    widgets.add(drawClef(true, widgetHeight));
    startPosition = startPosition + widgetHeight / 4;
  }
  //박자표삽입
  if (madi.isRhythmShown) {
    drawRhythem(madi.rhythmUpper, madi.rhythmUnder, widgetHeight).forEach((wg) {
      widgets.add(wg);
    });
    startPosition = startPosition + widgetHeight / 4;
  }

  // 음표삽입
  var nowPosition = startPosition;
  var interval = (endPosition - startPosition) / 4;
  print("$interval $nowPosition");
  madi.notes.forEach((note) {
    widgets.add(Positioned(
      bottom: widgetHeight * pitchParser(note.pitch),
      left: nowPosition,
      child: SvgPicture.asset(
        madi.notes[0].pitch < 71
            ? madi.notes[0].pitch != 60
                ? "assets/note${note.leng}.svg"
                : "assets/note${note.leng}_c.svg"
            : madi.notes[0].pitch != 60
                ? "assets/note${note.leng}_2.svg"
                : "assets/note${note.leng}_2c.svg",
        color: Colors.black,
        height: note.leng == 4000 ? widgetHeight / 10 : widgetHeight / 2,
      ),
    ));
    nowPosition = nowPosition + note.leng / 1000 * interval;
  });

  return Stack(
    children: widgets,
  );
}
