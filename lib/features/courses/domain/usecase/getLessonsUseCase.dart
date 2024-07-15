import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/courses/data/model/models.dart';
import 'package:tm_school/features/courses/domain/repository/repository.dart';

class GetLessonsUseCase implements UseCase<List<LessonModel>, NoParams> {
  final String courseId;
  final CoursesRepository _repository;

  GetLessonsUseCase({
    required this.courseId,
    required CoursesRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<LessonModel>>> call(NoParams param) async {
    return await _repository.getLessons(
      courseId: courseId,
    );
  }
}
