// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list_makeing_app/todoFromWidget.dart';
// import 'Model/todo.dart';
// import 'Provider/todoProvider.dart';
//
// class EditTodoPage extends StatefulWidget {
//   final MyTodos todo;
//
//   const EditTodoPage({required Key key, required this.todo}) : super(key: key);
//
//   @override
//   _EditTodoPageState createState() => _EditTodoPageState();
// }
//
// class _EditTodoPageState extends State<EditTodoPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//   late String title;
//   late String description;
//   late String time;
//   bool isEdit = false;
//
//   @override
//   void initState() {
//     super.initState();
//     final todo = widget.todo;
//
//     title = widget.todo.title;
//     description = widget.todo.description;
//     time = widget.todo.time;
//
//     if(todo != null) {
//       isEdit = true;
//       final title = widget.todo.title;
//       final description = widget.todo.description;
//
//       titleController.text = widget.todo.title;
//       descriptionController.text = widget.todo.description;
//       time = widget.todo.time;
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: Text('Edit Todo'),
//       backgroundColor: Colors.blue.shade900,
//       actions: [
//         IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: () {
//             final provider =
//             Provider.of<TodosProvider>(context, listen: false);
//             provider.removeTodo(widget.todo);
//             Navigator.of(context).pop();
//           },
//         )
//       ],
//     ),
//     body: Padding(
//       padding: EdgeInsets.all(16),
//       child: Form(
//         key: _formKey,
//         child: TodoFormWidget(
//           title: title,
//           description: description,
//           date: time,
//           onChangedTitle: (title) => setState(() => this.title = title),
//           onChangedDescription: (description) =>
//               setState(() => this.description = description),
//           onChangedDate: (date) => setState(() => this.time = time),
//           onSavedTodo: saveTodo,
//         ),
//       ),
//     ),
//   );
//
//   void saveTodo() {
//     final isValid = _formKey.currentState?.validate();
//
//     if (isValid!) {
//       return;
//     } else {
//        final provider = Provider.of<TodosProvider>(context, listen: false);
//
//       provider.updateTodo(widget.todo, title, description,time);
//       Navigator.of(context).pop();
//     }
//   }
//
//
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateTaskAlertDialog extends StatefulWidget {
  final String title, description, time, id;

  const UpdateTaskAlertDialog(
      {Key? Key, required this.title, required this.description, required this.time, required this.id})
      : super(key: Key);

  @override
  State<UpdateTaskAlertDialog> createState() => _UpdateTaskAlertDialogState();
}

class _UpdateTaskAlertDialogState extends State<UpdateTaskAlertDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<String> taskTags = ['a', 'b', 'c','d'];
  String selectedValue = '';


  @override
  Widget build(BuildContext context) {
    titleController.text = widget.title;
    descriptionController.text = widget.description;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  icon: const Icon(CupertinoIcons.square_list, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Row(
              //   children: <Widget>[
              //     const Icon(CupertinoIcons.tag, color: Colors.brown),
              //     const SizedBox(width: 15.0),
              //
              //   ],
              // ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = titleController.text;
            final description = descriptionController.text;
            final time = widget.time;
            final id = widget.id;

           // final time = '';
           // var taskTag = '';
            //selectedValue == '' ? taskTag = widget.taskTag : taskTag = selectedValue;
            _updateTasks(description,id, time, title);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }

  Future _updateTasks(String title, String description, String time,String id) async {
    var collection = FirebaseFirestore.instance.collection('MyTodos');
    collection
        .doc(widget.title)
        .update({'todoTitle': title, 'todoDesc': description, 'todoTime': time,'todoId': id})
        .then(
          (_) => Fluttertoast.showToast(
          msg: "Task updated successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0),
    )
        .catchError(
          (error) => Fluttertoast.showToast(
          msg: "Failed: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0),
    );
  }
}