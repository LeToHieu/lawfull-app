import 'package:client2/auth/login_or_register.dart';
import 'package:client2/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'auth_storage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? _jwt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkJwt();
    // print("afaw12122e\n");
  }

  Future<void> _checkJwt() async {
    final jwt = await AuthStorage.getJwt();
    // print("afawe\n");
    // print(JwtDecoder.isExpired(jwt!));

    setState(() {
      _jwt = jwt;
      if (_jwt != null && JwtDecoder.isExpired(_jwt!)) {
        // If JWT token is expired or doesn't exist, reload the page
        _jwt = null;
        AuthStorage.removeJwt();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_jwt == null) {
      // If JWT token is expired or doesn't exist, navigate to the login page

      return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: LoginOrRegister());
    } else {
      // If JWT token exists and is valid, navigate to the homepage
      return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: HomePage());
    }
  }
}
