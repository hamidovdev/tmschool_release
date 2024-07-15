import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/saved/data/model/models.dart';
import 'package:tm_school/features/saved/domain/repository/repository.dart';

class SavedUseCase implements UseCase<List<SavedModel>, NoParams> {
  final SavedRepository _repository;

  SavedUseCase({required SavedRepository repository})
      : _repository = repository;
  @override
  Future<Either<Failure, List<SavedModel>>> call(NoParams param) async {
    final data = await _repository.getSaveds();
    return data;
  }
}
