import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/courses/data/model/models.dart';
import 'package:tm_school/features/courses/domain/repository/repository.dart';

class GetVideosUseCase implements UseCase<List<VideoModel>, NoParams> {
  final String lessonId;
  final CoursesRepository _repository;

  GetVideosUseCase(
      {required this.lessonId, required CoursesRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<VideoModel>>> call(NoParams param) async {
    return await _repository.getVideos(
      lessonId: lessonId,
    );
  }
}
