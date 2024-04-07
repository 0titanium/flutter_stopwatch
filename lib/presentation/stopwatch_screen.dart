import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;
  int _time = 0;
  bool _isRunning = false;

  List<String> _labTimes = [];

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(Duration(microseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    _labTimes.clear();
    _time = 0;
  }

  void _recordLabTime(String time) {
    _labTimes.insert(0, '${_labTimes.length+1}등 $_time');
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100;
    String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('StopWatch'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sec',
                style: TextStyle(fontSize: 50),
              ),
              Text(
                '$hundredth ',
              ),
            ],
          ),
          SizedBox(
            width: 100,
            height: 200,
            child: ListView(
              children: [
                Center(child: Text('data')),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: Icon(Icons.refresh),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _clickButton();
                  });
                },
                child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _recordLabTime('$sec.$hundredth');
                  });
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
