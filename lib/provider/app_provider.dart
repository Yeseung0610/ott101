import 'package:flutter/cupertino.dart';

final appProvider = AppProvider();

class AppProvider {

  final ValueNotifier<int> updateCount = ValueNotifier(0);
  void updateScreen() {
    updateCount.value = updateCount.value + 1;
  }

  bool isAnimatedShowTimeLogo = false;
  bool isAnimatedWorldSkillsLogo = false;

  Future<void> startIntroAnimation() async {
    await Future.delayed(Duration(seconds: 2));
    isAnimatedShowTimeLogo = true;
    updateScreen();

    await Future.delayed(Duration(seconds: 1));
    isAnimatedWorldSkillsLogo = true;
    updateScreen();

    await Future.delayed(Duration(seconds: 1, milliseconds: 500));
  }
}