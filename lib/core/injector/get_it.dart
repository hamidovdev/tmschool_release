import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/features/authentification/data/data_source/data_sourse.dart';
import 'package:tm_school/features/authentification/data/repository/repository.dart';
import 'package:tm_school/features/authentification/domain/usecase/city_usecase.dart';
import 'package:tm_school/features/authentification/domain/usecase/login_usecase.dart';
import 'package:tm_school/features/authentification/domain/usecase/region_names.dart';
import 'package:tm_school/features/courses/data/datasource/datasource.dart';
import 'package:tm_school/features/courses/data/repository/repository.dart';
import 'package:tm_school/features/dashboard/data/datasource/datasource.dart';
import 'package:tm_school/features/dashboard/data/repository/repository.dart';
import 'package:tm_school/features/saved/data/datasource/datasource.dart';
import 'package:tm_school/features/saved/data/repository/repository.dart';

final ins = GetIt.I;

Future<void> getItInjector() async {
  ins.registerSingletonAsync(
    () async => SharedPreferences.getInstance(),
  );
  ins.registerSingletonAsync(
    () async => Dio(),
  );
  authUseCase();
  dashboardNameRepository();
  courseNameRepository();
  savedNameRepository();
}

authUseCase() {
  ins
    ..registerFactory(
      () => AuthRepositoryImpl(
        dataSource: ins(),
      ),
    )
    ..registerLazySingleton(
      () => AuthDataSource(),
    );
}

loginUseCase() {
  ins
    ..registerFactory(
      () => LoginUseCase(
        repository: ins(),
      ),
    )
    ..registerLazySingleton(
      () => AuthRepositoryImpl(
        dataSource: ins(),
      ),
    )
    ..registerLazySingleton(
      () => AuthDataSource(),
    );
}

regionNameUsecase() {
  ins
    ..registerFactory(
      () => RegionNameUsecase(
        repository: ins(),
      ),
    )
    ..registerLazySingleton(
      () => AuthRepositoryImpl(
        dataSource: ins(),
      ),
    )
    ..registerLazySingleton(
      () => AuthDataSource(),
    );
}

cityNameUsecase() {
  ins
    ..registerFactory(
      () => CityNameUsecase(
        repository: ins(),
      ),
    )
    ..registerLazySingleton(
      () => AuthRepositoryImpl(
        dataSource: ins(),
      ),
    )
    ..registerLazySingleton(
      () => AuthDataSource(),
    );
}

dashboardNameRepository() {
  ins
    ..registerFactory(
      () => DashboardRepositoryImpl(
        dataSource: ins(),
      ),
    )
    ..registerLazySingleton(
      () => DashboardDataSource(),
    );
}

courseNameRepository() {
  ins
    ..registerFactory(
      () => CoursesRepositoryImpl(
        coursesDataSource: ins(),
      ),
    )
    ..registerLazySingleton(
      () => CoursesDataSource(),
    );
}

savedNameRepository() {
  ins
    ..registerFactory(
      () => SavedRepositoryImpl(
        dataSource: ins(),
      ),
    )
    ..registerLazySingleton(
      () => SavedDataSource(),
    );
}
