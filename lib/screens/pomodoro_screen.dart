import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../task_provider.dart';

class PomodoroScreen extends StatefulWidget {
  final Task task;

  PomodoroScreen({required this.task});

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer(TaskProvider provider) {
    provider.startTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (provider.pomodoroTime > 0) {
        provider.updateTimer(provider.pomodoroTime - 1);
      } else {
        provider.incrementPomodoro(widget.task.id);
        provider.resetTimer();
        _timer?.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pomodoro Completed! Take a 5-min break.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.task.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(provider.pomodoroTime ~/ 60).toString().padLeft(2, '0')}:${(provider.pomodoroTime % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: provider.isTimerRunning
                      ? null
                      : () => startTimer(provider),
                  child: Text('Start'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: provider.isTimerRunning
                      ? () {
                          provider.pauseTimer();
                          _timer?.cancel();
                        }
                      : null,
                  child: Text('Pause'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    provider.resetTimer();
                    _timer?.cancel();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
