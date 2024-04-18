import 'dart:convert';
import 'package:client2/pages/cac_chuong_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';
import '../components/list_title.dart';

class DeMucPage extends StatefulWidget {
  String chuDeValue = "";
  DeMucPage({super.key, required this.chuDeValue});

  @override
  State<DeMucPage> createState() => _ChuDeState();
}

class _ChuDeState extends State<DeMucPage> {
  List? data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChuDe();
  }

  void getChuDe() async {
    var reqBody = {"chuDeValue": widget.chuDeValue};

    var response = await http.post(
      Uri.parse(DE_MUC_URL),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(reqBody),
    );

    final jsonResponse = jsonDecode(response.body);
    setState(() {
      data = jsonResponse["data"];
    });
  }

  void navigateToCacChuong(String value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CacChuongPage(deMucValue: value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text(
          "CÁC ĐỀ MỤC",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, index) {
            return data != null
                ? ListTitle(
                    title: "Đề mục số " +
                        data?[index]["STT"] +
                        ": " +
                        data?[index]["Text"],
                    onTap: () => navigateToCacChuong(data?[index]["Value"]))
                : Text("there still nothing here");
          }),
    );
  }
}
