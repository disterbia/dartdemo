import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int madiCheck = 0;
  int count = 0;
  List<List<Note>> sheet = [];
  List<Note> list = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final Song song = ModalRoute.of(context).settings.arguments;
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
        if (song.notes.length == list.length) sheet.add(list.sublist(count));
      } else {
        sheet.add(list.sublist(count));
        count = list.length;
        list.add(note);
        madiCheck = note.leng;
      }
    });

    var row = 0;
    print(sheet.length);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Recorder"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(song.title, style: TextStyle(fontSize: 20)),
                heightFactor: 2,
              ),
              flex: 0,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return madi(sheet.sublist(index * 3), song.rhythmUnder,
                      song.rhythmUpper, song.tempo);
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
      List<List<Note>> body, int rhythmUnder, int rhythmUpper, int tempo) {
    bool isfirst =true;
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
        left: i != 0 ? s += body[0][i].leng.toDouble() + 20 : s = 60,
        child: SvgPicture.asset(
          body[0][i].pitch < 47
              ? "assets/note${body[0][i].leng}.svg"
              : "assets/note${body[0][i].leng}_2.svg",
          color: Colors.black,
        ),
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
            color: Colors.black,
          ),
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
            color: Colors.black,
          ),
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

  int madiCount(Map<int, List<String>> body) {
    return body.keys.length;
  }
}
