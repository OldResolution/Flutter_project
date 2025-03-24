import 'package:flutter/material.dart';
import 'package:task_pomodoro_app/models/task.dart'; // Adjust import based on location

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  int _pomodoroTime = 25 * 60; // 25 minutes in seconds
  bool _isTimerRunning = false;

  List<Task> get tasks => _tasks;
  int get pomodoroTime => _pomodoroTime;
  bool get isTimerRunning => _isTimerRunning;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void incrementPomodoro(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.pomodoroCount++;
    notifyListeners();
  }

  void startTimer() {
    _isTimerRunning = true;
    notifyListeners();
  }

  void pauseTimer() {
    _isTimerRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    _pomodoroTime = 25 * 60;
    _isTimerRunning = false;
    notifyListeners();
  }

  void updateTimer(int time) {
    _pomodoroTime = time;
    notifyListeners();
  }
}
