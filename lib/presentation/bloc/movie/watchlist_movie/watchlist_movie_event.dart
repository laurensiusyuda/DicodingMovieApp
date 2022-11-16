import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
  @override
  List<Object> get props => [];
}

class FetchWatchlistMovieEvent extends WatchlistMovieEvent {}

class FetchStatusMovieEvent extends WatchlistMovieEvent {
  final int id;
  const FetchStatusMovieEvent(this.id);
  @override
  List<Object> get props => [id];
}

class AddItemMovieEvent extends WatchlistMovieEvent {
  final MovieDetail result;
  const AddItemMovieEvent(this.result);
  @override
  List<Object> get props => [result];
}

class RemoveItemMovieEvent extends WatchlistMovieEvent {
  final MovieDetail result;
  const RemoveItemMovieEvent(this.result);
  @override
  List<Object> get props => [result];
}
