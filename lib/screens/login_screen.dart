// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import '../Widgets/buttons_widget.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.mail),
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.black54,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Enter your password.'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ButtonWidget(
                  myColor: Colors.blueAccent,
                  myText: 'Login',
                  onPressButton: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email!, password: password!);
                      if (user != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
