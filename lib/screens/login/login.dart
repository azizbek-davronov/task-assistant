import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_assistant/models/password_visibility_provider.dart';
import 'package:task_assistant/screens/home/home_screen.dart';
import 'package:task_assistant/screens/login/widgets/login_header.dart';
import 'package:task_assistant/models/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final passwordVisibilityProvider =
        Provider.of<PasswordVisibilityProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  // logo, title, subtitle
                  LoginHeader(),

                  // form
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          // login
                          TextFormField(
                            controller: _loginController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.direct_right),
                              labelText: 'USERNAME',
                              border: OutlineInputBorder().copyWith(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: passwordVisibilityProvider.isObscure,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.password_check),
                              labelText: 'PASSWORD',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  passwordVisibilityProvider.toggleVisibility();
                                },
                                icon: Icon(
                                  passwordVisibilityProvider.isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: OutlineInputBorder().copyWith(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // error
                          if (_errorMessage != null) ...[
                            Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 8),
                          ],

                          // remember me and forget password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(value: true, onChanged: (value) {}),
                                  const Text('Remember Me'),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Forget Password?'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // log in button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _authenticate(context),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.deepPurple,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text('Log In'),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // create account button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                elevation: 0,
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.deepPurple),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text('Create Account'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _authenticate(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(_loginController.text, _passwordController.text);

    if (authProvider.isAuthenticated) {
      setState(() {
        _errorMessage = null;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Wrong username or password';
      });
    }
  }
}
