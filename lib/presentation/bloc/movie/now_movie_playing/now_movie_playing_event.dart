import 'package:equatable/equatable.dart';

abstract class NowPlayingMovieEvent extends Equatable {
  const NowPlayingMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovieEvent extends NowPlayingMovieEvent {}
