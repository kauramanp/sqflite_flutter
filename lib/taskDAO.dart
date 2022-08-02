import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/NotesModel.dart';

import 'DatabaseProvider.dart';

class taskDAO {
  Future<void> inserttask(NotesModel task) async {
    final db = await DatabaseProvider().db;
    await db!.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NotesModel>> tasks() async {
    final db = await DatabaseProvider().db;
    final List<Map<String, dynamic>> maps = await db!.query('task');
    return List.generate(maps.length, (i) {
      return NotesModel(
        id: maps[i]['id'],
        task: maps[i]['task'],
        isCompleted: maps[i]['isCompleted'],
      );
    });
  }

  Future<void> updateTask(NotesModel notesModel) async {
    final db = await DatabaseProvider().db;
    await db!.update(
      'task',
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }

  Future<void> deleteNotes(int id) async {
    final db = await DatabaseProvider().db;

    await db!.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
