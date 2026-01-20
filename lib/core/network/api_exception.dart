import 'package:dio/dio.dart';
import 'package:lab_2/common/app_string.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});
}

ApiException mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ApiException(AppString.timeoutMessage);
    case DioExceptionType.receiveTimeout:
      return ApiException(AppString.notResponseMessage);
    case DioExceptionType.badResponse:
      return ApiException(
        e.response?.data['message'] ?? AppString.wrongPhoneOrPassword,
        statusCode: e.response?.statusCode,
      );
    default:
      return ApiException(AppString.undefinedMessage);
  }
}
