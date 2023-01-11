import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.color,
      required this.textColor});
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: color),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        // in stateless widget, we use just color and not widget.color
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(color: textColor),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
