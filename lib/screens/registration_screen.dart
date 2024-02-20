// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, use_build_context_synchronously, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/Widgets/buttons_widget.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
        inAsyncCall: isLoading,
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
                  style: const TextStyle(color: Colors.black54),
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.mail),
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.black54),
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter with password')),
              const SizedBox(
                height: 24.0,
              ),
              ButtonWidget(
                myColor: Colors.blueAccent,
                myText: 'Register',
                onPressButton: () async {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    final user = await _auth.createUserWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );
                    if (user != null) {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                    setState(() {
                      isLoading = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
