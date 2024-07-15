import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/courses/data/model/models.dart';
import 'package:tm_school/features/courses/domain/repository/repository.dart';

class GetCommentsUseCase implements UseCase<List<CommentModel>, NoParams> {
  final String videoId;
  final CoursesRepository _repository;

  GetCommentsUseCase({
    required this.videoId,
    required CoursesRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<Failure, List<CommentModel>>> call(NoParams param) async {
    return await _repository.getComments(
      videoId: videoId,
    );
  }
}
