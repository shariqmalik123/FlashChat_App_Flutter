// ignore_for_file: library_private_types_in_public_api

import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../Widgets/buttons_widget.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);
    animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    controller!.forward(); //0-----0.5------1

    // controller!.reverse(from: 1); //1-----0
    // controller!.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller!.reverse(from: 1); //1-----0
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller!.forward(); //0-----0.5------1
    //   }
    // });

    controller!.addListener(() {
      setState(() {});
      // ignore: avoid_print
      print(animation!.value);
    });
  }

  @override
  void dispose() {
    // todo: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTween(
              begin: const Color.fromARGB(57, 120, 161, 233), end: Colors.white)
          .animate(controller!)
          .value, // Colors.red.withOpacity(controller!.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: animation!.value * 100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Agne',
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat',
                          speed: const Duration(milliseconds: 200)),
                    ],
                    totalRepeatCount: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            ButtonWidget(
                myColor: Colors.cyan,
                myText: 'Login',
                onPressButton: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            ButtonWidget(
                myColor: Colors.blueAccent,
                myText: 'Register',
                onPressButton: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
