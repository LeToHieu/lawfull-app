import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';

class ChiTietPage extends StatefulWidget {
  String DeMucID = "";
  String MAPC = "";
  ChiTietPage({super.key, required this.DeMucID, required this.MAPC});

  @override
  State<ChiTietPage> createState() => _ChiTietPageState();
}

class _ChiTietPageState extends State<ChiTietPage> {
  List<dynamic> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChiTiet();
  }

  void getChiTiet() async {
    var reqBody = {"DeMucID": widget.DeMucID, "MAPC": widget.MAPC};
    var response = await http.post(
      Uri.parse(CHI_TIET_URL),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(reqBody),
    );

    final jsonResponse = jsonDecode(response.body);
    setState(() {
      data = jsonResponse["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      actions: [
        Container(
          // Adjust the height as needed
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Text(
              "Đóng",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
        ),
      ],
      content: data.isEmpty
          ? Container(
              child: Text(
              "There nothing hear", // Check for null
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ))
          : Container(
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      data[0]["title"] ?? " ", // Check for null
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => launchUrl(Uri.parse(data[0]["ghi_chu_url"])),
                      child: Text(
                        data[0]["ghi_chu"] ?? " ", // Check for null
                        style: TextStyle(
                            fontSize: 14.0, fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      data[0]["content"] ?? " ", // Check for null
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
