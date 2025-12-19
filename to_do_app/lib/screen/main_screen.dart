import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/services/api_service.dart';
import 'package:to_do_app/widgets/field.dart';
import 'package:to_do_app/widgets/task_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                child: FutureBuilder<List<Task>>(
                  future: ApiService.getTasks(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No hay tareas"));
                    }
                    final tasks = snapshot.data!;

                    return ListView.separated(
                      itemCount: tasks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItem(
                          task: tasks[index],
                          onChanged: (value) async {
                            try {
                              tasks[index].completed = value;
                              await ApiService.updateTask(tasks[index]);
                              setState(() {});
                            } catch (e) {
                              debugPrint("Error al actualizar tarea: $e");
                            }
                          },
                          onDelete: () async {
                            try {
                              await ApiService.deleteTask(tasks[index].id!);
                              setState(() {});
                            } catch (e) {
                              debugPrint("Error al borrar tarea: $e");
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTask() async {
    if (mainFieldController.text.isNotEmpty) {
      final newTask = Task(title: mainFieldController.text, completed: false);

      try {
        await ApiService.createTask(newTask);
        mainFieldController.clear();
        setState(() {});
      } catch (e) {
        debugPrint("Error al crear tarea:$e");
      }
    }
    mainFieldFocus.requestFocus();
  }

  @override
  void dispose() {
    mainFieldController.dispose();
    mainFieldFocus.dispose();
    super.dispose();
  }
}
