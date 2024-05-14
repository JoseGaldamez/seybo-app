import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 1),
        height: 75,
        width: 75,
        child:
            Image.asset('assets/images/logoseybo.png', fit: BoxFit.fitWidth));
  }
}
