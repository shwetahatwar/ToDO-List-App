import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTODOPage extends StatefulWidget {
  const MyTODOPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyTODOPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyTODOPage> {
  List todos = List.empty();
  String title = "";
  String description = "";
  String date = "";
  TextEditingController dateInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todos = ["Hello", "Hey There","2023-04-10"];
  }

  createToDo() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(title);

    DateTime currentDateTime = DateTime.now();

    Map<String, String> todoList = {
      "todoTitle": title,
      "todoDesc": description,
      "todoDate": date,
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

  editTodo(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(item);
    documentReference.delete().whenComplete(() => print("Edited successfully"));
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
                          title: Text((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : ""),

                          subtitle: Column(
                            children: [
                              Text((documentSnapshot != null)
                                  ? ((documentSnapshot["todoDesc"] != null)
                                  ? documentSnapshot["todoDesc"]
                                  : "")
                                  : ""),

                        Text((documentSnapshot != null)
                            ? ((documentSnapshot["todoDate"] != null)
                            ? documentSnapshot["todoDate"]
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
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              IconButton(icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                setState(() {
                                  deleteTodo((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : "");
                                });
                                },),

                              IconButton(icon: const Icon(Icons.edit),
                                  color: Colors.green,
                              onPressed: (){
                                setState(() {
                                  editTodo((documentSnapshot != null) ? (documentSnapshot["todoTitle"]) : "");
                                });
                              },),
                            ],
                          ),
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
      date = value ;
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

