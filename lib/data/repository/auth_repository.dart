import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_2/core/network/api_exception.dart';
import 'package:lab_2/core/network/api_response.dart';
import 'package:lab_2/data/api/auth_api.dart';
import 'package:lab_2/data/model/user_profile.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final AuthApi _api;

  AuthRepository(this._api);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<ApiResponse<UserProfile>> login(String id, String password) async {
    try {
      final result = await _api.login(id);
      debugPrint("hehehe : ${result.toString()}");
      if (result['password'] != password) {
        return ApiResponse.failure("Mật khẩu không đúng");
      }
      _controller.add(AuthenticationStatus.authenticated);
      return ApiResponse.success(UserProfile.fromJson(result));
    } on ApiException catch (e) {
      return ApiResponse.failure(e.message, statusCode: e.statusCode);
    }
  }

  Future<ApiResponse<bool>> isAvailable(String id) async {
    try {
      final result = await _api.checkIdExists(id);
      return ApiResponse.success(result == null);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<ApiResponse<UserProfile>> signUp(String id, String password) async {
    try {
      final user = UserProfile(id: id, name: id, password: password);
      final result = await _api.signUp(user);
      return ApiResponse.success(UserProfile.fromJson(result));
    } on ApiException catch (e) {
      return ApiResponse.failure(e.message, statusCode: e.statusCode);
    }
  }

  Future<ApiResponse<UserProfile>> updateProfile(
    Map<String, Object?> userInfo,
  ) async {
    try {
      final result = await _api.updateProfile(userInfo);
      return ApiResponse.success(UserProfile.fromJson(result));
    } on ApiException catch (e) {
      return ApiResponse.failure(e.message, statusCode: e.statusCode);
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
