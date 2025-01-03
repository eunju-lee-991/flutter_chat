import 'package:flutter/material.dart';
import 'package:sbsbsb/constants.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isSender;

  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      this.isSender = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white30,
            ),
          ),
          Material(
            borderRadius: isSender
                ? KSentMessageBorderRadius
                : KReceivedMessageBorderRadius,
            elevation: 5.0,
            color: isSender ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black87,
                  fontSize: 15.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
    // return Container(
    //   padding: EdgeInsets.all(7.0),
    //   child: Column(
    //     crossAxisAlignment:
    //         isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         sender,
    //         style: TextStyle(
    //           fontSize: 12,
    //         ),
    //       ),
    //       Container(
    //         padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
    //         child: Text(
    //           text,
    //           style: TextStyle(
    //             fontSize: 17,
    //           ),
    //         ),
    //         decoration: BoxDecoration(
    //             color: Colors.blue,
    //             borderRadius: BorderRadius.circular(20.0),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.blue, // 그림자 색상
    //                 blurRadius: 10.0, // 그림자 흐림 정도
    //                 offset: Offset(3, 3), // 그림자의 위치
    //               ),
    //             ]),
    //       )
    //     ],
    //   ),
    // );
  }
}
