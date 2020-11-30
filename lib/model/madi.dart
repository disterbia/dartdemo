import 'package:flutter/cupertino.dart';
import 'package:flutter_midi_example/model/song.dart';

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
