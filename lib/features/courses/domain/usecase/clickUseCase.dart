import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/courses/domain/repository/repository.dart';

class ClickBtnsUseCase implements UseCase<bool, NoParams> {
  final CoursesRepository _repository;
  final String paramm;
  final String videoId;

  ClickBtnsUseCase({
    required CoursesRepository repository,
    required this.paramm,
    required this.videoId,
  }) : _repository = repository;
  @override
  Future<Either<Failure, bool>> call(NoParams param) async {
    return await _repository.clickBtn(
      videoId: videoId,
      param: paramm,
    );
  }
}
