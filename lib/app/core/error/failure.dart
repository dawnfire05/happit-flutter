import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server({required String message}) = ServerFailure;
  const factory Failure.network({required String message}) = NetworkFailure;
  const factory Failure.unknown({required String message}) = UnknownFailure;
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
        return Failure.server(
          message: e.response?.data?['message']?.toString() ??
              '서버 오류가 발생했습니다. (${e.response?.statusCode})',
        );
      default:
        return Failure.unknown(message: e.message ?? e.toString());
    }
  }
  return Failure.unknown(message: e.toString());
}
