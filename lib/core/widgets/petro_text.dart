import 'package:flutter/material.dart';

class PetroText extends StatelessWidget {
  const PetroText(this.text,
      {super.key, this.size = 16, this.color, this.textAlign = TextAlign.center,this.fontWeight});
  final String text;
  final double? size;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
