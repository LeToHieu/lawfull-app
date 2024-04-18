import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';
import '../components/list_title.dart';
import '../components/search_list_title.dart';
import 'chi_tiet.dart';

class SearchPage extends StatefulWidget {
  List? data = [];
  SearchPage({super.key, required this.data});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List? filteredData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void showChiTiet(String value, String deMucID) {
    showDialog(
        context: context,
        builder: (context) {
          return ChiTietPage(
            DeMucID: deMucID,
            MAPC: value,
          );
        });
  }

  void _runFilter(String enteredKeyword) {
    List? results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.data;
    } else {
      results = widget.data
          ?.where((item) =>
              item["TEN"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredData = results;
    });
  }

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Opacity(
        opacity: 0.9,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(20.0), // Adjust the value as needed
          ),
          height: 500,
          width: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                  ),
                ),
              ),
              //list the data here with listview builder
              Expanded(
                child: ListView.builder(
                    itemCount: filteredData!.length,
                    itemBuilder: (context, index) {
                      return filteredData != null
                          ? SearchListTitle(
                              title: filteredData?[index]["TEN"],
                              onTap: () => showChiTiet(
                                  filteredData?[index]["MAPC"],
                                  filteredData?[index]["DeMucID"]))
                          : Text("there still nothing here");
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
