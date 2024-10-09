import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_assistant/models/todo_provider.dart';
import 'package:task_assistant/utils/controllers.dart';

class TodoCards extends StatelessWidget {
  const TodoCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          final todos = todoProvider.todos;
          final apiTodos = todoProvider.apiTodos;
          return ListView.builder(
            controller: Controllers.scrollController,
            shrinkWrap: true,
            itemCount: apiTodos.length + todos.length,
            itemBuilder: (context, index) {
              if (index < apiTodos.length) {
                final todo = apiTodos[index];

                // api todo card
                return Card(
                  child: ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    tileColor: Colors.grey,
                    textColor: Colors.white,
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'API Todo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Container(
                      padding: EdgeInsets.zero,
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    trailing: Checkbox(
                      checkColor: Colors.white,
                      value: todo.completed,
                      onChanged: null,
                    ),
                  ),
                );
              } else {
                final todo = todos[index - apiTodos.length];

                // local todo card
                return Card(
                  child: ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    tileColor: Colors.deepPurple,
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'Local Todo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Container(
                      padding: EdgeInsets.zero,
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Provider.of<TodoProvider>(context, listen: false)
                                .deleteTodo(todo);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        Checkbox(
                          value: todo.completed,
                          onChanged: (bool? value) {
                            Provider.of<TodoProvider>(context, listen: false)
                                .toggleTodoCompletion(todo);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
