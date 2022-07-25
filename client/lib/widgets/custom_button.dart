import 'package:flutter/material.dart';
import 'package:tic_tac_toe/util/colors.dart';
import 'package:tic_tac_toe/util/dimension.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final Function() onTap;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: buttonColor,
            blurRadius: buttonBlurShadowColor,
            spreadRadius: buttonSpreadShadowColor,
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            width,
            buttonHeight,
          ),
        ),
        onPressed: onTap,
        child: text,
      ),
    );
  }
}
