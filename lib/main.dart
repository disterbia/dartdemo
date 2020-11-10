import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_midi_example/model/routeArgument.dart';
import 'package:flutter_midi_example/temp.dart';

// import 'web_midi.dart';

// The existing imports
// !! Keep your existing impots here !!

/// main is entry point of Flutter application
void main() {
  // Desktop platforms aren't a valid platform.
  if (!kIsWeb) _setTargetPlatformForDesktop();
  return runApp(MaterialApp(
      home: SamplePage(), routes: {"mainPage": (context) => MyApp()}));
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text("악보선택")),
          body: Column(
            children: [
              RaisedButton(
                  child: Text("나비야"),
                  onPressed: () => Navigator.pushNamed(context, "mainPage",
                      arguments: RouteArgument(id: 0,title:"나비야"))),
              RaisedButton(
                  child: Text("비행기"),
                  onPressed: () => Navigator.pushNamed(context, "mainPage",
                      arguments: RouteArgument(id: 1,title:"비행기"))),
              RaisedButton(
                  child: Text("쉽지않아"),
                  onPressed: () => Navigator.pushNamed(context, "mainPage",
                      arguments: RouteArgument(id: 2,title:"쉽지않아")))
            ],
          ));
  }
}
