import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localproject/data/database.dart';
import 'package:localproject/util/dialog_box.dart';
import 'package:localproject/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference hive box
  final _myBox = Hive.box('myBox');
  ToDoDB db = ToDoDB();

  @override
  void initState() {
    if (_myBox.get('ToDoList') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  void deleteTask(int index) {
    db.toDoList.removeAt(index);
    db.updateData();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Center(child: Text('Name Project')),
        elevation: 0,
      ),
      // action button plus
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }

  // create
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();

    db.updateData();
  }
}
