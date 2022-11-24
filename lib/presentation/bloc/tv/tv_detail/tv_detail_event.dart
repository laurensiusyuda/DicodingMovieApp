import 'package:ditonton/domain/entities/tv_entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();
}

class EventLoadDetailTvSeries extends DetailTvSeriesEvent {
  final int id;

  EventLoadDetailTvSeries({required this.id});

  List<Object?> get props => [id];
}

class EventAddWatchlist extends DetailTvSeriesEvent {
  final TvDetail tvSeries;

  EventAddWatchlist({
    required this.tvSeries,
  });

  List<Object?> get props => [tvSeries];
}

class EventRemoveWatchlist extends DetailTvSeriesEvent {
  final TvDetail tvSeries;

  EventRemoveWatchlist({
    required this.tvSeries,
  });

  List<Object?> get props => [tvSeries];
}
