import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic code;

  const Failure(this.message, this.code);

  @override
  List<Object> get props => [message, code];

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(String message, dynamic code) : super(message, code);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message, 404);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message, 404);
}

class FormatException extends Failure {
  const FormatException(String message) : super(message, 404);
}
