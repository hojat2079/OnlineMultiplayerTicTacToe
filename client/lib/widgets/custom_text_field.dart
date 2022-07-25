import 'package:flutter/material.dart';
import 'package:tic_tac_toe/util/colors.dart';
import 'package:tic_tac_toe/util/dimension.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isReadOnly;

  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: textFieldBlurShadowColor,
            spreadRadius: textFieldSpreadShadowColor,
          )
        ],
      ),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: bgColorDark,
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
