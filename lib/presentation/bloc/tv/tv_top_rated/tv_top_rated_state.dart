import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<Tv> result;

  const TopRatedTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
