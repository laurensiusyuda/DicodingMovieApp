import 'package:equatable/equatable.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class StateMovieDetailInitial extends DetailMovieState {}

class StateMovieDetailLoading extends DetailMovieState {}

class StateMovieDetailLoaded extends DetailMovieState {}

class StateWatchlistFailure extends DetailMovieState {
  final String message;

  const StateWatchlistFailure(this.message);
}

class StateWatchlistSuccess extends DetailMovieState {
  final String message;

  const StateWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class StateLoadDetailMovieFailure extends DetailMovieState {
  final String message;

  StateLoadDetailMovieFailure({
    this.message = "",
  });
}

class StateLoadMovieRecommendationFailure extends DetailMovieState {
  final String message;

  StateLoadMovieRecommendationFailure({
    this.message = "",
  });
}
