import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';
import '../components/list_title.dart';
import 'chi_tiet.dart';

class CacDieuPage extends StatefulWidget {
  String chuongValue = "";
  CacDieuPage({super.key, required this.chuongValue});

  @override
  State<CacDieuPage> createState() => _ChuDeState();
}

class _ChuDeState extends State<CacDieuPage> {
  List? data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCacDieu();
  }

  void getCacDieu() async {
    var reqBody = {"chuongValue": widget.chuongValue};

    var response = await http.post(
      Uri.parse(CAC_DIEU_URL),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(reqBody),
    );

    final jsonResponse = jsonDecode(response.body);
    setState(() {
      data = jsonResponse["data"];
    });
  }

  void showChiTiet(String value, String deMucID) {
    showDialog(
        context: context,
        builder: (context) {
          return ChiTietPage(
            DeMucID: deMucID,
            MAPC: value,
            // onCancle: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text(
          "CÁC ĐIỀU LUẬT",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, index) {
            return data != null
                ? ListTitle(
                    title: data?[index]["TEN"],
                    onTap: () => showChiTiet(
                        data?[index]["MAPC"], data?[index]["DeMucID"]))
                : Text("there still nothing here");
          }),
    );
  }
}
