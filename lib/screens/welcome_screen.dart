import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sbsbsb/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/rounded_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    // addListener는 애니메이션 상태가 업데이트될 때마다 호출
    // setState는 현재 상태가 변경되었음을 Flutter에 알리고,
    // 해당 상태와 관련된 위젯 트리를 다시 그리도록 요청 => build 호출
    // controller.addListener(() => setState(() {}));
    // controller.addListener(() => print(animation.value));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: animation.value,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset('images/logo.png'),
                          height: 60.0,
                        ),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Flash Chat',
                            textStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: const Duration(milliseconds: 300),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  RoundedButton(
                      title: 'Log In',
                      color: Colors.lightBlueAccent,
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginScreen.id)),
                  RoundedButton(
                      title: 'Register',
                      color: Colors.blueAccent,
                      onPressed: () =>
                          Navigator.pushNamed(context, RegistrationScreen.id)),
                ],
              ),
            ),
          );
        });
  }
}
