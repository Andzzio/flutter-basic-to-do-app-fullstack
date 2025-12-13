import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final VoidCallback? onDelete;
  const TaskItem({super.key, required this.task, this.onDelete});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
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
            value: widget.task.completed,
            onChanged: (value) {
              setState(() {
                widget.task.completed = value!;
              });
            },
          ),
          Text(widget.task.title),
          Spacer(),
          IconButton(
            onPressed: widget.onDelete,
            icon: Icon(Icons.delete, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
