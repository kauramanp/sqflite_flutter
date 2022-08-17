import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final _databaseName = "task.db";
  static final DatabaseProvider _databaseProvider = DatabaseProvider();

  static Database? database;
  Future<Database> createDatabase() async {
    var db = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, task TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get db async {
    if (database != null) return database;
    database = await createDatabase();
    return database;
  }
}
