import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ott101/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  UserModel? createUser;
  void setCreateUser(UserModel user) {
    createUser = user;
    updateScreen();
  }

  void setUserName(String name) {
    createUser?.name = name;
    updateScreen();
  }

  Future<void> saveUser(UserModel user) async {
    final jsonUser = user.toJson();
    final stringJsonUser = jsonEncode(jsonUser);
    final sharedPref = await SharedPreferences.getInstance();

    final oldUserList = sharedPref.getStringList('user_list') ?? [];
    oldUserList.add(stringJsonUser);

    sharedPref.setStringList('user_list', oldUserList);
  }

  final userList = [];
  void loadUserList() async {
    final sharedPref = await SharedPreferences.getInstance();
    final stringJsonUserList = sharedPref.getStringList('user_list') ?? [];
    final savedUserList = stringJsonUserList.map((e) {
      final jsonUser = jsonDecode(e);
      return UserModel.fromJson(jsonUser);
    });

    userList.clear();
    userList.addAll(savedUserList);
    updateScreen();
  }
}