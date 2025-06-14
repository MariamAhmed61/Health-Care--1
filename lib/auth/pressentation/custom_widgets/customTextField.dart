import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final void Function(String?)? onSaved;
  final TextInputType? textInputType;
  final IconData? icon;
  const CustomTextField({
    this.onSaved,
    this.textInputType,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFormField(
        onSaved: onSaved,
        validator: (value) => value!.isEmpty ? 'This field is required' : null,
        cursorColor: AppColors.primaryColor,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: AppColors.primaryColor),
          prefixIcon: Icon(
            icon,
            color: AppColors.primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              )),
          labelText: text,
        ),
      ),
    );
  }
}
