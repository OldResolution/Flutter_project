class Task {
  String id;
  String title;
  String category;
  bool isCompleted;
  int pomodoroCount; // Number of Pomodoro sessions completed

  Task({
    required this.id,
    required this.title,
    this.category = 'General',
    this.isCompleted = false,
    this.pomodoroCount = 0,
  });
}
