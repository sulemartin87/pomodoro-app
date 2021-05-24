import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';

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
  final double _iconSize = 30;
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
    return '$g : $f';
  }

  double completionPercentage() {
    double f = _start / _initial;
    return 1 - f;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("pomo")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width / 2,
            //   height: MediaQuery.of(context).size.height / 4.5,
            //   child: CircularProgressIndicator(
            //     value: completionPercentage(),
            //     strokeWidth: 15.0,
            //     backgroundColor: Colors.grey,
            //   ),
            // ),
            // Spacer(),
            Padding(padding: EdgeInsets.only(top: 15)),
            Center(
              child: CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width / 1.1,
                // animation: true,
                // animationDuration: 1200,
                lineWidth: 20.0,
                percent: completionPercentage(),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      formatTimer(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
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
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.blue,
                progressColor: Colors.red,
              ),
            ),
            // Expanded(
            //   child: ListView(
            //     children: <Widget>[
            //       CheckboxListTile(
            //         title: const Text('Animate Slowly'),
            //         value: timeDilation != 1.0,
            //         onChanged: (bool value) {
            //           setState(() {
            //             timeDilation = value ? 10.0 : 1.0;
            //           });
            //         },
            //         secondary: const Icon(Icons.hourglass_empty),
            //       )
            //     ],
            //   ),
            // )
            // Spacer(),
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
