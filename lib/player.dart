import 'package:flutter/material.dart';
import 'package:flutter_midi_example/model/song.dart';
import 'package:flutter_sequencer/sequence.dart';
import 'package:flutter_sequencer/instrument.dart';
import 'package:dart_midi/dart_midi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sequencer/track.dart';

Song midiToSong(String path) {
  int ticksPerBit = 480;
  int nowBPM = 120;
  List<MidiNote> recorderMelodyArr = [];
  int recorderLineIndex = -1;
  bool isRhythmSet = false;
  bool isBpmSet = false;
  Song song = Song(
      id: 0,
      title: "Untitled",
      tempo: 120,
      notes: [],
      rhythmUnder: 4,
      rhythmUpper: 4);

  try {
    rootBundle.load(path).then((value) {
      var parsedMidi = MidiParser().parseMidiFromBuffer(
          value.buffer.asUint8List(value.offsetInBytes, value.lengthInBytes));
      List<Instrument> instruments = [];

      var parsedMidiTracks = parsedMidi.tracks;
      int parsedMidiTracksCnt = parsedMidiTracks.length;

      /*
       * 미디분석 (트랙 갯수, 트랙악기명)
       */
      for (int i = 0; i < parsedMidiTracksCnt; i++) {
        Sf2Instrument sf2Inst = null;
        parsedMidiTracks[i].forEach((midiEvent) {
          if (midiEvent is TrackNameEvent) {
            String instName = (midiEvent as TrackNameEvent).text;
            if (instName.toLowerCase().contains("recorder")) {
              recorderLineIndex = i;
              sf2Inst =
                  Sf2Instrument(path: "assets/sf2/Recorder.sf2", isAsset: true);
            }
          } else if (midiEvent is TimeSignatureEvent && !isRhythmSet) {
            TimeSignatureEvent tem = midiEvent;
            song.rhythmUpper = tem.numerator;
            song.rhythmUnder = tem.denominator;
          } else if (midiEvent is SetTempoEvent && !isBpmSet) {
            SetTempoEvent tem = midiEvent;
            song.tempo = (60000000 / tem.microsecondsPerBeat).round();
          }

          // ppp1 pp4 p1 GrandPiano
          if (sf2Inst == null) {
            sf2Inst = Sf2Instrument(path: "assets/sf2/ppp1.sf2", isAsset: true);
          }
        });
        instruments.add(sf2Inst);
      }

      /*
       * 틱스퍼비트
       */
      ticksPerBit = parsedMidi.header.ticksPerBeat;

      /*
         * 파싱된 미디를 분석 후 플레이어 트랙으로 만듦
         */
      int trackIndex = 0;
      parsedMidiTracks.forEach((midiTrack) {
        List<int> pitchs = [];
        List<double> startPositions = [];
        List<int> velocitys = [];
        List<double> durations = [];

        double pos = 0;
        int originPos = 0;

        midiTrack.forEach((element) {
          if (element is SetTempoEvent ||
              element is ControllerEvent ||
              element is NoteOnEvent ||
              element is NoteOffEvent) {
            originPos = originPos + element.deltaTime;
            pos = pos + (element.deltaTime * (120 / nowBPM));
          }

          if (element is NoteOnEvent) {
            pitchs.add(element.noteNumber);
            velocitys.add(element.velocity);
            startPositions.add(pos);
          }
          if (element is NoteOffEvent) {
            double tem = element.deltaTime == 0
                ? durations[durations.length - 1]
                : element.deltaTime * (120 / nowBPM);
            durations.add(tem);
          }
        });

        if (pitchs.length > 0) {
          int index = pitchs.length;
          for (var i = 0; i < index; i++) {
            if (trackIndex == recorderLineIndex) {
              recorderMelodyArr.add(MidiNote(
                  pitch: pitchs[i],
                  startPosition: startPositions[i] / ticksPerBit * 1000,
                  dulation: ((durations[i] / ticksPerBit) * 100).ceil() * 10));
            }
          }
        }

        trackIndex++;
      });

      song.notes =
          midiNoteToNote(recorderMelodyArr, song.rhythmUpper, song.rhythmUnder);
    });
    return song;
  } catch (e) {
    print("fuck");
  }
}

class MidiPlayer {
  static final MidiPlayer _midiPlayer = MidiPlayer._internal();
  Sequence sequence;

  factory MidiPlayer() {
    return _midiPlayer;
  }

