import 'dart:convert';
import '../components/my_toast.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';
import 'package:flutter/material.dart';

import '../components/login_textfield.dart';
import '../components/my_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cfPasswordController = TextEditingController();

  String? _errorMessage;

  void _signUpUser(context) async {
    setState(() {
      _errorMessage = _validateForm();
    });

    if (_errorMessage == null) {
      var regBody = {
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text
      };
      var response = await http.post(Uri.parse(REGISTRATION_URL),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(
            regBody,
          ));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        MyToast.show(context, true, jsonResponse["message"]);
        //user onTap here
        widget.onTap();
      } else {
        MyToast.show(context, false, jsonResponse["message"]);
      }
    }
  }

  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  String? _validateForm() {
    if (_usernameController.text.isEmpty) {
      return 'Please enter your username';
    }
    if (_emailController.text.isEmpty) {
      return 'Please enter your email';
    }
    if (!_isEmailValid(_emailController.text)) {
      return 'Please enter a valid email';
    }
    // Add more validation checks for email format, password strength, etc. if needed
    if (_passwordController.text.isEmpty) {
      return 'Please enter your password';
    }
    if (_cfPasswordController.text != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('lib/images/Law_Icon.png'),
                    height: 150,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Greating to LawFull',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginTextField(
                    controller: _usernameController,
                    label: "Username",
                    hintText: "Enter your username",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginTextField(
                    controller: _emailController,
                    label: "Email",
                    hintText: "Enter you email address",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginTextField(
                    controller: _passwordController,
                    label: "Password",
                    hintText: "Enter your password",
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginTextField(
                    controller: _cfPasswordController,
                    label: "Confirm Password",
                    hintText: "Enter your password",
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyButton(
                    text: "Sign In",
                    onTap: () => _signUpUser(context),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Text("Already a member? "),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: Text(
                                  "Login now",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
