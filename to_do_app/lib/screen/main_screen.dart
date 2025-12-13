import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/widgets/field.dart';
import 'package:to_do_app/widgets/task_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Task> tasks = [];
  int nextId = 1;
  final TextEditingController mainFieldController = TextEditingController();
  final FocusNode mainFieldFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        toolbarHeight: 75,
        title: Text(
          "To Do App (Andzzio Edition)",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  Field(
                    hintText: "Ingrese una nueva tarea",
                    controller: mainFieldController,
                    focus: mainFieldFocus,
                    onSubmitted: (value) {
                      _addTask();
                    },
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      _addTask();
                    },
                    icon: Icon(Icons.add_circle_rounded, color: Colors.indigo),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: tasks[index],
                      onChanged: (value) {
                        setState(() {
                          tasks[index].completed = value;
                        });
                      },
                      onDelete: () {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: tasks.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTask() {
    setState(() {
      if (mainFieldController.text.isNotEmpty) {
        tasks.add(
          Task(id: nextId++, title: mainFieldController.text, completed: false),
        );
        mainFieldController.clear();
      }
      mainFieldFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    mainFieldController.dispose();
    mainFieldFocus.dispose();
    super.dispose();
  }
}
