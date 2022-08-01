import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/NotesModel.dart';

import 'DatabaseProvider.dart';

class taskDAO {
  Future<void> inserttask(NotesModel task) async {
    // Get a reference to the database.
    final db = await DatabaseProvider().database;

    // Insert the task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same task is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the task from the tasks table.
  Future<List<NotesModel>> tasks() async {
    // Get a reference to the database.
    final db = await DatabaseProvider().database;

    // Query the table for all The tasks.
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<NotesModel>.
    return List.generate(maps.length, (i) {
      return NotesModel(
        id: maps[i]['id'],
        task: maps[i]['task'],
        isCompleted: maps[i]['isCompleted'],
      );
    });
  }
}
