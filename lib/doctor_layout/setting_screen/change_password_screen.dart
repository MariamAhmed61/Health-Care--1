import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = 'changepassword';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.primaryColor),
        centerTitle: true,
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildPasswordField(
                label: 'Current Password',
                controller: currentPasswordController,
                obscureText: true,
                showEyeIcon: false,
              ),
              const SizedBox(height: 16),
              buildPasswordField(
                label: 'New Password',
                controller: newPasswordController,
                obscureText: _obscureNew,
                showEyeIcon: true,
                toggleVisibility: () {
                  setState(() => _obscureNew = !_obscureNew);
                },
              ),
              const SizedBox(height: 16),
              buildPasswordField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                obscureText: _obscureConfirm,
                showEyeIcon: true,
                toggleVisibility: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password Changed')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required bool showEyeIcon,
    VoidCallback? toggleVisibility,
  }) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.primaryColor,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (controller == confirmPasswordController &&
              value != newPasswordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: AppColors.primaryColor),
            prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
            suffixIcon: showEyeIcon
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primaryColor,
              ),
              onPressed: toggleVisibility,
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            ),
        );
    }
}