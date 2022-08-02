import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/DatabaseProvider.dart';
import 'package:sqflite_flutter/NotesModel.dart';

import 'taskDAO.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<NotesModel> notesModel = [];
  late DatabaseProvider databaseProvider;
  late taskDAO taskDao;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    databaseProvider = new DatabaseProvider();
    databaseProvider.createDatabase();
    taskDao = new taskDAO();

    getList();
  }

  void getList() async {
    print("in get list");
    notesModel = await taskDao.tasks();
    setState(() {});
    for (int i = 0; i < notesModel.length; i++) {
      print("notes model ${notesModel[i]}");
    }
  }

  Future<void> showAlertDialog(int itemPosition) {
    TextEditingController _task = TextEditingController();
    if (itemPosition > -1) {
      _task.text = notesModel[itemPosition].task;
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Expense'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter task type'),
                TextField(
                  controller: _task,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_task.text.isEmpty) {
                  return;
                }

                if (itemPosition < 0) {
                  var tempExpense = NotesModel(
                      task: _task.text.toString(),
                      isCompleted: 0,
                      id: notesModel.length);
                  taskDao.inserttask(tempExpense);
                } else {
                  var tempExpense = NotesModel(
                      task: _task.text.toString(),
                      isCompleted: 0,
                      id: notesModel[itemPosition].id);
                  taskDao.updateTask(tempExpense);
                  //    expenseModel.removeAt(itemPosition);
                }
                setState(() {});
                getList();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteDialog(int itemPosition) {
    TextEditingController _task = TextEditingController();
    if (itemPosition > -1) {
      _task.text = notesModel[itemPosition].task;
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Expense'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to delete this'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                taskDao.deleteNotes(notesModel[itemPosition].id);
                setState(() {});
                getList();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: notesModel.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(children: [
                Expanded(child: Text(notesModel[index].task)),
                GestureDetector(
                  onTap: (() {
                    showAlertDialog(index);
                  }),
                  child: Icon(Icons.edit),
                ),
                GestureDetector(
                  onTap: (() {
                    showDeleteDialog(index);
                  }),
                  child: Icon(Icons.delete),
                ),
              ]),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog(-1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
