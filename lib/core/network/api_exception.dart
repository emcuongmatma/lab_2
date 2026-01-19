import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});
}

ApiException mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ApiException('Kết nối quá lâu');
    case DioExceptionType.receiveTimeout:
      return ApiException('Server không phản hồi');
    case DioExceptionType.badResponse:
      return ApiException(
        e.response?.data['message'] ?? 'Tài khoản hoặc mật khẩu không đúng',
        statusCode: e.response?.statusCode,
      );
    default:
      return ApiException('Lỗi không xác định');
  }
}
