import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.onPressed, required this.text});

  String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffAE00FD),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            minimumSize: Size(355, 43)),
        child: Text(
          '$text',
          style: TextStyle(fontSize: 19),
        ));
  }
}
