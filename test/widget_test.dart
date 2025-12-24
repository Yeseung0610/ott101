// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:http/http.dart';
import 'package:ott101/model/genre_model.dart';
import 'package:ott101/model/movie_model.dart';

void main() async {
  final client = Client();

  final baseUrl = 'https://api.themoviedb.org/3';
  final language = 'ko-KR';
  final region = 'KR';
  final apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYWQwMDViZTM4ZTQyMmUwZTA3ZTVjZDk1MDBhNzliYiIsIm5iZiI6MTY1MDg4MjYzNC44ODgsInN1YiI6IjYyNjY3ODRhYWFlYzcxMDA5ZDk1YzA5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.G2yDxRl4lsPyNn61M0wfMGBK9cbm3XlMLxKeiCbbdog';

  final url = Uri.parse(
    '${baseUrl}/movie/top_rated?language=${language}&region=${region}&page=1'
  );

  final response = await client.get(url, headers: {
    'Authorization': 'Bearer ${apiKey}',
  });

  final jsonBody = jsonDecode(response.body);
  final movieJsonList = jsonBody['results'] as List<dynamic>;
  final movieModelList = movieJsonList.map((e) {
    return MovieModel.fromJson(e);
  }).toList();

  for (var value in movieModelList) {
    print(value.title);
  }
}