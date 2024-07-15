import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/dashboard/data/model/models.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';

abstract class DashboardRepository {
  Future<Either<ServerFailure, DashAuthData>> getUserInfo();
  Future<Either<ServerFailure, List<NewsEntity>>> getNews();
  Future<Either<ServerFailure, List<CoursesEntity>>> getCourses();
  Future<Either<ServerFailure, bool>> joinCourse({required String newsId});
  Future<Either<ServerFailure, int>> percentage({
    required String courseId,
    required String lessonId,
    required String videoId,
  });
}
