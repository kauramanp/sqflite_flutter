class NotesModel {
  final int id;
  final String task;
  final int isCompleted;

  const NotesModel({
    required this.id,
    required this.task,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isCompleted': isCompleted,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, task: $task, isCompleted: $isCompleted}';
  }
}
