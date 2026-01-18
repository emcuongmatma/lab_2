import 'package:flutter/material.dart';
import 'package:lab_2/data/api/auth_api.dart';
import 'package:lab_2/data/model/user_profile.dart';

class AuthRepository {
  final AuthApi api;

  AuthRepository(this.api);

  Future<bool> login(String id, String password) async {
    try {
      final result = await api.login(id);
      if(result == null) throw "Tài khoản không tồn tại";
      if (password != result.password) throw "Mật khẩu không đúng";
      return true;
    } catch(e) {
      debugPrint("hehehe: $e");
      return false;
    }
  }

  Future<bool> isAvailable(String id) async {
    try {
      await api.isAvailable(id);
      return false;
    } catch(e) {
      debugPrint("hehehe: $e");
      return true;
    }
  }

  Future<bool> signUp(String id, String password) async {
    try {
      final user = UserProfile(id: id, name: id, password: password);
      final result = await api.signUp(user);
      return result;
    } catch(e) {
      debugPrint("hehehe: $e");
      return false;
    }
  }
}
