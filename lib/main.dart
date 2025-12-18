import 'package:flutter/material.dart';
import 'package:ott101/component/colors.dart';
import 'package:ott101/provider/app_provider.dart';
import 'package:ott101/screen/intro_screen.dart';

void main() {
  runApp(ShowTimeApp());
}

class ShowTimeApp extends StatelessWidget {
  const ShowTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appProvider.updateCount,
      builder: (context, value, child) {
        return MaterialApp(
          home: IntroScreen(),
        );
      },
    );
  }
}
