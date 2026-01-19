class ApiResponse<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final bool success;

  ApiResponse.success(this.data, {this.message, this.statusCode})
      : success = true;

  ApiResponse.failure(this.message, {this.statusCode})
      : success = false,
        data = null;
}
