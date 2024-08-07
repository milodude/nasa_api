import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage});

  @override
  List<Object?> get props => [super.errorMessage];
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure({required super.errorMessage});

  @override
  List<Object?> get props => [super.errorMessage];
}

class LocalServerFailure extends Failure {
  const LocalServerFailure({required super.errorMessage});

  @override
  List<Object?> get props => [super.errorMessage];
}
