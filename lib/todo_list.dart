import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_makeing_app/Model/todo.dart';

import 'editTodoList.dart';

class MyTODOPage extends StatefulWidget {
  const MyTODOPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyTODOPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyTODOPage> {
  final _formKey = GlobalKey<FormState>();

  List todos = List.empty();
  String id = "";
  String title = "";
  String description = "";
  String time = Timestamp(0,1).toDate().toString();
  TextEditingController dateInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todos = ["id","Hello", "Hey There",2023-04-10];
  }

  createToDo() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(title);

    DateTime currentDateTime = DateTime.now();

    Map<String, String> todoList = {
      "todoId": id,
      "todoTitle": title,
      "todoDesc": description,
      "todoTime": time,
    };

    documentReference
        .set(todoList)
        .whenComplete(() => print("Data stored successfully"));
  }

  deleteTodo(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(item);
    documentReference.delete().whenComplete(() => print("deleted successfully"));
  }

  updateEditTodo(MyTodos todo) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc();
    await documentReference.update(todo.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO List"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : ""),

                          subtitle: Column(
                            children: [
                              Text((documentSnapshot != null)
                                  ? ((documentSnapshot["todoDesc"] != null)
                                  ? documentSnapshot["todoDesc"]
                                  : "")
                                  : ""),

                        Text((documentSnapshot != null)
                            ? ((documentSnapshot["todoTime"] != null)
                            ? documentSnapshot["todoTime"]
                            : "")
                            : ""),
                            ],
                          ),
                          //trailing: Text((documentSnapshot != null) ? (documentSnapshot["todoDate"]) : ""),
                          // trailing: IconButton(
                          //   icon: const Icon(Icons.delete),
                          //   color: Colors.red,
                          //   onPressed: () {
                          //     setState(() {
                          //       //todos.removeAt(index);
                          //       deleteTodo((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : "");
                          //     });
                          //   },
                          // ),
                           trailing: PopupMenuButton(
                             onSelected: (value){
                               if(value == 'edit'){
                                    setState(() {
                                      Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => UpdateTaskAlertDialog(title: title, description: description, time: time, id: title)),
                                                );
                                    });
                               }else if(value == 'delete'){
                                    setState(() {
                                      deleteTodo((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : "");
                                    });
                               }
                             },
                             itemBuilder: (context) {
                                return [
                                  PopupMenuItem(child: Text('Edit'),
                                  value: 'edit',),
                                  PopupMenuItem(child: Text('Delete'),
                                  value: 'delete',)
                                ];
                             },
                           )
                          // Wrap(
                          //   spacing: 12, // space between two icons
                          //   children: <Widget>[
                          //     IconButton(icon: const Icon(Icons.delete),
                          //       color: Colors.red,
                          //       onPressed: () {
                          //       setState(() {
                          //         deleteTodo((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : "");
                          //       });
                          //       },),
                          //
                          //     IconButton(icon: const Icon(Icons.edit),
                          //         color: Colors.green,
                          //     onPressed: (){
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(builder: (context) => EditTodoPage(todo: Todo(createdTime: DateTime.now(),title: "",time: "",description: "",id: "",isDone: true))),
                          //       );
                          //     },),
                          //   ],
                          // ),
                        ),
                      ));
                });
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              // builder: (context) => AddTodoDialogWidget(),
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Add Todo"),

                  content: Container(
                    width: 500,
                    height: 300,
                    child: Column(
                      children: [
                        // Text("Title",style: TextStyle(color: Colors.black),textAlign: TextAlign.left,),
                        // TextField(
                        //   onChanged: (String value) {
                        //     title = value;
                        //   },
                        // ),
                        buildTitle(),
                        // Text("Description",style: TextStyle(color: Colors.black),textAlign: TextAlign.left,),
                        // TextField(
                        //   onChanged: (String value) {
                        //     description = value;
                        //   },
                        // ),
                        buildDescription(),
                        // Text("Date",style: TextStyle(color: Colors.black),textAlign: TextAlign.left,),
                        // TextField(
                        //   onChanged: (String value) {
                        //     date = value ;
                        //   },
                        //   controller: dateInputController,
                        //   readOnly: true,
                        //   onTap: () async {
                        //     DateTime? pickedDate = await showDatePicker(
                        //         context: context,
                        //         initialDate: DateTime.now(),
                        //         firstDate: DateTime(1950),
                        //         lastDate: DateTime(2050));
                        //
                        //     if (pickedDate != null) {
                        //       dateInputController.text =pickedDate.toString();
                        //     }
                        //   },
                        // ),
                        buildDate(),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //todos.add(title);
                            createToDo();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Add"),
                        style: TextButton.styleFrom(
                          primary: Colors.blue.shade900, // Text Color
                        ),
                     ),
                    TextButton(onPressed: () {
                      setState(() {
                      });
                      Navigator.of(context).pop();
                    },
                        child: const Text("Cancel"),
                      style: TextButton.styleFrom(
                        primary: Colors.blue.shade900, // Text Color
                      ),
                    )
                  ],
                );
              }
              );
        },
        backgroundColor: Colors.blue.shade900,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    onChanged: (String value) {
      title = value;
    },
    validator: (title) {
      if (title!.isEmpty) {
        return 'The title cannot be empty';
      }
      return null;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Title',
    ),
  );

  Widget buildDescription() => TextFormField(
    maxLines: 3,
    initialValue: description,
    onChanged: (String value) {
      description = value;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Description',
    ),
  );

  Widget buildDate() => TextField(
    maxLines: 3,
    onChanged: (String value) {
      time = value ;
    },
    controller: dateInputController,
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2050));

      if (pickedDate != null) {
        dateInputController.text =pickedDate.toString();
      }
    },
  );
}



