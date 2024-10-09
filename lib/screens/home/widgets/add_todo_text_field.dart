import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_assistant/models/todo_provider.dart';
import 'package:task_assistant/utils/controllers.dart';
import 'package:task_assistant/utils/helper_functions.dart';

class AddTodoTextField extends StatelessWidget {
  const AddTodoTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: Controllers.textEditingController,
            decoration: const InputDecoration(
              hintText: 'Add Todo',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (Controllers.textEditingController.text.isNotEmpty) {
              Provider.of<TodoProvider>(context, listen: false)
                  .addTodo(Controllers.textEditingController.text);
              Controllers.textEditingController.clear();
              HelperFunctions.scrollToBottom(Controllers.scrollController);
            }
          },
        ),
      ],
    );
  }
}
