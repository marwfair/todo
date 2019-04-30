import 'package:flutter/material.dart';
import 'package:to_do/daos/todo_dao.dart';
import 'package:to_do/models/todo_item.dart';
import 'package:to_do/widgets/checkbox.dart';

class ToDoItemCell extends StatefulWidget {
  const ToDoItemCell({this.toDoItem});

  final ToDoItem toDoItem;

  @override
  _ToDoItemCellState createState() => _ToDoItemCellState(toDoItem);
}

class _ToDoItemCellState extends State<ToDoItemCell> {
  _ToDoItemCellState(this.toDoItem);

  final ToDoItem toDoItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.drag_handle),
            Container(width: 20, height: 1),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  toDoItem.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            )),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CheckBox(
                          value: toDoItem.completed,
                          onChanged: (bool newValue) {
                            setState(() {
                              toDoItem.completed = newValue;
                              ToDoDao.saveCompleted(toDoItem);
                            });
                          },
                        ))))
          ],
        ));
  }
}
