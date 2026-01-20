import 'package:get_it/get_it.dart';
import 'package:lab_2/core/network/dio.dart';
import 'package:lab_2/data/datasource/auth_api.dart';
import 'package:lab_2/data/repository/auth_repository.dart';
import 'package:lab_2/domain/usecase/auth_usecase.dart';

final locator = GetIt.instance;
void init() {
  locator.registerLazySingleton(() => DioClient.create());
  locator.registerLazySingleton(() => AuthApi(locator()));
  locator.registerLazySingleton<AuthRepository>(()=>AuthRepository(locator()));
  locator.registerLazySingleton<AuthUseCase>(()=>AuthUseCase(locator()));
}