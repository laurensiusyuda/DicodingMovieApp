import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/genre.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String lastAirDate;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props {
    return [
      backdropPath,
      firstAirDate,
      genres,
      id,
      lastAirDate,
      name,
      originalName,
      overview,
      posterPath,
      status,
      tagline,
      voteAverage,
      voteCount,
    ];
  }
}
