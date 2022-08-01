import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/DatabaseProvider.dart';
import 'package:sqflite_flutter/NotesModel.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<NotesModel> expenseModel = [];

  Future<void> showAlertDialog(int itemPosition) {
    TextEditingController _task = TextEditingController();

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
                } else {
                  var tempExpense = NotesModel(0, _task.text.toString(),
                      0, id: null);
                  expenseModel[itemPosition] = tempExpense;
                  DatabaseProvider dbProvider = new DatabaseProvider();
                  DatabaseProvider.

                  //    expenseModel.removeAt(itemPosition);
                }
                setState(() {});
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
