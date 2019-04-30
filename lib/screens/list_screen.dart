import 'package:flutter/material.dart';

import 'package:to_do/daos/todo_dao.dart';
import 'package:to_do/models/todo_item.dart';
import 'package:to_do/screens/create_item_screen.dart';
import 'package:to_do/widgets/todo_item_cell.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ToDoItem> _items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do'),
      ),
      body: _items != null
          ? Scrollbar(
              child: ReorderableListView(
                onReorder: _onReorder,
                reverse: false,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: _items.map<Widget>(buildListItem).toList(),
              ),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        tooltip: 'Add New Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNewItem() {
    Navigator.push(
            context,
            MaterialPageRoute<Map<dynamic, dynamic>>(
                builder: (BuildContext context) {
                  return CreateItemScreen();
                },
                fullscreenDialog: true))
        .then((dynamic result) {
      _reloadItems();
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final ToDoItem item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      item.sortOrder = newIndex;
      ToDoDao.saveSortOrder(item);
    });
  }

  Widget buildListItem(ToDoItem item) {
    final Widget listTile = Dismissible(
        key: Key(item.id.toString()),
        onDismissed: (DismissDirection direction) {
          ToDoDao.deleteToDoItem(item).then((int result) {
            setState(() {
              _items.remove(item);
            });
          });
        },
        background: Container(color: Colors.red),
        child: ToDoItemCell(toDoItem: item));

    return listTile;
  }

  @override
  void initState() {
    super.initState();

    _reloadItems();
  }

  void _reloadItems() {
    ToDoDao.getToDoItems().then((List<ToDoItem> todoItems) {
      setState(() {
        _items = todoItems;
      });
    });
  }
}
