import 'package:flutter/cupertino.dart';
import '../Model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  void updateTodo(Todo todo, String title, String description, String time) {
    todo.title = title;
    todo.description = description;
    todo.time = time;

    notifyListeners();
  }
}