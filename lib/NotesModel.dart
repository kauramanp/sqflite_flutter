class NotesModel {
  final int id;
  final String task;
  final int isCompleted;

  //NotesModel(this.task, this.isCompleted);
  // NotesModel(this.id, this.task, this.isCompleted, {required id});
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

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Task{id: $id, task: $task, isCompleted: $isCompleted}';
  }
}
