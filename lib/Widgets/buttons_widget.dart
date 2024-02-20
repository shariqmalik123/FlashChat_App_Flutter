import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color myColor;
  final String myText;
  final Function() onPressButton;
  const ButtonWidget(
      {super.key,
      required this.myColor,
      required this.myText,
      required this.onPressButton});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: myColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressButton,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            myText,
          ),
        ),
      ),
    );
  }
}
