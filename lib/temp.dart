import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_example/model/routeArgument.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _song = {
    0: {
      0: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
      1: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
      2: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
    },
    1: {
      0: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
      1: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
      2: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
    },
    2: {
      0: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
      1: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
      2: [
        ["06_20", "14_20", "21_40"],
        ["27_30", "34_30", "40_40"],
        ["47_40", "54_40", "60_40"]
      ],
    }
  };

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
    final RouteArgument song = ModalRoute.of(context).settings.arguments;
    print(_song[song.id]);
    var target = _song[song.id];
    var title = song.title;
    print(title);
    print(target);
    print(_song.runtimeType);
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
                child: Text(title, style: TextStyle(fontSize: 20)),
                heightFactor: 2,
              ),
              flex: 0,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return madi(target[index]);
                },
                itemCount: target.keys.length,
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

  Widget madi(List<List<String>> body) {
    List<Widget> list = List<Widget>();
    list.add(Container(
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/base.svg",
        fit: BoxFit.fill,
      ),
    ));
    var s = 0.0;
    for (var i = 0; i < body[0].length; i++) {
      print(i);
      list.add(Positioned(
        bottom: int.parse(body[0][i].substring(0, 2)) < 46
            ? int.parse(body[0][i].substring(0, 2)).toDouble()
            : int.parse(body[0][i].substring(0, 2)).toDouble() - 30,
        left: i != 0
            ? s += int.parse(body[0][i].substring(3)).toDouble() + 30
            : s = 20,
        child: SvgPicture.asset(
          int.parse(body[0][i].substring(0, 2)) < 46
              ? "assets/note${body[0][i].substring(3)}.svg"
              : "assets/note${body[0][i].substring(3)}_2.svg",
          color: Colors.deepOrange,
        ),
      ));
    }

    List<Widget> list2 = List<Widget>();
    list2.add(Container(
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/base.svg",
        fit: BoxFit.fill,
      ),
    ));
    var s2 = 0.0;
    for (var i = 0; i < body[1].length; i++) {
      print(i);
      list2.add(Positioned(
        bottom: int.parse(body[1][i].substring(0, 2)) < 46
            ? int.parse(body[1][i].substring(0, 2)).toDouble()
            : int.parse(body[1][i].substring(0, 2)).toDouble() - 30,
        left: i != 0
            ? s2 += int.parse(body[1][i].substring(3)).toDouble() + 30
            : s2 = 20,
        child: SvgPicture.asset(
          int.parse(body[1][i].substring(0, 2)) < 46
              ? "assets/note${body[1][i].substring(3)}.svg"
              : "assets/note${body[1][i].substring(3)}_2.svg",
          color: Colors.deepOrange,
        ),
      ));
    }
    List<Widget> list3 = List<Widget>();
    list3.add(Container(
      width: double.infinity,
      child: SvgPicture.asset(
        "assets/base.svg",
        fit: BoxFit.fill,
      ),
    ));

    var s3 = 30.0;
    for (var i = 0; i < body[2].length; i++) {
      print(i);
      list3.add(Positioned(
        bottom: int.parse(body[2][i].substring(0, 2)) < 46
            ? int.parse(body[2][i].substring(0, 2)).toDouble()
            : int.parse(body[2][i].substring(0, 2)).toDouble() - 33,
        left: i != 0
            ? s3 += int.parse(body[2][i].substring(3)).toDouble() + 30
            : s3,
        child: SvgPicture.asset(
          int.parse(body[2][i].substring(0, 2)) < 46
              ? "assets/note${body[2][i].substring(3)}.svg"
              : "assets/note${body[2][i].substring(3)}_2.svg",
          color: Colors.deepOrange,
        ),
      ));
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
