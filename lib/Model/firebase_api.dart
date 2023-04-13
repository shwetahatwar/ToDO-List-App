import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_makeing_app/Model/todo.dart';

class FirebaseApi {
  static Future<String> createTodo(MyTodos todo) async {
    final docTodo = FirebaseFirestore.instance.collection('MyTodos').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Future updateTodo(MyTodos todo) async {
    final docTodo = FirebaseFirestore.instance.collection('MyTodos').doc(todo.title);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(MyTodos todo) async {
    final docTodo = FirebaseFirestore.instance.collection('MyTodos').doc(todo.id);

    await docTodo.delete();
  }
}