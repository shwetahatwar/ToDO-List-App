
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class MyTodos {
  DateTime createdTime;
  String title;
  String id;
  String description;
 String time;
  bool isDone;

  MyTodos({
    required this.createdTime,
    required this.title,
    required this.time,
    this.description = '',
    required this.id,
    this.isDone = false,
  });

  Map<String, Object?> toJson() => {
    'createdTime': createdTime,
    'title': title,
    'time': time,
    'description': description,
    'id': id,
    'isDone': isDone,
  };
}

