import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_assistant/models/auth_provider.dart';
import 'package:task_assistant/screens/login/login.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
      title: Text(
        'VILAVI Task Assistant',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          color: Colors.white,
          onPressed: () {
            authProvider.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
