class ToDoItem {
  int id;
  String title;
  String description;
  int timestamp;
  int sortOrder;
  bool completed;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'description': description,
        'timestamp': timestamp,
        'sort_order': sortOrder,
        'completed': completed
      };

  static ToDoItem fromMap(Map<String, dynamic> map) {
    final ToDoItem toDoItem = ToDoItem();

    toDoItem.id = map['id'] as int;
    toDoItem.title = map['title'] as String;
    toDoItem.description = map['description'] as String;
    toDoItem.timestamp = map['timestamp'] as int;
    toDoItem.sortOrder = map['sort_order'] as int;
    toDoItem.completed = map['completed'] as int == 1;

    return toDoItem;
  }
}
