import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color textColor;
   
  const DefaultButton({Key? key,
  required this.backgroundColor,
  required this.child,
  required this.onPressed,
  required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
            color: textColor,
          ))),
      onPressed: onPressed,
      child: child,
    );
  }
}
