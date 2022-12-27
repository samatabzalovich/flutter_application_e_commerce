import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  IconAndTextWidget({required this.icon,required this.text,required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: color,),
      SizedBox(width: 5,),
      SmallText(text: text)
    ],);
  }
}
