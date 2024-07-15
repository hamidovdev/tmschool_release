import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/core/exception/exception.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/features/dashboard/data/model/models.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';

abstract class DashboardDataSource {
  Future<DashAuthData> getUserInfo();
  Future<List<NewsEntity>> getNews();
  Future<List<CoursesEntity>> getCourses();
  Future<bool> joinCourse({
    required String newsId,
  });
  Future<int> percentage({
    required String courseId,
    required String lessonId,
    required String videoId,
  });
  factory DashboardDataSource() => _DashboardDataSource();
}

class _DashboardDataSource implements DashboardDataSource {
  final dio = ins<Dio>();
  @override
  Future<DashAuthData> getUserInfo() async {
    try {
      final token = ins<SharedPreferences>().getString("token");
      final id = ins<SharedPreferences>().getInt("id");
      print("$id $token");
      Response response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/profile/$id",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("keldi  ${response.data}");
      return DashAuthData.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        print(e.error);
        
      }
      throw ServerException(
        errorMessage: "",
        errorCode: "",
      );
    }
  }

  @override
  Future<List<NewsEntity>> getNews() async {
    try {
      final token = ins<SharedPreferences>().getString("token");

      Response response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/newss",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      List<NewsModel> newsList = (response.data["data"] as List)
          .map(
            (e) => NewsModel.fromJson(
              e,
            ),
          )
          .toList();
      return (newsList.map((e) => e.toEntity)).toList();
    } catch (e) {
      throw ServerException(
        errorMessage: "",
        errorCode: "",
      );
    }
  }

  @override
  Future<List<CoursesEntity>> getCourses() async {
    try {
      final token = ins<SharedPreferences>().getString("token");
      Response response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/courses",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("Datalar ${response.data}");
      int per = 0;

      List<CourseModel> newsList = (response.data["data"] as List)
          .map(
            (e) => CourseModel.fromJson(
              e,
            ),
          )
          .toList();
      return (newsList.map((e) => e.toEntity)).toList();
    } catch (e) {
      throw ServerException(
        errorMessage: "",
        errorCode: "",
      );
    }
  }

  @override
  Future<bool> joinCourse({required String newsId}) async {
    final token = ins<SharedPreferences>().getString("token");

    try {
      print("Join coursega keldi $newsId");
      Response response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/newss/join/${(int.parse(newsId) + 1).toString()}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("Response ${response.data}");
      return true;
    } catch (e) {
      throw ServerException(errorMessage: "", errorCode: "");
    }
  }

  @override
  Future<int> percentage(
      {required String courseId,
      required String lessonId,
      required String videoId}) async {
    final token = ins<SharedPreferences>().getString("token");

    try {
      print("Foizga keldi");
      Response response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/percentage",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "video_id": int.parse(videoId),
          "lesson_id": int.parse(lessonId),
          "course_id": int.parse(courseId),
        },
      );
      print("Foizdan kelgan data $response");
      return response.data["percentage"] as int;
    } catch (e) {
      throw const ServerFailure();
    }
  }
}
