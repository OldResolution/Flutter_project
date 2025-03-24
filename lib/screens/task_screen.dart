import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../task_provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _titleController = TextEditingController();
  String _category = 'General';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            DropdownButton<String>(
              value: _category,
              items: ['General', 'Work', 'Personal', 'Urgent']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final task = Task(
                  id: Uuid().v4(),
                  title: _titleController.text,
                  category: _category,
                );
                Provider.of<TaskProvider>(context, listen: false).addTask(task);
                Navigator.pop(context);
              },
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
