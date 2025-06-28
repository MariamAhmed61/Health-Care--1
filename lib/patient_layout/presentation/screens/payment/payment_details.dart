import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:health_care_app/auth/pressentation/custom_widgets/customButton.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:health_care_app/patient_layout/presentation/cubits/appointment_cubit/appointment_state.dart';
import 'package:health_care_app/patient_layout/presentation/screens/layout/patient_layout_screen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  static const String routeName = 'payment_details';
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
                isHolderNameVisible: true,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: showBackView,
                onCreditCardWidgetChange: (onChange) {}),
            CreditCardForm(
              obscureCvv: true,
              obscureNumber: true,
              autovalidateMode: _autovalidateMode,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (ceeditCardModel) {
                setState(() {
                  cardNumber = ceeditCardModel.cardNumber;
                  expiryDate = ceeditCardModel.expiryDate;
                  cardHolderName = ceeditCardModel.cardHolderName;
                  cvvCode = ceeditCardModel.cvvCode;
                  showBackView = ceeditCardModel.isCvvFocused;
                });
              },
              formKey: formKey,
            ),
            CustomButton(
                text: 'Pay',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );

// Simulate payment delay (e.g., as if a payment process is happening)
                    await Future.delayed(const Duration(seconds: 2));

// After waiting, close the loading dialog
                    Navigator.of(context).pop();

// Show success dialog using EasyDialog
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 16,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                backgroundColor: Color(0xFFE8F5E9),
                                child: Icon(
                                  Icons.check_rounded,
                                  color: AppColors.primaryColor,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Payment Successful!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Thank you for your payment. Your transaction has been completed successfully.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PatientLayoutScreen()));
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                padding: const EdgeInsets.only(top: 50))
          ],
        ),
      ),
    );
  }
}
