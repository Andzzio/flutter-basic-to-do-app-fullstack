import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onDelete;
  final ValueChanged<bool>? onChanged;
  const TaskItem({
    super.key,
    required this.task,
    this.onDelete,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 3)),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: task.completed,
            onChanged: (value) {
              onChanged?.call(value!);
            },
          ),
          Text(task.title),
          Spacer(),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
