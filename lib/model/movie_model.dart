class MovieModel {
  final bool adult;
  final String backdrop_path;
  final List<int> genre_ids;
  final int id;
  final String poster_path;
  final String title;
  final double vote_average;

  MovieModel({required this.adult, required this.backdrop_path, required this.genre_ids, required this.id, required this.poster_path, required this.title, required this.vote_average});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'],
      backdrop_path: json['backdrop_path'],
      genre_ids: (json['genre_ids'] as List<dynamic>).map((e) {
        return e as int;
      }).toList(),
      id: json['id'],
      poster_path: json['poster_path'],
      title: json['title'],
      vote_average: json['vote_average'],
    );
  }

  String get posterUrl {
    return 'https://image.tmdb.org/t/p/original/${poster_path}';
  }
}