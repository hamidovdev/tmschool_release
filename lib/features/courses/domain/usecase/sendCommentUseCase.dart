import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/courses/data/model/models.dart';
import 'package:tm_school/features/courses/domain/repository/repository.dart';

class SendCommentUseCase implements UseCase<CommentModel, NoParams> {
  final String videoId;
  final String message;
  final CoursesRepository _repository;

  SendCommentUseCase({
    required this.videoId,
    required this.message,
    required CoursesRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<Failure, CommentModel>> call(NoParams param) async {
    return await _repository.sendComment(
      videoId: videoId,
      message: message,
    );
  }
}
