import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/features/courses/data/model/models.dart';

abstract class CoursesDataSource {
  Future<List<LessonModel>> getLessons({required courseId});
  Future<List<VideoModel>> getVideos({required lessonId});
  Future<List<CommentModel>> getComments({required videoId});
  Future<CommentModel> sendComment({required message, required videoId});
  Future<bool> clickBtns({required param, required videoId});

  factory CoursesDataSource() => _CourseDataaSource();
}

class _CourseDataaSource implements CoursesDataSource {
  // final header = {
  //   'Authorization':
  //       'Bearer ${ins<SharedPreferences>().getString("token")}',
  // };
  final dio = ins<Dio>();
  @override
  Future<bool> clickBtns({required param, required videoId}) async {
    final token = ins<SharedPreferences>().getString("token");

    try {
      final data = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/saved-lessons-store/$videoId",
        data: {
          "saved": param == "save" ? 0 : (param == "noSave" ? 1 : null),
          "liked": param == "like" ? 0 : (param == "disLike" ? 1 : null),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return true;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<CommentModel>> getComments({required videoId}) async {
    final token = ins<SharedPreferences>().getString("token");

    try {
      print("VideoId $videoId");
      Response response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/comments/$videoId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("Comentlar keldi ${response.data}");

      return (response.data["data"] as List)
          .map(
            (e) => CommentModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      print("Xatolik otildi***** $e");
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<LessonModel>> getLessons({required courseId}) async {
    final token = ins<SharedPreferences>().getString("token");
    try {
      print("CourseId $courseId");
      Response response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/lessons/$courseId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print('Kelgan lessonlar${response.data}');
      return (response.data["data"] as List)
          .map(
            (e) => LessonModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      print(e);
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<VideoModel>> getVideos({required lessonId}) async {
    final token = ins<SharedPreferences>().getString("token");

    try {
      Response response = await dio.get(
        "https://test.teacher-muzaffar.com/api/v1/videos/$lessonId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return (response.data["data"] as List)
          .map(
            (e) => VideoModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<CommentModel> sendComment({required message, required videoId}) async {
    final token = ins<SharedPreferences>().getString("token");

    try {
      Response response = await dio.post(
        "https://test.teacher-muzaffar.com/api/v1/comments-store/$videoId",
        data: {"comment": message.toString()},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return CommentModel.fromJson(response.data["comment"]);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
