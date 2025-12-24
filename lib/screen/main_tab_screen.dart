import 'package:flutter/material.dart';
import 'package:ott101/component/colors.dart';
import 'package:ott101/provider/app_provider.dart';
import 'package:ott101/screen/home_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appProvider.loadGenreList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: IndexedStack(
        index: appProvider.currentTabIndex,
        children: [
          HomeScreen(),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '공개예정',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '다운로드',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '검색',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '프로필',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        child: BottomNavigationBar(
          onTap: appProvider.changeTabIndex,
          currentIndex: appProvider.currentTabIndex,
          selectedItemColor: Color(0xFFF56D04),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF232935),
          items: [
            buildNavItem(icon: Icon(Icons.home_outlined), label: "HOME"),
            buildNavItem(icon: Icon(Icons.playlist_play), label: '공개예정'),
            buildNavItem(icon: Icon(Icons.download_outlined), label: '다운로드'),
            buildNavItem(icon: Icon(Icons.search), label: '검색'),
            buildNavItem(icon: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appProvider.selectedUser.color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Text(
                appProvider.selectedUser.firstCharOfName,
                style: TextStyle(color: Colors.white),
              ),
            ), label: '프로필'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildNavItem({
    required Widget icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
      backgroundColor: Color(0xFF232935),
    );
  }
}
