import 'package:flutter/material.dart';

class CustomSocialMedia extends StatelessWidget {
  const CustomSocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/f.PNG',
              height: 40,
              width: 40,
            )),
        IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {},
            icon: Image.asset(
              'assets/images/g.PNG',
              height: 40,
              width: 40,
            )),
        IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {},
            icon: Image.asset(
              'assets/images/apple.png',
              height: 40,
              width: 40,
            )),
      ],
    );
  }
}
