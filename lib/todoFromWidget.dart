import 'package:flutter/material.dart';

TextEditingController dateInputController = TextEditingController();

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedDate;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    this.title = '',
    this.description = '',
    this.date = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedDate,
    required this.onSavedTodo,
  }) : super();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTitle(),
        SizedBox(height: 8),
        buildDescription(),
        SizedBox(height: 16),
        buildDate(),
        buildButton(),
      ],
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    onChanged: onChangedTitle,
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
    onChanged: onChangedDescription,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Description',
    ),
  );

  Widget buildDate() => TextFormField(
    maxLines: 3,
    initialValue: date,
    onChanged: onChangedDate,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Date',
    ),
    onTap: () async {
      _selectDate(onChangedDate as BuildContext);
    },
  );

  Widget buildButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
      ),
      onPressed: onSavedTodo,
      child: Text('Add'),
    ),
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null)
      dateInputController.text =pickedDate.toString();
  }
}
