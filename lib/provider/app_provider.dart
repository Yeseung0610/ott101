import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ott101/model/genre_model.dart';
import 'package:ott101/model/movie_model.dart';
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

  late UserModel selectedUser;
  void selectUser(UserModel user) {
    selectedUser = user;
    updateScreen();
  }

  int currentTabIndex = 0;
  void changeTabIndex(int index) {
    currentTabIndex = index;
    updateScreen();
  }

  final client = Client();
  final baseUrl = 'https://api.themoviedb.org/3';
  final language = 'ko-KR';
  final region = 'KR';
  final apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYWQwMDViZTM4ZTQyMmUwZTA3ZTVjZDk1MDBhNzliYiIsIm5iZiI6MTY1MDg4MjYzNC44ODgsInN1YiI6IjYyNjY3ODRhYWFlYzcxMDA5ZDk1YzA5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.G2yDxRl4lsPyNn61M0wfMGBK9cbm3XlMLxKeiCbbdog';

  List<GenreModel> genreList = [];
  void loadGenreList() async {
    final url = Uri.parse(
        '${baseUrl}/genre/movie/list?language=${language}&region=${region}'
    );

    final response = await client.get(url, headers: {
      'Authorization': 'Bearer ${apiKey}',
    });

    final jsonBody = jsonDecode(response.body);
    final genreJsonList = jsonBody['genres'] as List<dynamic>;
    genreList = genreJsonList.map((e) {
      return GenreModel.fromJson(e);
    }).toList();
    updateScreen();
  }

  List<MovieModel> topRatedMovieList = [];
  void loadTopRatedMovieList() async {
    final url = Uri.parse(
        '${baseUrl}/movie/top_rated?language=${language}&region=${region}&page=1'
    );

    final response = await client.get(url, headers: {
      'Authorization': 'Bearer ${apiKey}',
    });

    final jsonBody = jsonDecode(response.body);
    final movieJsonList = jsonBody['results'] as List<dynamic>;
    topRatedMovieList = movieJsonList.map((e) {
      return MovieModel.fromJson(e);
    }).toList();
    updateScreen();
  }
}