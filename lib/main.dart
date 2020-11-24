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
      Note(pitch: 60, leng: 1000),
      Note(pitch: 62, leng: 2000),
      Note(pitch: 64, leng: 1000),

      Note(pitch: 65, leng: 4000),


    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("악보선택")),
        body: createSong(
            9,
            Song(
                id: 0,
                notes: song[4],
                rhythmUnder: 4,
                rhythmUpper: 4,
                tempo: 120,
                title: "나비야"),
            context));
  }
}

//한줄에 허용할 음표 갯수 정하고 거기에 맞게 마디 만들고 create 마디 해주기
ListView createSong(int maxNotesInLine, Song song, BuildContext context) {
  //한마디에 총 허용되는 노트(1000 = 4분음표 1개)
  var maxOfMadi = 4000 * song.rhythmUpper / song.rhythmUnder;
  List<Madi> madiList = [];
  madiList.add(Madi(
      isRhythmShown: false,
      endType: 0,
      clef: 0,
      scale: 0,
      rhythmUnder: song.rhythmUnder,
      rhythmUpper: song.rhythmUpper,
      notes: []));

  // 1. 노래를 마디 리스트화
  int nowMadiLength = 0;
  song.notes.forEach((note) {
    if (nowMadiLength + note.leng <= maxOfMadi) {
      madiList.last.notes.add(note);
      nowMadiLength = nowMadiLength + note.leng;
    } else {
      madiList.add(Madi(
          isRhythmShown: false,
          endType: 0,
          clef: 0,
          scale: 0,
          rhythmUnder: song.rhythmUnder,
          rhythmUpper: song.rhythmUpper,
          notes: []));
      madiList.last.notes.add(note);
      nowMadiLength = note.leng;
    }
  });

  List<Row> rows = [];
  var deviceWidth = MediaQuery.of(context).size.width;

  // 줄별로 마디 분배
  int nowNoteCnt = 0;
  int madiCount = 0;
  var tempMadisList = [];
  var temp = [];
  madiList.forEach((madi) {
    nowNoteCnt = nowNoteCnt + madi.getNotesCount();
    print(nowNoteCnt);
    if (nowNoteCnt < maxNotesInLine) {
      temp.add(madi);
      madiCount++;
      if(madiCount == madiList.length){
        tempMadisList.add(temp);
        nowNoteCnt = 0;
      }
    }
    else if (nowNoteCnt >= maxNotesInLine) {
      temp.add(madi);
      madiCount++;
      tempMadisList.add(temp);
      nowNoteCnt = 0;
      temp=[];
    }

  });

  // 줄별로 분배된 마디를 위젯으로 만들고 Row에 삽입
  tempMadisList.forEach((madis) {
    int cnt = madis.length;
    List<Widget> temRowItem = [];
    var w = deviceWidth;
    for (int i = 0; i < cnt; i++) {
      double widthSize = 0;
      if (i == 0) {
        madis[i].clef = 1;
        madis[i].isRhythmShown = true;
        if (cnt > 1) {
          widthSize = deviceWidth / cnt * 1.1;
          w = w - widthSize;
        }
      } else if (i == cnt - 1) {
        madis[i].endType = 2;
        widthSize = w / (cnt - 1);
      } else {
        widthSize = w / (cnt - 1);
      }
      temRowItem.add(createMadi(madis[i], deviceWidth / cnt));
    }
    rows.add(Row(
      children: temRowItem,
    ));
  });

  // 2. 마디 리스트 아이템의 노트 갯수와 한줄에 허용되는 노트의 갯수와 맞게 Row List화
  ListView listView = ListView(
    children: rows,
  );

  // 3. 컨테이너 return
  return listView;
}

class Madi {
  bool isRhythmShown; //  곡시작여부(박자표)
  int endType; // 0 일반, 1  도돌이표, 2, :곡끝
  int clef; // 1 : 높은음자리표 -1 : 낮은음자리표 0 : 없음
  int scale; // 0 : CMajor 0~7 : #갯수 -1~-7 : b갯수
  int rhythmUnder;
  int rhythmUpper;
  List<Note> notes;
  Madi(
      {@required this.isRhythmShown,
      @required this.endType,
      @required this.clef,
      @required this.scale,
      @required this.rhythmUnder,
      @required this.rhythmUpper,
      @required this.notes});
  int getNotesCount() {
    int size = 0;
    notes.forEach((note) {
      size = size + 1;
    });
    return size;
  }

  int getNotesTotalSize() {
    int size = 0;
    notes.forEach((note) {
      size = size + note.leng;
    });
    return size;
  }
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
  double widgetHeight = 70; // 디바이스의 크기가져와서 계산 or 고정

  double startPosition = madiWidth * 0.08;
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
  if (madi.clef != 0) {
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

  if (madi.rhythmUnder == 8) {}

  // 음표삽입
  var nowPosition = startPosition;
  // var interval = (endPosition - startPosition) / 4;
  //박자에 따라 간격 설정
  var interval = madi.rhythmUnder == 4
      ? (endPosition - startPosition) / madi.rhythmUpper
      : (endPosition - startPosition) / madi.rhythmUpper * madi.rhythmUnder / 4;
  madi.notes.forEach((note) {
    widgets.add(Positioned(
      bottom: widgetHeight * pitchParser(note.pitch),
      left: nowPosition,
      child: SvgPicture.asset(
        note.pitch < 71
            ? note.pitch != 60
                ? "assets/note${note.leng}.svg"
                : "assets/note${note.leng}_c.svg"
            : note.pitch != 60
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
