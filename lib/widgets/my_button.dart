import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.color,
    required this.textColor,
    required this.paddingH,
    required this.paddingV,
  });
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  final double paddingH;
  final double paddingV;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
        child: child,
      ),
    );
  }
}
