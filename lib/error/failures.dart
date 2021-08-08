import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

// General failures
class AuthentificationFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmailFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
