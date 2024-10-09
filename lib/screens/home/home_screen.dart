import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_assistant/models/todo_provider.dart';
import 'package:task_assistant/screens/home/widgets/add_todo_text_field.dart';
import 'package:task_assistant/screens/home/widgets/custom_app_bar.dart';
import 'package:task_assistant/screens/home/widgets/todo_cards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TodoCards(),
            AddTodoTextField(),
          ],
        ),
      ),
    );
  }
}
