import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<BoxShadow> shadows;

  const CustomText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.shadows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        shadows: shadows,
      ),
    );
  }
}
