import 'package:equatable/equatable.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailTvEvent extends DetailTvEvent {
  final int id;

  const FetchDetailTvEvent(this.id);

  @override
  List<Object> get props => [id];
}
