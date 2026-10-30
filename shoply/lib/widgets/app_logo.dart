import 'package:flutter/material.dart';

/// اللوغو الرسمي (من assets/images/shoply_splash.png)
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/shoply_splash.png', height: size * 2.4);
  }
}
