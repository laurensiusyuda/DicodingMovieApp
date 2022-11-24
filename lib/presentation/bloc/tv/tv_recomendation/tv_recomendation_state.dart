import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv_entities/tv.dart';

abstract class RecommendationTvState extends Equatable {
  const RecommendationTvState();

  @override
  List<Object> get props => [];
}

class RecommendationTvEmpty extends RecommendationTvState {}

class RecommendationTvLoading extends RecommendationTvState {}

class RecommendationTvError extends RecommendationTvState {
  final String message;

  const RecommendationTvError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationTvLoaded extends RecommendationTvState {
  final List<Tv> result;

  const RecommendationTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
