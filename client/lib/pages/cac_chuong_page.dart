import 'dart:convert';
import 'package:client2/pages/cac_dieu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';
import '../components/list_title.dart';

class CacChuongPage extends StatefulWidget {
  String deMucValue = "";
  CacChuongPage({super.key, required this.deMucValue});

  @override
  State<CacChuongPage> createState() => _ChuDeState();
}

class _ChuDeState extends State<CacChuongPage> {
  List? data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChuDe();
  }

  void getChuDe() async {
    var reqBody = {"deMucValue": widget.deMucValue};

    var response = await http.post(
      Uri.parse(CAC_CHUONG_URL),
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
            builder: (context) => CacDieuPage(chuongValue: value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text(
          "CÁC CHƯƠNG",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, index) {
            return data != null
                ? ListTitle(
                    title: data?[index]["TEN"],
                    onTap: () => navigateToCacChuong(data?[index]["MAPC"]))
                : Text("there still nothing here");
          }),
    );
  }
}
