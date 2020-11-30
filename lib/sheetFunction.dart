//음자리표 그려주는 함수
import 'package:flutter/material.dart';
import 'package:flutter_midi_example/model/madi.dart';
import 'package:flutter_midi_example/noteParser.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

