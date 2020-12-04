import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_example/model/madi.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_midi_example/noteParser.dart';
import 'package:flutter_midi_example/player.dart';
import 'package:flutter_midi_example/sheetFunction.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchdetector/pitchdetector.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'noteParser.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<int> check = []; //음표 진행상태, 점수 체크용
  List<int> toScroll = []; //현재 진행중인 row위치 체크용
  List<int> toTempo = []; // 현재 진행중인 음표의 박자 체크용
  List<int> temp = []; //음표 진행상태, 점수 체크용
  int rownum = 1; // row index
  int i = 0;
  bool isFirst = true; // initstate 안에 넣을수 없는 최초실행 확인 여부
  Song song;
  String midiPath;
  bool isDisposed = false; //disopse안에 넣을수 없는 값들을위해  dispose가 되었는지 확인
  ItemScrollController scrollController = ItemScrollController();

  int ckIndex = 0; //음표진행상태 음표 index

  Pitchdetector detector;
  bool isRecording = false;
  double pitch;

  Sequence seq;

  @override
  void initState() {
    seq = MidiPlayer().sequence;
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    detector = Pitchdetector(sampleRate: 44100, sampleSize: 4096);
    isRecording = isRecording;
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
      song.notes.forEach((note) {
        check.add(0);
        temp.add(0);
        toScroll.add(0);
        toTempo.add(note.leng * 60 ~/ song.tempo);
        isFirst = false;
      });
    }

    return Scaffold(
        appBar: AppBar(title: Text("악보선택")),
        body: createSong(8, song, context));
  }

  //pitch detector start
  void startRecording() async {
    await detector.startRecording();

    if (detector.isRecording) {
      setState(() {
        isRecording = true;
      });
    }

    //음표 진행상태 색변경
    if (!isDisposed) {
      seq.stop();
      seq.play();

      detector.onRecorderStateChanged.listen((event) {
        if (!isDisposed) {
            setState(() {
              pitch = event["pitch"];
              var note = pitchScore(song.notes[i==0?0:i-1].pitch);
              var input = (pitch ?? 0).ceil().toInt();
              if(check[i==0?0:i-1]==1)
              input >= note && input <= note + 30 ? temp[i==0?0:i-1] = 2 : temp[i==0?0:i-1] = 3;
              pitch = 0;
            });
        }
      });

      for (i = 0; i < check.length; i++) {
        if (!isRecording) break;
          await Future.delayed(
              Duration(milliseconds:i==0?0:toTempo[i - 1]), () {
            if (isRecording) {
              if (!isDisposed) {
                setState(() {
                  check[i] = 1;
                  if(temp[i==0?0:i-1]==2)
                    check[i==0?0:i-1]=2;
                  else if(temp[i==0?0:i-1]==3)
                    check[i==0?0:i-1] =3;
                });
              }
            }
          });

        // row 하나 끝날떄마다 스크롤
        if (!isDisposed) if (toScroll[i] == 1) {
          scrollController.scrollTo(
              index: rownum, duration: Duration(milliseconds: 500));
          rownum++;
        }
        // 음표 pitch체크 색변경

      }
    }
  }

  void stopRecording() async {
    detector.stopRecording();
    rownum = 1;
    seq.stop();
    setState(() {
      isRecording = false;
      pitch = detector.pitch;
      for (var i = 0; i < check.length; i++) {
        check[i] = 0;
      }
    });
  }

  /*
  * sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet
  * sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet
  * sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet
  * sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet sheet
  * */
  Widget createSong(int maxNotesInLine, Song song, BuildContext context) {
    //한마디에 총 허용되는 노트(1000 = 4분음표 1개)
    var height = MediaQuery.of(context).size.height;
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

    //print(madiList.length);

    // 줄별로 마디 분배
    int nowNoteCnt = 0;
    int madiCount = 0;
    int madiTotalSize = madiList.length;
    var tempMadisList = [];
    var temp = [];
    madiList.forEach((madi) {
      madiCount++;
      // print("$madiCount $nowNoteCnt ${madi.getNotesCount()} ${madiList.length} $maxNotesInLine");
      if (madi.getNotesCount() >= maxNotesInLine) {
        if (temp.length > 0) {
          tempMadisList.add(temp);
          temp = [];
        }
        tempMadisList.add([madi]);
        nowNoteCnt = 0;
      } else {
        if (nowNoteCnt + madi.getNotesCount() > maxNotesInLine) {
          tempMadisList.add(temp);
          temp = [madi];
          nowNoteCnt = madi.getNotesCount();
        } else {
          temp.add(madi);
          nowNoteCnt = nowNoteCnt + madi.getNotesCount();
        }

        if (madiCount == madiTotalSize) {
          tempMadisList.add(temp);
        }
      }
    });

    // 줄별로 분배된 마디를 위젯으로 만들고 Row에 삽입
    int tempCnt = 0;
    int tempMadisListCnt = tempMadisList.length;
    int size = 0;
    toScroll.add(0);
    tempMadisList.forEach((madis) {
      tempCnt++;
      int cnt = madis.length;
      double firstWidth = cnt > 1 ? deviceWidth / cnt * 1.17 : deviceWidth;
      double otherWidth =
          cnt > 1 ? (deviceWidth - firstWidth) / (cnt - 1) : deviceWidth;
      List<Widget> temRowItem = [];
      for (int i = 0; i < cnt; i++) {
        double widthSize = 0;
        if (i == 0) {
          madis[i].clef = 1;
          madis[i].isRhythmShown = true;
          madis[i].endType = cnt == 1 && tempCnt == tempMadisListCnt ? 2 : 0;
          widthSize = cnt == 1 && tempCnt == tempMadisListCnt
              ? firstWidth / maxNotesInLine * madis[i].getNotesCount()
              : firstWidth;
        } else {
          widthSize = otherWidth;
        }
        temRowItem.add(createMadi(madis[i], widthSize));
      }

      rows.add(Row(
        children: temRowItem,
      ));

      //현재 진행중인 row의 위치를 알기위해
      madis.forEach((madi) {
        size += madi.notes.length;
      });
      toScroll[size] = 1;
    });

    // 2. 마디 리스트 아이템의 노트 갯수와 한줄에 허용되는 노트의 갯수와 맞게 Row List화
    var scroll = ScrollablePositionedList.builder(
        itemScrollController: scrollController,
        itemCount: rows.length,
        itemBuilder: (context, index) {
          return rows[index];
        });
    // 3. 컨테이너 return
    return OrientationBuilder(
      builder: (context, orientation) {
        return Column(
          children: [
            Container(
                child: scroll,
                height: orientation == Orientation.landscape
                    ? height * 0.6
                    : height * 0.8),
            Container(
              child: RaisedButton(onPressed: () async {
                scrollController.scrollTo(
                    index: 0, duration: Duration(milliseconds: 300));
                return !isRecording ? startRecording() : stopRecording();
              }),
              height: orientation == Orientation.landscape
                  ? height * 0.1
                  : height * 0.05,
            )
          ],
        );
      },
    );
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
      drawRhythem(madi.rhythmUpper, madi.rhythmUnder, widgetHeight)
          .forEach((wg) {
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
        : (endPosition - startPosition) /
            madi.rhythmUpper *
            madi.rhythmUnder /
            4;

    if (ckIndex == check.length) ckIndex = 0;
    madi.notes.forEach((note) {
      widgets.add(Positioned(
        bottom: widgetHeight *
            pitchParser(note.pitch == -1 && note.leng > 1500 ? -2 : note.pitch),
        left: nowPosition,
        child: SvgPicture.asset(
          note.pitch < 71
              ? note.pitch == -1
                  ? "assets/rest${note.leng}.svg"
                  : note.pitch != 60
                      ? "assets/note${note.leng}.svg"
                      : "assets/note${note.leng}_c.svg"
              : note.pitch != 60
                  ? "assets/note${note.leng}_2.svg"
                  : "assets/note${note.leng}_2c.svg",
          color: check[ckIndex] == 0
              ? Colors.black
              : check[ckIndex] == 1
                  ? Colors.orange
                  : check[ckIndex] == 2
                      ? Colors.greenAccent
                      : Colors.red,
          height: note.pitch != -1
              ? note.leng == 4000
                  ? widgetHeight / 10
                  : widgetHeight / 2
              : note.leng < 500
                  ? widgetHeight / 3
                  : note.leng < 1000
                      ? widgetHeight / 4
                      : note.leng < 2000
                          ? widgetHeight / 3
                          : widgetHeight / 9,
        ),
      ));
      nowPosition = nowPosition + note.leng / 1000 * interval;
      ckIndex++;
    });

    return Stack(
      children: widgets,
    );
  }
}
