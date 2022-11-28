import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends WatchlistEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends WatchlistEvent {
  final TvDetailEntity tvDetailEntity;

  const AddWatchlist(this.tvDetailEntity);

  @override
  List<Object> get props => [TvDetailEntity];
}

class RemoveFromWatchlist extends WatchlistEvent {
  final TvDetailEntity tvDetailEntity;

  const RemoveFromWatchlist(this.tvDetailEntity);

  @override
  List<Object> get props => [TvDetailEntity];
}

class WatchlistTv extends WatchlistEvent {
  @override
  List<Object> get props => [];
}
