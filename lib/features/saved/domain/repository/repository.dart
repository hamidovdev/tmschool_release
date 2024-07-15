import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/saved/data/model/models.dart';

abstract class SavedRepository {
  Future<Either<ServerFailure, List<SavedModel>>> getSaveds();
}
