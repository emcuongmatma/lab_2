import 'package:fpdart/fpdart.dart';
import 'package:lab_2/common/failure.dart';
import 'package:lab_2/data/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repo;
  AuthUseCase(this.repo);
  Future<Either<Failure, Unit>> login({
    required String phone,
    required String password,
  }) {
    return repo.login(phone, password);
  }
  Future<Either<Failure, Unit>> signup({
    required String phone,
    required String password,
  }) {
    return repo.signUp(phone, password);
  }
  Future<Either<Failure, bool>> checkAvailable({
    required String phone,
  }) {
    return repo.isAvailable(phone);
  }
  Future<Either<Failure, Unit>> updateProfile({
    required Map<String, Object?> userInfo
  }) {
    return repo.updateProfile(userInfo);
  }
}