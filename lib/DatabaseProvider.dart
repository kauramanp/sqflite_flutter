import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final _databaseName = "task.db";
  static final DatabaseProvider _databaseProvider = DatabaseProvider();

  late Future<Database> database;
  void createDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, task TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }

  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //   _database = await createDatabase();
  //   return _database;
  // }

  // createDatabase() async {
  //   Directory documentDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentDirectory.path, _databaseName);

  //   var database = await openDatabase(path, version: 1, onCreate: initDb);
  //   return database;
  // }

  // Future<void> initDb(Database database, int version) async {
  //   await _database.execute("CREATE TABLE Notes ("
  //       "id INTEGER PRIMARY KEY AUTOINCREMENT, "
  //       "task TEXT, "
  //       "isComplete INTEGER "
  //       ")");
  // }
}
