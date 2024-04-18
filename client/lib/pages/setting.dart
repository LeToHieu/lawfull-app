import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text(
          "SETTING",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text("This is setting page"),
      ),
    );
  }
}
