import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_assistant/models/password_visibility_provider.dart';
import 'package:task_assistant/models/todo_provider.dart';
import 'package:task_assistant/screens/login/login.dart';
import 'package:task_assistant/models/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VILAVI Task Assistant',
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}
