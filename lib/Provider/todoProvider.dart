import 'package:flutter/cupertino.dart';
import 'package:todo_list_makeing_app/Model/todo.dart';
import '../Model/firebase_api.dart';

class TodosProvider extends ChangeNotifier {
  List<MyTodos> _todos = [];

  List<MyTodos> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<MyTodos> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List<MyTodos> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(MyTodos todo) => FirebaseApi.createTodo(todo);

  void removeTodo(MyTodos todo) => FirebaseApi.deleteTodo(todo);

  bool toggleTodoStatus(MyTodos todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(MyTodos todo, String title, String description, String time) {
    todo.title = title;
    todo.description = description;
    todo.time = time;
    FirebaseApi.updateTodo(todo);
  }
}