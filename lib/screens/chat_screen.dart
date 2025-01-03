import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sbsbsb/components/message_bubble.dart';
import 'package:sbsbsb/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMessages();
  }

  void getCurrentUser() async {
    try {
      loggedInUser = await _auth.currentUser;
      if (loggedInUser != null) {
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                loggedInUser = _auth.currentUser;
                if (loggedInUser != null) {}
                await _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getStreamBuilder(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        messageText = value;
                      },
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      cursorColor: Colors.red,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser?.email});
                      _controller.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getStreamBuilder() {
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('messages').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final messages = snapshot.data?.docs.reversed;
        return Expanded(
          child: ListView(
            reverse: true, // 맨 마지막에 스크롤 고정
            children: messages?.map((msg) {
                  final data = msg.data() as Map<String, dynamic>;
                  return MessageBubble(
                    text: data['text'] ?? '',
                    sender: data['sender'] ?? '',
                    isSender: (data['sender'] != null &&
                        data['sender'] == loggedInUser?.email),
                  );
                }).toList() ??
                [],
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.yellowAccent,
          ),
        );
      }
    },
  );
}
