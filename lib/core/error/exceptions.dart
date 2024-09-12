import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'failure.dart';

class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class ErrorHandling {
  static Either<Failure, T> handleException<T>(exception) {
    if (exception is ServerException) {
      return const Left(ServerFailure('Server Failure', 500));
    } else if (exception is SocketException || exception is IOException) {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } else if (exception is HttpException) {
      return const Left(ServerFailure('Http Exception', 500));
    } else if (exception is FormatException) {
      return const Left(ServerFailure('Format Exception', 500));
    } else if (exception is DioException) {
      return _handleDioException(exception);
    } else {
      return Left(ServerFailure(exception.toString(), 500));
    }
  }

  static Either<Failure, T> _handleDioException<T>(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
        return Left(ConnectionFailure(ErrorType.connectionError.name));
      case DioExceptionType.sendTimeout:
        return const Left(ServerFailure('Send Timeout', 500));
      case DioExceptionType.receiveTimeout:
        return const Left(ServerFailure('Receive Timeout', 500));
      case DioExceptionType.connectionTimeout:
        return const Left(ServerFailure('Connection Timeout', 500));
      case DioExceptionType.cancel:
        return const Left(ServerFailure('Request Cancelled', 500));
      case DioExceptionType.badCertificate:
        return const Left(ServerFailure('Bad Certificate', 500));
      case DioExceptionType.badResponse:
        return Left(
          ServerFailure(
            exception.message ?? 'Unknown Dio Exception',
            exception.response?.statusCode ?? 400,
          ),
        );
      case DioExceptionType.unknown:
      default:
        return Left(
          ServerFailure(
            exception.message ?? 'Unknown Dio Exception',
            exception.response?.statusCode ?? 500,
          ),
        );
    }
  }
}

enum ErrorType {
  sendTimeout,
  receiveTimeout,
  other,
  connectionError,
  cancel,
  response,
  request,
  unknown,
}
