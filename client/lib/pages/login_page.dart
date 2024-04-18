import 'dart:convert';
import 'package:client2/auth/auth.dart';

import '../auth/auth_storage.dart';
import '../auth/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/login_textfield.dart';
import '../components/my_button.dart';
import '../components/my_toast.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validateForm(context) {
    if (!_isEmailValid(_emailController.text)) {
      MyToast.show(context, false, "Please enter your email");
      return false;
    }
    if (_emailController.text.isEmpty) {
      MyToast.show(context, false, "Please enter your email");
      return false;
    }
    if (_passwordController.text.isEmpty) {
      MyToast.show(context, false, "Please enter your password");
      return false;
    }
    return true;
  }

  void signUserIn(context) async {
    if (_validateForm(context)) {
      var reqBody = {
        "email": _emailController.text,
        "password": _passwordController.text
      };
      var response = await http.post(Uri.parse(LOGIN_URL),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(
            reqBody,
          ));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        MyToast.show(context, true, jsonResponse["message"]);
        //user onTap here
        var myToken = jsonResponse["token"];

        AuthStorage.saveJwt(myToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
        );
      } else {
        MyToast.show(context, false, jsonResponse["message"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  'Wellcome back to LawFull',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginTextField(
                  controller: _emailController,
                  label: "Email",
                  hintText: "Enter your email address",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 15,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: "Sign In",
                  onTap: () => signUserIn(context),
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
                            Text("Not a member? "),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                "Register now",
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
    );
  }
}
