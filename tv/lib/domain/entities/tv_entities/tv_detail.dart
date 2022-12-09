import 'package:tv/domain/entities/tv_entities/genre.dart';

class TvDetailEntity {
  TvDetailEntity({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeRunTime,
    required this.posterPath,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<TvGenreEntity> genres;
  final List<int> episodeRunTime;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        overview,
        posterPath,
        episodeRunTime,
        numberOfEpisodes,
        numberOfSeasons,
        voteAverage,
        voteCount
      ];
}
