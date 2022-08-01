import 'package:flutter/material.dart';
import 'package:todo_app/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoModel> todoList = [];

  TextEditingController titleController = TextEditingController();
  String titleField = '';
  TextEditingController descriptionController = TextEditingController();
  String descriptionField = '';
  String? titleErrorText;
  String? descriptionErrorText;

  void createTodo(String title, String description) {
    setState(() {
      // Add new entry to map
      todoList.add(TodoModel(title, description));

      // Clear TextField inputs
      titleField = '';
      descriptionField = '';

      // Clear TextEditingControllers
      titleController.clear();
      descriptionController.clear();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              maxLines: 1,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'title',
                errorText: titleErrorText,
              ),
              onChanged: (text) {
                setState(() {
                  titleField = text.toUpperCase();
                  titleErrorText = null;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              maxLines: 1,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'description',
                errorText: descriptionErrorText,
              ),
              onChanged: (text) {
                setState(() {
                  descriptionField = text;
                  descriptionErrorText = null;
                });
              },
            ),
            const SizedBox(height: 50),
            ListView.builder(
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return (Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todoList[index].title),
                    Text(
                      todoList[index].description,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                  ],
                ));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          if (titleController.value.text.isNotEmpty &&
              descriptionController.value.text.isNotEmpty)
            {createTodo(titleField, descriptionField)}
          else if (titleController.value.text.isEmpty &&
              descriptionController.value.text.isEmpty)
            {
              setState(() {
                titleErrorText = 'Title cannot be empty';
                descriptionErrorText = 'Description cannot be empty';
              })
            }
          else if (descriptionController.value.text.isEmpty)
            {
              setState(() {
                descriptionErrorText = 'Description cannot be empty';
              })
            }
          else
            {
              setState(() {
                titleErrorText = 'Title cannot be empty';
              })
            }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
