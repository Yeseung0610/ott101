import 'package:flutter/material.dart';
import 'package:ott101/component/colors.dart';
import 'package:ott101/provider/app_provider.dart';
import 'package:ott101/screen/select_profile_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await appProvider.startIntroAnimation();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return SelectProfileScreen();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children: [
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: appProvider.isAnimatedShowTimeLogo ? 1 : 0,
            child: Center(
              child: Transform.scale(
                scaleY: 0.75,
                child: Container(
                  width: MediaQuery.widthOf(context) - 40,
                  height: MediaQuery.widthOf(context) - 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFF323732),
                        Color(0xFF323732),
                        Color(0xAA323732),
                        Color(0x00323732),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: appProvider.isAnimatedShowTimeLogo ? 1 : 0,
            child: Center(
              child: Image.asset(
                'assets/showtime_logo.png',
                width: MediaQuery.widthOf(context) * 0.4,
              ),
            ),
          ),
          AnimatedSlide(
            duration: Duration(seconds: 1),
            offset: Offset(0, appProvider.isAnimatedWorldSkillsLogo ? 0 : -0.2),
            curve: Curves.easeInOut,
            child: Align(
              alignment: AlignmentGeometry.topCenter,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 34,
                  left: 60,
                  right: 60,
                ),
                child: Image.asset('assets/world_skills_logo.png'),
                decoration: BoxDecoration(
                  color: Color(0xFFF0EAEA),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
