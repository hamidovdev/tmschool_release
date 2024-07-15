import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/saved/data/datasource/datasource.dart';
import 'package:tm_school/features/saved/data/model/models.dart';
import 'package:tm_school/features/saved/domain/repository/repository.dart';

class SavedRepositoryImpl implements SavedRepository {
  final SavedDataSource _dataSource;

  SavedRepositoryImpl({required SavedDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<ServerFailure, List<SavedModel>>> getSaveds() async {
    try {
      final data = await _dataSource.getSaveds();
      return Right(data);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
}
