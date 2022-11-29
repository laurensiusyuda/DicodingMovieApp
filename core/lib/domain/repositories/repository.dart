import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:movie/domain/entities/movie_entities/movie_detail.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_entities/tv.dart';
import 'package:tv/domain/entities/tv_entities/tv_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getNowPlayingMovies();
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(int id);
  Future<Either<Failure, List<MovieEntity>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query);
  Future<Either<Failure, String>> saveMovieWatchlist(MovieDetailEntity movie);
  Future<Either<Failure, String>> removeMovieWatchlist(MovieDetailEntity movie);
  Future<bool> isAddedToWatchlistMovies(int id);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<MovieEntity>>> getWatchlistMovies();
  Future<Either<Failure, List<TvEntity>>> getPopularTv();
  Future<Either<Failure, List<TvEntity>>> getTopRatedTv();
  Future<Either<Failure, List<TvEntity>>> getNowPlayingTv();
  Future<Either<Failure, List<TvEntity>>> searchTv(String query);
  Future<Either<Failure, TvDetailEntity>> getTvDetail(int id);
  Future<Either<Failure, List<TvEntity>>> getTvRecommendations(int id);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetailEntity tv);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetailEntity tv);
  Future<Either<Failure, List<TvEntity>>> getWatchlistTv();
}
