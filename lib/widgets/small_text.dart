import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  double height;
  SmallText(
      {this.color = Colors.black54, required this.text,
      this.size = 12,
      this.overflow = TextOverflow.ellipsis, this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(color: color, fontWeight: FontWeight.w400, fontSize: size, height: height),
    );
  }
}
