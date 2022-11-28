import 'package:equatable/equatable.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecommendationId extends MovieRecommendationEvent {
  final int id;

  const GetMovieRecommendationId(this.id);

  @override
  List<Object> get props => [id];
}
