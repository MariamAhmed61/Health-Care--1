import 'package:flutter/material.dart';
import 'package:health_care_app/constant.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            'assets/images/splashPicture.jpg',
            height: 200,
            width: 200,
            alignment: Alignment.center,
          ),
        ),
        Text(
          'Health Care',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            fontFamily: 'Pacifico',
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
