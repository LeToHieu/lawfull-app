import 'dart:async';
import 'dart:convert';

import 'package:client2/pages/de_muc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';
import '../components/list_title.dart';

class ChuDePage extends StatefulWidget {
  const ChuDePage({super.key});

  @override
  State<ChuDePage> createState() => _ChuDeState();
}

class _ChuDeState extends State<ChuDePage> {
  List? data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChuDe();
  }

  void getChuDe() async {
    var response = await http.get(
      Uri.parse(CHU_DE_URL),
      headers: {"Content-type": "application/json"},
    );
    final jsonResponse = jsonDecode(response.body);
    setState(() {
      data = jsonResponse["data"];
    });
  }

  void navigateToDeMuc(String value) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DeMucPage(chuDeValue: value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, index) {
            return data != null
                ? ListTitle(
                    title: "Chủ đề số " +
                        data?[index]["STT"] +
                        ": " +
                        data?[index]["Text"],
                    onTap: () => navigateToDeMuc(data?[index]["Value"]))
                : Text("there still nothing here");
          }),
    );
  }
}
