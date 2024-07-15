import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/core/exception/exception.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/features/authentification/data/model/login_model.dart';
import 'package:tm_school/features/authentification/data/model/model.dart';

abstract class AuthDataSource {
  Future<UserInfo> register(RegisterModel model);
  Future<List<GetCityDataModel>> cityModel(int id);
  Future<List<GetRegionNameModel>> regionModel();
  Future<UserInfo> verificationSms(UserInfo user);
  Future<LoginModel> login(String phoneNumber, String password);
  Future<bool> logout();
  Future<bool> delete();
  factory AuthDataSource() => _AuthDataSource();
}

class _AuthDataSource implements AuthDataSource {
  @override
  Future<UserInfo> register(RegisterModel model) async {
    final dio = ins<Dio>();
    print(model);
    try {
      final response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/register",
        data: await toJson(model),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      final result = response.data;
      return UserInfo.fromJson(result);
    } catch (e) {
      if (e is DioException) {
        // Xato haqida ko'proq ma'lumot olish uchun
        print('Failed: ${e.response?.statusCode}');
        print('Error response: ${e.response?.data}');
      }
      print("Xatoooopooo $e ");
      return throw ServerException(errorMessage: "$e", errorCode: "errorCode");
    }
  }

  @override
  Future<List<GetCityDataModel>> cityModel(int id) async {
    final dio = ins<Dio>();
    try {
      final response =
          await dio.get("https://test.teacher-muzaffar.com/api/v1/cities/$id");
      final data = (response.data["data"]);
      final result =
          (data as List).map((e) => GetCityDataModel.fromJson(e)).toList();
      return result;
    } catch (e) {
      throw ServerException(errorMessage: "", errorCode: "");
    }
  }

  @override
  Future<List<GetRegionNameModel>> regionModel() async {
    final dio = ins<Dio>();

    final response =
        await dio.get("https://test.teacher-muzaffar.com/api/v1/regions");
    final data = (response.data["data"]);
    final result =
        (data as List).map((e) => GetRegionNameModel.fromJson(e)).toList();
    return result;
  }

  @override
  Future<UserInfo> verificationSms(UserInfo userInfo) async {
    final dio = ins<Dio>();
    try {
      final response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/verify_sms",
        data: {
          "mobil_number": userInfo.data.mobileNumber,
          "mobile_verify_code": userInfo.data.mobileVerifyCode,
        },
      );
      final result = response.data;
      print("Verify code $result");

      return UserInfo.fromJson(result);
    } catch (e) {
      print("XAtolik $e");
      return throw ServerException(
          errorMessage: "errorMessage", errorCode: "errorCode");
    }
  }

  @override
  Future<LoginModel> login(String phoneNumber, String password) async {
    final dio = ins<Dio>();
    try {
      final response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/login",
        data: {
          "mobil_number": phoneNumber,
          "password": password,
        },
      );
      final result = response.data;
      final bool success = result['success'];
      if (success) {
        return LoginModel.fromJson(result);
      }
      throw "Xatolik";
    } catch (e) {
      throw ServerException(
          errorMessage: "errorMessage", errorCode: "errorCode");
    }
  }

  @override
  Future<bool> logout() async {
    final dio = ins<Dio>();
    final shared = ins<SharedPreferences>().getString("token");
    try {
      final response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/logout/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $shared',
          },
        ),
      );
      final result = response.data;
      final message = result["message"];
      if (message == "" || message == null) {
        return throw ServerException(
          errorMessage: "errorMessage",
          errorCode: "errorCode",
        );
      }
      return true;
    } catch (e) {
      throw ServerException(
          errorMessage: "errorMessage", errorCode: "errorCode");
    }
  }

  @override
  Future<bool> delete() async {
    final dio = ins<Dio>();
    final shared = ins<SharedPreferences>().getString("token");
    try {
      final response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/delete_user",
        options: Options(
          headers: {
            'Authorization': 'Bearer $shared',
          },
        ),
      );
      return true;
    } catch (e) {
      throw ServerException(
        errorMessage: "errorMessage",
        errorCode: "errorCode",
      );
    }
  }
}
