import 'package:flutter/material.dart';

import '../screens/about_screen.dart';

class ActionTopBarButton extends StatelessWidget {
  const ActionTopBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutScreen()));
        },
        icon: const Icon(
          Icons.info_outline,
          color: Colors.grey,
        ));
  }
}