  MidiPlayer._internal() {
    sequence = Sequence(tempo: 120, endBeat: 100);
    print("Sequence Init!!!");
  }
}

Sequence midiInit(String path, Song song, void toDo()) {
  Sequence seq = MidiPlayer().sequence;
  int endBeat = 100;
  int ticksPerBit = 480;
  int nowBPM = 120;
  List<MidiNote> recorderMelodyArr = [];
  int recorderLineIndex = -1;
  bool isRhythmSet = false;
  bool isBpmSet = false;
  if (!(seq.getTracks().isEmpty)) {
    List<Track> tracks = seq.getTracks();

    tracks.removeRange(0, tracks.length - 1);
  }

  try {
    rootBundle.load(path).then((value) {
      var parsedMidi = MidiParser().parseMidiFromBuffer(
          value.buffer.asUint8List(value.offsetInBytes, value.lengthInBytes));
      List<Instrument> instruments = [];

      var parsedMidiTracks = parsedMidi.tracks;
      int parsedMidiTracksCnt = parsedMidiTracks.length;

      /*
       * 미디분석 (트랙 갯수, 트랙악기명)
       */
      for (int i = 0; i < parsedMidiTracksCnt; i++) {
        Sf2Instrument sf2Inst = null;
        parsedMidiTracks[i].forEach((midiEvent) {
          if (midiEvent is TrackNameEvent) {
            String instName = (midiEvent as TrackNameEvent).text;
            if (instName.toLowerCase().contains("recorder")) {
              recorderLineIndex = i;
              sf2Inst =
                  Sf2Instrument(path: "assets/sf2/Recorder.sf2", isAsset: true);
            }
          } else if (midiEvent is TimeSignatureEvent && !isRhythmSet) {
            TimeSignatureEvent tem = midiEvent;
            song.rhythmUpper = tem.numerator;
            song.rhythmUnder = tem.denominator;
          } else if (midiEvent is SetTempoEvent && !isBpmSet) {
            SetTempoEvent tem = midiEvent;
            song.tempo = (60000000 / tem.microsecondsPerBeat).round();
          }

          // ppp1 pp4 p1 GrandPiano
          if (sf2Inst == null) {
            sf2Inst = Sf2Instrument(path: "assets/sf2/ppp1.sf2", isAsset: true);
          }
        });
        instruments.add(sf2Inst);
      }

      /*
       * 틱스퍼비트
       */
      ticksPerBit = parsedMidi.header.ticksPerBeat;

      /*
       * 앱 내 플레이어(시퀀서) 트랙만들기 시작
       */
      seq.createTracks(instruments).then((realTracks) {
        int trackIndex = 0;

        /*
         * 파싱된 미디를 분석 후 플레이어 트랙으로 만듦
         */
        parsedMidiTracks.forEach((midiTrack) {
          List<int> pitchs = [];
          List<double> startPositions = [];
          List<int> velocitys = [];
          List<double> durations = [];

          double pos = 0;
          int originPos = 0;

          // 20201201 수정됨(SetTempoEvent 추가 - 도돌이표에서 제대로 인식 안돼서)
          midiTrack.forEach((element) {
            if (element is SetTempoEvent ||
                element is ControllerEvent ||
                element is NoteOnEvent ||
                element is NoteOffEvent) {
              originPos = originPos + element.deltaTime;
              pos = pos + (element.deltaTime * (120 / nowBPM));
            }

            if (element is NoteOnEvent) {
              pitchs.add(element.noteNumber);
              velocitys.add(element.velocity);
              startPositions.add(pos);
            }

            if (element is NoteOffEvent) {
              double tem = element.deltaTime == 0
                  ? durations[durations.length - 1]
                  : element.deltaTime * (120 / nowBPM);
              durations.add(tem);
            }
          });

          if (pitchs.length > 0) {
            int index = pitchs.length;
            for (var i = 0; i < index; i++) {
              realTracks[trackIndex].addNote(
                  noteNumber: trackIndex == recorderLineIndex
                      ? pitchs[i] - 12
                      : pitchs[i],
                  velocity: (velocitys[i] / 100) > 1 ? 1 : velocitys[i] / 100,
                  startBeat: startPositions[i] / ticksPerBit,
                  durationBeats: trackIndex == recorderLineIndex
                      ? durations[i] / ticksPerBit
                      : durations[i] / ticksPerBit * 1.5);
              if (trackIndex == recorderLineIndex) {
                recorderMelodyArr.add(MidiNote(
                    pitch: pitchs[i],
                    startPosition: startPositions[i] / ticksPerBit * 1000,
                    dulation:
                        ((durations[i] / ticksPerBit) * 100).ceil() * 10));
              }
            }
          }

          //반주만 - 2 :0 동시에 - 3 :0.25
          if (trackIndex != recorderLineIndex) {
            realTracks[trackIndex].addVolumeChange(volume: 3, beat: 0);
          } else {
            realTracks[trackIndex].addVolumeChange(volume: 0.25, beat: 0);
          }

          //EndBeat 처리
          if (durations.length > 0) {
            int lastDuration =
                ((durations.last / ticksPerBit) * 100).ceil() * 10;
            double lastPosition = startPositions.last / ticksPerBit * 1000;
            int nowEndBeat =
                ((lastDuration + lastPosition + 1001) / 1000).ceil();
            if (nowEndBeat > endBeat) {
              endBeat = nowEndBeat;
            }
          }
          trackIndex++;
        });
        seq.setEndBeat(endBeat.toDouble());

        song.notes = midiNoteToNote(
            recorderMelodyArr, song.rhythmUpper, song.rhythmUnder);

        toDo();
      });
    });
  } catch (e) {
    print("fuck");
  }
}

