import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final String msg;
  final bool loading;
  final int chatIndex;
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? Colors.grey[200] : Colors.grey[400],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        chatIndex == 0 ? Colors.transparent : Colors.lime[100],
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: chatIndex == 0
                      ? Icon(
                          Icons.account_box_rounded,
                          size: 36,
                        )
                      : Image.asset(
                          'lib/images/Law_Icon.png',
                          height: 30,
                        ),
                ),
                SizedBox(width: 8),
                Expanded(
                    child: chatIndex == 0 || !loading
                        ? Text(
                            msg,
                            style: TextStyle(fontSize: 18),
                          )
                        : DefaultTextStyle(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                            child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                repeatForever: false,
                                displayFullTextOnTap: true,
                                totalRepeatCount: 1,
                                animatedTexts: [TyperAnimatedText(msg.trim())]),
                          )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
