import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/courses/data/model/models.dart';

abstract class CoursesRepository {
  Future<Either<ServerFailure, List<LessonModel>>> getLessons({
    required String courseId,
  });
  Future<Either<ServerFailure, List<VideoModel>>> getVideos({
    required String lessonId,
  });
  Future<Either<ServerFailure, List<CommentModel>>> getComments({
    required String videoId,
  });
  Future<Either<ServerFailure, bool>> clickBtn({
    required String videoId,
    required String param,
  });
  Future<Either<ServerFailure, CommentModel>> sendComment({
    required String videoId,
    required String message,
  });
}
