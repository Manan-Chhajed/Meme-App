import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  const TextBtn(
      {required this.onPress,
      required this.text,
      required this.color,
      super.key});

  final Function() onPress;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.black),
          ),
        ),
      ),
      onPressed: onPress,
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
