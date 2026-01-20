import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/failure.dart';
import 'package:lab_2/core/network/api_exception.dart';
import 'package:lab_2/data/datasource/auth_api.dart';
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
  Future<Either<Failure,Unit>> login(String id, String password) async {
    try {
      final result = await _api.login(id);
      debugPrint("hehehe : ${result.toString()}");
      if (result['password'] != password) {
        return left(const AuthFailure(AppString.wrongPasswordMessage));
      }
      _controller.add(AuthenticationStatus.authenticated);
      return right(unit);
    } on ApiException catch (e) {
      return left(NetworkFailure(e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  Future<Either<Failure,bool>> isAvailable(String id) async {
    try {
      final result = await _api.checkIdExists(id);
      return right(result == null);
    } on ApiException catch (e) {
      return left(NetworkFailure(e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  Future<Either<Failure,Unit>> signUp(String id, String password) async {
    try {
      final user = UserProfile(id: id, name: id, password: password);
      final result = await _api.signUp(user);
      return result.containsKey("id") ? right(unit) : left(const AuthFailure(AppString.undefinedMessage));
    } on ApiException catch (e) {
      return left(NetworkFailure(e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  Future<Either<Failure,Unit>> updateProfile(
    Map<String, Object?> userInfo,
  ) async {
    try {
      final result = await _api.updateProfile(userInfo);
      return result.containsKey("id") ? right(unit) : left(const AuthFailure(AppString.undefinedMessage));
    } on ApiException catch (e) {
      return left(NetworkFailure(e.message));
    } catch (_) {
      return left(const UnknownFailure());
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
