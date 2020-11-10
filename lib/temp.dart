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
      0: ["84_12", "84_22"],
      1: ["84_32", "84_42"],
      2: ["84_52"]
    },
    1: {
      0: ["84_12", "84_62"],
      1: ["84_72", "84_82"]
    },
    2:{
      0: ["84_12", "84_62"],
      1: ["84_72", "84_82"]
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
    var target = _song[song.id];
    var title  = song.title;
    print(title);
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

  Widget madi(List<String> body) {

    List<Widget> list = List<Widget>();
    var s=0.0;
    for(var i = 0; i<body.length; i++){
      print(i);
      list.add(Positioned(
        top: int.parse(body[i].substring(0,2)).toDouble(),
        left: i!=0?s+=int.parse(body[i].substring(3,4)).toDouble()+30:s,
        child: SvgPicture.asset(
          "assets/note${body[i].substring(0,1)}.svg",
          color: Colors.deepOrange,
        ),
      ));
    }

    return Container(
      child: Row(
        children: [
          Expanded(
            child: Stack(children: [
              Container(
                width: double.infinity,
                child: SvgPicture.asset(
                  "assets/base.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom:20 ,
                left: s+=40,
                child: SvgPicture.asset(
                  "assets/note8.svg",
                  color: Colors.deepOrange,
                ),
              ),
              Positioned(
                bottom:20,
                left: s+=40,
                child: SvgPicture.asset(
                  "assets/note8.svg",
                  color: Colors.deepOrange,
                ),
              )
            ]),
          ),
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child:
                    SvgPicture.asset("assets/base.svg", fit: BoxFit.fill),
                  ),
                  Positioned(
                    bottom: 14,
                    left: 20,
                    child: SvgPicture.asset(
                      "assets/note8.svg",
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    left: 60,
                    child: SvgPicture.asset(
                      "assets/note4.svg",
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(children: [
              Container(
                width: double.infinity,
                child: SvgPicture.asset("assets/base.svg", fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 27,
                left: 60,
                child: SvgPicture.asset(
                  "assets/note1.svg",
                  width: 21,
                ),
              ),
            ]),
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
