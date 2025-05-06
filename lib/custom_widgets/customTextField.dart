import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

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
          labelStyle: TextStyle(color:  AppColors.primaryColor),
          prefixIcon: Icon(
            icon,
            color:  AppColors.primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color:  AppColors.primaryColor, width: 2),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color:  AppColors.primaryColor,
                width: 2,
              )),
          labelText: text,
        ),
      ),
    );
  }
}
