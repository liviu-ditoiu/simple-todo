import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> _todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_todos[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _todos.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<String>(
            context: context,
            builder: (context) {
              String newTodo="";
              return AlertDialog(
                title: Text('New Todo'),
                content: TextField(
                  autofocus: true,
                  onChanged: (value) => newTodo = value,
                ),
                actions: [
                  ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    child: Text('Add'),
                    onPressed: () => Navigator.of(context).pop(newTodo),
                  ),
                ],
              );
            },
          );
          if (result != null) {
            setState(() {
              _todos.add(result);
            });
          }
        },
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
