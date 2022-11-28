import 'package:ditonton/domain/entities/tv_entities/genre.dart';

class TvDetailEntity {
  TvDetailEntity({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
  });

  bool adult;
  String backdropPath;
  List<TvGenreEntity> genres;
  int id;
  String name;
  int numberOfEpisodes;
  String overview;
  double popularity;
  String posterPath;
  String status;
  String tagline;
  String type;
  double voteAverage;

  factory TvDetailEntity.fromJson(Map<String, dynamic> json) => TvDetailEntity(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<TvGenreEntity>.from(
            json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
      );
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
