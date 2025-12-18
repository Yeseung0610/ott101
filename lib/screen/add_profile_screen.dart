import 'package:flutter/material.dart';
import 'package:ott101/component/colors.dart';
import 'package:ott101/component/user_avatar.dart';
import 'package:ott101/model/user_model.dart';
import 'package:ott101/provider/app_provider.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appProvider.setCreateUser(UserModel.createUser());
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = appProvider.createUser;
    if (user == null) return Container();

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 14),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '프로필 추가',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '취소',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  ),
                ),
                SizedBox(width: 30),
              ],
            ),
            Spacer(flex: 13),
            UserAvatar(user: user),
            Spacer(flex: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF2D323F),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  border: Border.all(width: 1, color: Colors.white)
                ),
                child: TextField(
                  onChanged: (value) {
                    appProvider.setUserName(value);
                  },
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () async {
                  await appProvider.saveUser(user);
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    gradient: LinearGradient(
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                      colors: [
                        Color(0xFFF7AE04),
                        Color(0xFFF76F04),
                      ],
                    ),
                  ),
                  child: Text(
                    '저장하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 40),
          ],
        ),
      ),
    );
  }
}
