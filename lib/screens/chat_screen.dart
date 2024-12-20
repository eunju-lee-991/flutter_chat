import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sbsbsb/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
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

  void getMessages() async {
    // var querySnapshot = await _firestore.collection('messages').get();
    // for (var msg in querySnapshot.docs) {
    //   print(msg.get('text'));
    // }

    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
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
                if (loggedInUser != null) {
                  print('goodbyeeeeeeeee $loggedInUser');
                }
                await _auth.signOut();

                print('goodbyeeeeeeeee??? ${_auth.currentUser}');
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
