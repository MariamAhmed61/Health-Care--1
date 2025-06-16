import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final void Function(String?)? onSaved;
  
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final bool obsecureText;
  final IconData? icon;
  final String? Function(String?)? validator;
  const CustomTextField({
    
    super.key,
    this.controller,
    this.obsecureText = false,
    this.onSaved,
    this.textInputType,
    this.icon,
    required this.text, this.validator, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        onSaved: onSaved,
        validator:  validator,
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
