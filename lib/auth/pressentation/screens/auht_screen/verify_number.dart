import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'dart:async';

import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';

class VerifyNumber extends StatefulWidget {
  final String? phoneNumber;
  final String? code;
  final String? userType;
  static const routeName = 'verifyNumber';

  const VerifyNumber({super.key, this.code, this.userType, this.phoneNumber});
  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  final formKey = GlobalKey<FormState>();
  String? sendcode;
  int _secondsRemaining = 20;
  bool _enableResend = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _enableResend = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resendCode() {
    setState(() {
      _secondsRemaining = 20;
      _enableResend = false;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Number",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "Please Enter The 4 Digit Code Sent To Your Mobile Number",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            OtpTextField(
              cursorColor: AppColors.primaryColor,
              focusedBorderColor: AppColors.primaryColor,
              numberOfFields: 6,
              borderColor: Colors.black,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                setState(() {
                  sendcode = verificationCode;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              "00:${_secondsRemaining.toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: _enableResend ? _resendCode : null,
              child: Text(
                "Resend Code",
                style: TextStyle(
                  color: _enableResend ? Colors.blue : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                if (sendcode.toString() != widget.code.toString()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid code'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  Navigator.pushReplacementNamed(context, 'createPassword',
                      arguments: {
                        'phoneNumber': widget.phoneNumber,
                        'userType': widget.userType,
                        'code': widget.code
                      });
                }
                log(widget.phoneNumber.toString());
                log(widget.code.toString());
                log(widget.userType.toString());
              },
              padding: EdgeInsets.only(top: 20, bottom: 10),
              text: 'Verify',
            ),
          ],
        ),
      ),
    );
  }
}
