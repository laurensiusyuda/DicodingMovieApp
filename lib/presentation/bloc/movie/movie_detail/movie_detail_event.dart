import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class EventLoadDetailMovie extends DetailMovieEvent {
  final int id;

  EventLoadDetailMovie({required this.id});

  @override
  List<Object?> get props => [id];
}

class EventAddWatchlist extends DetailMovieEvent {
  final MovieDetail movie;

  EventAddWatchlist({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}

class EventRemoveWatchlist extends DetailMovieEvent {
  final MovieDetail movie;

  EventRemoveWatchlist({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}
