import 'package:hive_flutter/hive_flutter.dart';

class ToDoDB {
  List toDoList = [];
  //reference our box
  final _myBox = Hive.box('myBox');

  void createInitialData() {
    toDoList = [];
  }

  void loadData() {
    toDoList = _myBox.get('ToDoList');
  }

  void updateData() {
    _myBox.put('ToDoList', toDoList);
  }
}
