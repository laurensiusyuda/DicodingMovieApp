import 'package:equatable/equatable.dart';

abstract class TvRecommendationEvent extends Equatable {
  const TvRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetTvRecommendationId extends TvRecommendationEvent {
  final int id;

  const GetTvRecommendationId(this.id);

  @override
  List<Object> get props => [id];
}