List<Note> midiNoteToNote(
    List<MidiNote> midiNote, int rhythmUpper, int rhythmUnder) {
  List<Note> notes = [];
  int maxLengthOfMadi = (4000 / rhythmUnder).round();
  int nowMadiLength = 0; //쉽표쪼개기용 1000|0111 일때 쉼표 4000으로 인식 안되게...
  maxLengthOfMadi *= rhythmUpper;
  int position = 0;
  midiNote.forEach((note) {
    // print("${note.pitch} ${note.startPosition} ${position}");
    // print("${nowMadiLength} ${note.dulation}");
    if (position == note.startPosition) {
      notes.add(Note(leng: note.dulation, pitch: note.pitch, state: 0));
      position = note.dulation + note.startPosition.toInt();
      nowMadiLength = nowMadiLength + note.dulation >= maxLengthOfMadi
          ? 0
          : nowMadiLength + note.dulation;
    } else {
      //쉼표처리
      List<int> restNotes = [4000, 3000, 2000, 1500, 1000, 750, 500, 375, 250];
      int restLength = note.startPosition.toInt() - position;

      restNotes.forEach((nowRest) {
        if (maxLengthOfMadi >= nowRest &&
            nowMadiLength + nowRest <= maxLengthOfMadi) {
          int cnt = (restLength / nowRest).floor();
          if (cnt > 0) {
            restLength -= nowRest * cnt;
            for (int i = 0; i < cnt; i++) {
              notes.add(Note(leng: nowRest, pitch: -1, state: 0));
              nowMadiLength = nowMadiLength + nowRest >= maxLengthOfMadi
                  ? 0
                  : nowMadiLength + nowRest;
            }
          }
        }
      });

      //쉼표 후 노트삽입
      notes.add(Note(leng: note.dulation, pitch: note.pitch, state: 0));
      position = note.dulation + note.startPosition.toInt();
      nowMadiLength = nowMadiLength + note.dulation >= maxLengthOfMadi
          ? 0
          : nowMadiLength + note.dulation;
    }
  });
  return notes;
}

void test(List<Note> notes) {
  int maxLengthOfMadi = 4000;

  List<int> restNotes = [4000, 3000, 2000, 1500, 1000, 750, 500, 375, 250];
  int restLength = 7750;

  restNotes.forEach((nowRest) {
    if (maxLengthOfMadi >= nowRest) {
      int cnt = (restLength / nowRest).floor();
      if (cnt > 0) {
        restLength -= nowRest * cnt;
        for (int i = 0; i < cnt; i++) {
          notes.add(Note(leng: nowRest, pitch: -1, state: 0));
        }
      }
    }
  });
}

/*
 * 미디파일 파싱중 쓰는 노트객체
 */

class MidiNote {
  int pitch;
  double startPosition;
  int dulation = 0; // 400 온음표 / 200 2분음표 / 100 4분음표 / 50 8분음표 / 25 16분음표

  MidiNote({this.pitch, this.startPosition, this.dulation});
}
