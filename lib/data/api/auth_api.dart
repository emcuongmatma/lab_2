import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab_2/common/api.dart';
import 'package:lab_2/data/model/user_profile.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<UserProfile?> login(String id) async {
    final response = await dio.get("${API.AUTH}/$id");
    final data = response.data;
    return data != null ? UserProfile.fromJson(data) : null;
  }

  Future<Response<dynamic>> isAvailable(String id) async {
    final response = await dio.get("${API.AUTH}/$id");
    return response;
  }

  Future<bool> signUp(UserProfile profile) async {
    final response = await dio.post(API.AUTH,data: profile.toJson());
    final data = response.data;
    debugPrint("hehehe: $data");
    return data != null;
  }
}
