import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sbsbsb/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:sbsbsb/screens/chat_screen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _controller;
  final _auth = FirebaseAuth.instance;
  String initialEmail = 'aaa@gmail.com';
  String? email;
  String? password;
  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = initialEmail;
    _controller = new TextEditingController(text: initialEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  controller: _controller,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: KTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  )),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: KTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                    print(" null ");
                  } else {
                    try {
                      setState(() => showSpinner = true);
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
                              email: email!, password: password!);
                      if (userCredential != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          showSpinner = false;
                        });
                      }else {

                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      print('예외 발생!');
                      print(e);

                      setState(() {
                        showSpinner = false;
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
