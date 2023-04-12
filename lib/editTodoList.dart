import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_makeing_app/todoFromWidget.dart';
import 'Model/todo.dart';
import 'Provider/todoProvider.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({required this.todo}) : super();

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late String time;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
    time = widget.todo.time;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Edit Todo'),
      backgroundColor: Colors.blue.shade900,
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            final provider =
            Provider.of<TodosProvider>(context, listen: false);
            provider.removeTodo(widget.todo);

            Navigator.of(context).pop();
          },
        )
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: TodoFormWidget(
          title: title,
          description: description,
          date: time,
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
          onChangedDate: (date) => setState(() => this.time = time),
          onSavedTodo: saveTodo,
        ),
      ),
    ),
  );

  void saveTodo() {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description,time);

      Navigator.of(context).pop();
    }
  }
}