import 'package:flutter/material.dart';
import 'package:health_care_app/constant.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextInputType? textInputType;
  final IconData? icon;
  const CustomTextField({
    this.textInputType,
    this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: primaryColor),
          prefixIcon: Icon(
            icon,
            color: primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              )),
          labelText: text,
        ),
      ),
    );
  }
}
