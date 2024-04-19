import 'package:client2/auth/auth.dart';
import 'package:client2/auth/login_or_register.dart';
import 'package:client2/pages/chat.dart';
import 'package:client2/pages/chu_de_page.dart';
import 'package:client2/pages/de_muc.dart';
import 'package:client2/pages/history.dart';
import 'package:client2/pages/login_page.dart';
import 'package:client2/pages/register_page.dart';
import 'package:client2/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/my_toast.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/chuDe': (context) => ChuDePage(),
        '/history': (context) => HistoryPage(),
        '/chat': (context) => ChatPage(),
        '/setting': (context) => SettingPage(),
      },
    );
  }
}
