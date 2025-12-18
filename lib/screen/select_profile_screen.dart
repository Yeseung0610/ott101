import 'package:flutter/material.dart';
import 'package:ott101/component/colors.dart';
import 'package:ott101/component/user_avatar.dart';
import 'package:ott101/provider/app_provider.dart';
import 'package:ott101/screen/add_profile_screen.dart';

class SelectProfileScreen extends StatefulWidget {
  const SelectProfileScreen({super.key});

  @override
  State<SelectProfileScreen> createState() => _SelectProfileScreenState();
}

class _SelectProfileScreenState extends State<SelectProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appProvider.loadUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '시청할 프로필을 선택하세요.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            Spacer(flex: 1),
            if (appProvider.userList.isEmpty) Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Color(0xFF232935),
                borderRadius: BorderRadius.all(Radius.circular(14))
              ),
              child: Text(
                '등록된 프로필이 없습니다.\n프로필 추가 후 이용가능 합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            if (appProvider.userList.isNotEmpty) Container(
              height: 100,
              width: double.infinity,
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: appProvider.userList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final user = appProvider.userList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: UserAvatar(user: user),
                  );
                },
              ),
            ),
            Spacer(flex: 2),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddProfileScreen();
                  }));
                  appProvider.loadUserList();
                },
                child: Column(
                  spacing: 8,
                  children: [
                    Icon(Icons.add_circle_outline, size: 54, color: Colors.white,),
                    Text('프로필 추가', style: TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ),
              ),
            ),
            Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}
