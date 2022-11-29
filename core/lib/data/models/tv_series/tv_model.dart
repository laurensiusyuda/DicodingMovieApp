import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';

class TvModel extends Equatable {
  TvModel({
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  List<int> genreIds;
  int id;
  String name;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
  double voteAverage;
  int voteCount;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        // backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        // "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvEntity toEntity() {
    return TvEntity(
      genreIds: genreIds,
      id: id,
      name: name,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath ?? "",
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        // backdropPath,
        genreIds,
        id,
        name,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
