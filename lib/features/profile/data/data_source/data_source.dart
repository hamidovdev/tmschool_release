import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/core/exception/exception.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/features/profile/data/model/model.dart';
import 'package:tm_school/features/profile/data/model/region_ciyt_model.dart';
import 'package:tm_school/features/profile/data/model/update_model.dart';

abstract class ProfilDataSource {
  Future<UserProfile> getProfilData();
  Future<bool> updateProfile(UpdateModel updateModel);
  Future<List<RegionCityModel>> reionNames();
  Future<List<RegionCityModel>> cityNames(int id);

  factory ProfilDataSource() => _ProfilDataSource();
}

class _ProfilDataSource implements ProfilDataSource {
  @override
  Future<UserProfile> getProfilData() async {
    final dio = ins<Dio>();
    final shared = ins<SharedPreferences>().getString("token");
    final id = ins<SharedPreferences>().getInt("id");

    try {
      final response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/profile/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $shared',
          },
        ),
      );
      final result = response.data;
      return UserProfile.fromJson(result);
    } catch (e) {
      throw ServerException(
          errorMessage: "errorMessage", errorCode: "errorCode");
    }
  }

  @override
  Future<bool> updateProfile(UpdateModel updateModel) async {
    final dio = ins<Dio>();
    final id = ins<SharedPreferences>().getInt("id");
    final shared = ins<SharedPreferences>().getString("token");

    try {
      final response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/profile-update/$id",
        data: await updateProfil(updateModel),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $shared',
          },
        ),
      );
      final result = response.data;
      print(id);
      print(result);
      return true;
    } catch (e) {
      print(e);
      throw ServerException(
        errorMessage: "errorMessage",
        errorCode: "errorCode",
      );
    }
  }

  @override
  Future<List<RegionCityModel>> reionNames() async {
    final dio = ins<Dio>();
    try {
      final response =
          await dio.get("https://test.teacher-muzaffar.com/api/v1/regions");
      final result = response.data["data"];
      final ls =
          (result as List).map((e) => RegionCityModel.fromJson(e)).toList();

      return ls;
    } catch (e) {
      print(e);
      throw ServerException(
          errorMessage: "errorMessage", errorCode: "errorCode");
    }
  }
  @override
  Future<List<RegionCityModel>> cityNames(int id) async {
    final dio = ins<Dio>();
    try {
      final response =
          await dio.get("https://test.teacher-muzaffar.com/api/v1/cities/$id");
      final result = response.data["data"];
      final ls =
          (result as List).map((e) => RegionCityModel.fromJson(e)).toList();

      return ls;
    } catch (e) {
      print(e);
      throw ServerException(
          errorMessage: "errorMessage", errorCode: "errorCode");
    }
  }
}
