class Task {
  int? id;
  String title;
  bool completed;

  Task({this.id, required this.title, required this.completed});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      completed: json["completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "completed": completed};
  }
}
