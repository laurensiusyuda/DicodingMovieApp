import 'package:equatable/equatable.dart';

abstract class StateRequest extends Equatable {
  const StateRequest();

  @override
  List<Object> get props => [];
}

class Empty extends StateRequest {}

class Loading extends StateRequest {}

class Error extends StateRequest {
  final String message;
  const Error(this.message);
  @override
  List<Object> get props => [message];
}

class HasData extends StateRequest {
  final dynamic result;
  const HasData(this.result);
  @override
  List<Object> get props => [result];
}

class HasStatus extends StateRequest {
  final bool status;
  const HasStatus(this.status);
  @override
  List<Object> get props => [status];
}

class HasMessage extends StateRequest {
  final String message;
  const HasMessage(this.message);
  @override
  List<Object> get props => [message];
}
