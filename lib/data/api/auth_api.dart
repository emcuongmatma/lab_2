import 'package:dio/dio.dart';
import 'package:lab_2/common/api.dart';
import 'package:lab_2/core/network/api_exception.dart';
import 'package:lab_2/data/model/user_profile.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<Map<String, dynamic>> login(String id) async {
    try {
      final response = await dio.get("${API.AUTH}/$id");
      return response.data;
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<Map<String, dynamic>?> checkIdExists(String id) async {
    try {
      final response = await dio.get("${API.AUTH}/$id");
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw mapDioError(e);
    }
  }

  Future<Map<String, dynamic>> signUp(UserProfile profile) async {
    try {
      final response = await dio.post(API.AUTH,data: profile.toJson());
      return response.data;
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<Map<String, dynamic>> updateProfile(Map<String,Object?> userInfo) async {
    try {
      final id = userInfo["id"];
      final response = await dio.put("${API.AUTH}/$id",data: userInfo);
      return response.data;
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
