
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
 String time;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    required this.time,
    this.description = '',
    required this.id,
    this.isDone = false,
  });
}