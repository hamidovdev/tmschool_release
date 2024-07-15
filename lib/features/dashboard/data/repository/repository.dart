import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/dashboard/data/datasource/datasource.dart';
import 'package:tm_school/features/dashboard/data/model/models.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';
import 'package:tm_school/features/dashboard/domain/repository/repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource _dataSource;

  DashboardRepositoryImpl({required DashboardDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<ServerFailure, List<CoursesEntity>>> getCourses() async {
    try {
      final data = await _dataSource.getCourses();
      return Right(data);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<NewsEntity>>> getNews() async {
    try {
      final data = await _dataSource.getNews();
      return Right(data);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, DashAuthData>> getUserInfo() async {
    try {
      final data = await _dataSource.getUserInfo();
      return Right(data);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, bool>> joinCourse({required newsId}) async {
    try {
      final data = await _dataSource.joinCourse(newsId: newsId);
      return Right(data);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, int>> percentage({
    required String courseId,
    required String lessonId,
    required String videoId,
  }) async {
    try {
      final data = await _dataSource.percentage(
        courseId: courseId,
        lessonId: lessonId,
        videoId: videoId,
      );
      return Right(data);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
}
