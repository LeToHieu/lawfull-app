import 'dart:convert';

import 'package:client2/components/chat_titile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../auth/config.dart';
import '../components/my_toast.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController _listScrollController;
  late FocusNode _focusNode;
  bool _isTyping = false;
  late TextEditingController textEditingController;

  final chatMessages = [];
  @override
  void initState() {
    _focusNode = FocusNode();
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _listScrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut);
  }

  void submitChat() async {
    if (_isTyping) {
      MyToast.show(context, false, "Vui lòng đợi!");
    } else if (textEditingController.text.isEmpty) {
      MyToast.show(context, false, "Vui lòng nhập vào thanh chat!");
    } else if (!textEditingController.text.isEmpty && !_isTyping) {
      var msg = textEditingController.text;
      var reqBody = {"msg": msg};
      setState(() {
        _focusNode.unfocus();
        textEditingController.text = "";
        _isTyping = true;
        chatMessages.add({"msg": msg, "chatIndex": 0});
      });
      var response = await http.post(
        Uri.parse(CHAT_URL),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(reqBody),
      );
      final jsonResponse = jsonDecode(response.body);
      String botMsg = jsonResponse["data"]["answer"];
      setState(() {
        _isTyping = false;
        chatMessages.add({"msg": botMsg, "chatIndex": 1});
        scrollListToEnd();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          centerTitle: true,
          title: Text(
            "HỎI ĐÁP",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            Flexible(
                child: ListView.builder(
                    controller: _listScrollController,
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                          loading: index == chatMessages.length - 1,
                          msg: chatMessages[index]["msg"].toString(),
                          chatIndex: int.parse(
                              chatMessages[index]["chatIndex"].toString()));
                    })),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.black,
                size: 18,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
            Material(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                            focusNode: _focusNode,
                            controller: textEditingController,
                            onSubmitted: (value) {},
                            decoration: InputDecoration.collapsed(
                                hintText: "Hãy hỏi điều gì đó!",
                                hintStyle: TextStyle(color: Colors.black54)))),
                    IconButton(
                        onPressed: submitChat, icon: const Icon(Icons.send))
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
