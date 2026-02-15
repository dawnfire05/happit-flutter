import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_code.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server({required String message}) = ServerFailure;
  const factory Failure.network({required String message}) = NetworkFailure;
  const factory Failure.unknown({required String message}) = UnknownFailure;
}

String failureToMessage(Failure failure) {
  return switch (failure) {
    ServerFailure(:final message) => message,
    NetworkFailure(:final message) => message,
    UnknownFailure(:final message) => message,
  };
}

Failure mapExceptionToFailure(Object e) {
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return Failure.network(message: e.message ?? '네트워크 오류가 발생했습니다.');
      case DioExceptionType.badResponse:
        final data = e.response?.data;
        final errorCode = data is Map ? data['errorCode']?.toString() : null;
        final message = errorCodeToMessage(errorCode) ??
            (data is Map ? data['message']?.toString() : null) ??
            '서버 오류가 발생했습니다. (${e.response?.statusCode})';
        return Failure.server(message: message);
      default:
        return Failure.unknown(message: e.message ?? e.toString());
    }
  }
  return Failure.unknown(message: e.toString());
}
