import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../screens/pomodoro_screen.dart';
import '../task_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('${task.category} | ${task.pomodoroCount} Pomodoros'),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            Provider.of<TaskProvider>(context, listen: false)
                .toggleTaskCompletion(task.id);
          },
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PomodoroScreen(task: task),
          ),
        ),
      ),
    );
  }
}
