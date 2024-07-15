import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/dashboard/domain/repository/repository.dart';

class ResultBoolUseCase implements UseCase<dynamic, Params> {
  final DashboardRepository _repository;

  ResultBoolUseCase({required DashboardRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, dynamic>> call(Params params) async {
    if (params is JoinCourseParam) {
      return await _repository.joinCourse(newsId: params.newsId);
    } else if (params is PercentageParam) {
      return await _repository.percentage(
        courseId: params.courseId,
        lessonId: params.lessonId,
        videoId: params.videoId,
      );
    } else {
      return throw UnimplementedError();
    }
  }
}

abstract class Params {}

class JoinCourseParam extends Params {
  final String newsId;

  JoinCourseParam({
    required this.newsId,
  });
}

class PercentageParam extends Params {
  final String courseId;
  final String lessonId;
  final String videoId;

  PercentageParam({
    required this.courseId,
    required this.lessonId,
    required this.videoId,
  });
}
