import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/courses/data/datasource/datasource.dart';
import 'package:tm_school/features/courses/data/model/models.dart';
import 'package:tm_school/features/courses/domain/repository/repository.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesDataSource _coursesDataSource;

  CoursesRepositoryImpl({required CoursesDataSource coursesDataSource})
      : _coursesDataSource = coursesDataSource;
  @override
  Future<Either<ServerFailure, bool>> clickBtn(
      {required String videoId, required String param}) async {
    try {
      bool data =
          await _coursesDataSource.clickBtns(param: param, videoId: videoId);
      return Right(data);
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, List<CommentModel>>> getComments({
    required String videoId,
  }) async {
    try {
      final data = await _coursesDataSource.getComments(videoId: videoId);
      return Right(data);
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, List<LessonModel>>> getLessons({
    required String courseId,
  }) async {
    try {
      final data = await _coursesDataSource.getLessons(courseId: courseId);
      return Right(data);
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, List<VideoModel>>> getVideos({
    required String lessonId,
  }) async {
    try {
      final data = await _coursesDataSource.getVideos(lessonId: lessonId);
      return Right(data);
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ServerFailure, CommentModel>> sendComment(
      {required String videoId, required String message}) async {
    try {
      final data = await _coursesDataSource.sendComment(
        message: message,
        videoId: videoId,
      );
      return Right(data);
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
