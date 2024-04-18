import 'package:client2/components/chat_titile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;

  final chatMessages = [
    {
      "msg": "Hello who are you?",
      "chatIndex": 0,
    },
    {
      "msg":
          "Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you",
      "chatIndex": 1,
    },
    {
      "msg": "What is flutter?",
      "chatIndex": 0,
    },
    {
      "msg":
          "Flutter is an open-source mobile application development framework created by Google.",
      "chatIndex": 1,
    },
    {
      "msg": "What the matter of the life i want to die please kill me",
      "chatIndex": 0,
    },
    {
      "msg":
          "Im very sorry to hear that, but im just a normal texting chat bot, i cant answer that kind of question. But surely u have to like lmao about it or go to hospital to get more help",
      "chatIndex": 1,
    }
  ];
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ChatWidget(
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
              Material(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                              controller: textEditingController,
                              onSubmitted: (value) {},
                              decoration: InputDecoration.collapsed(
                                  hintText: "Hãy hỏi điều gì đó!",
                                  hintStyle:
                                      TextStyle(color: Colors.black54)))),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
