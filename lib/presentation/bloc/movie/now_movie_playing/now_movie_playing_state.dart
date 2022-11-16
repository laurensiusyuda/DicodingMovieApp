import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieEmpty extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieLoaded extends NowPlayingMovieState {
  final List<Movie> result;

  const NowPlayingMovieLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  const NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}
