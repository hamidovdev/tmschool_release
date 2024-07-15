import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/features/saved/data/model/models.dart';

abstract class SavedDataSource {
  Future<List<SavedModel>> getSaveds();

  factory SavedDataSource() => _DataSourceImpl();
}

class _DataSourceImpl implements SavedDataSource {
  @override
  Future<List<SavedModel>> getSaveds() async {
    try {
      final dio = ins<Dio>();
      final token = ins<SharedPreferences>().getString("token");

      Response response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/saved-lessons/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("Saved datalar => ${response.data}");
      if (response.data["messages"] != null) {
        return [];
      }
      return (response.data["data"] as List)
          .map(
            (e) => SavedModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      throw ServerFailure();
    }
  }
}
