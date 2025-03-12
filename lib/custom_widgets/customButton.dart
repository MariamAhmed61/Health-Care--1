import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_care_app/constant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  const CustomButton({
    this.onPressed,
    this.padding,
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 0, bottom: 0),
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            fixedSize: Size(300, 60),
            side: const BorderSide(color: Colors.white, width: 3),
          )),
    );
  }
}
