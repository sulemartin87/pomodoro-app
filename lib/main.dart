import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatefulWidget {
  State createState() => new _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Timer _timer;
  int _start = 1500;
  int _initial = 1500;
  final double _iconSize = 50;
  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void resetTimer() {
    setState(() {
      if (_timer != null) {
        _timer.cancel();
        _timer = null;
      }
      _start = _initial;
    });
  }

  String formatTimer() {
    var f = _start % 60;
    var g = (_start / 60).floor();
    return '${g} : ${f}';
  }

  double completionPercentage() {
    double f = _start / _initial;
    return f;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("pomo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 4.5,
              child: CircularProgressIndicator(
                value: completionPercentage(),
                strokeWidth: 15.0,
              ),
            ),
            // Spacer(),
            Text(
              formatTimer(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      startTimer();
                    },
                    color: Colors.blue,
                    icon: Icon(Icons.play_arrow),
                    iconSize: _iconSize,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      stopTimer();
                    },
                    color: Colors.red,
                    icon: Icon(Icons.stop),
                    iconSize: _iconSize,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      resetTimer();
                    },
                    iconSize: _iconSize,
                    icon: Icon(Icons.restore),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // backgroundColor: ,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: startTimer,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.play_arrow),
      // ),
    );
  }
}
