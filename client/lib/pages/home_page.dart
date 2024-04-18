import 'dart:convert';
import 'package:client2/pages/chu_de_page.dart';
import 'package:client2/pages/history.dart';
import 'package:client2/pages/search_page.dart';
import 'package:client2/pages/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:http/http.dart' as http;
import '../auth/config.dart';

import '../auth/auth.dart';
import '../auth/auth_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String? jwt;
  late String username = "";
  late List searchData = [];
  int _selectedIndex = 0;

  bool _showOverlay = false;

  void getCacDieu() async {
    var response = await http.get(
      Uri.parse(CAC_DIEU_URL),
      headers: {"Content-type": "application/json"},
    );
    final jsonResponse = jsonDecode(response.body);
    setState(() {
      searchData = jsonResponse["data"];
    });
  }

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJwt();
    getCacDieu();
  }

  Future<void> _loadJwt() async {
    final jwt = await AuthStorage.getJwt();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(jwt!);
    username = jwtDecodedToken['username'];
    setState(() {
      this.jwt = jwt;
    });
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    ChuDePage(),
    HistoryPage(),
  ];

  void logout(context) {
    AuthStorage.removeJwt();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: Text(
          "L A W F U L L ",
        ),
        actions: [
          IconButton(onPressed: _toggleOverlay, icon: Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          // Navigator.pop(context);
          Navigator.pushNamed(context, '/chat')
        },
        backgroundColor: Colors.lime[100],
        label: const Text('Hỏi đáp'),
        icon: Icon(Icons.chat),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                    child: Image.asset(
                  'lib/images/Law_Icon.png',
                  color: Colors.grey[200],
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Wellcome back, " + username + " !",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "H O M E",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/homepage');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text(
                      "S E T T I N G",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/setting');
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 30.0),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  "L O G O U T",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  logout(context);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:
                    _selectedIndex == 0 ? Colors.grey[300] : Colors.transparent,
              ),
              width: 100,
              child: Icon(
                Icons.menu,
              ),
            ),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:
                    _selectedIndex == 1 ? Colors.grey[300] : Colors.transparent,
              ),
              width: 100, // Adjust the width as needed
              child: Icon(
                Icons.history,
              ),
            ),
            label: 'Lịch sử',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
      ),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          _showOverlay ? SearchPage(data: searchData) : SizedBox(),
        ],
      ),
    );
  }
}
