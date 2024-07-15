import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/dashboard/data/repository/repository.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';
import 'package:tm_school/features/dashboard/domain/repository/repository.dart';

class GetNewsUseCase implements UseCase<List<NewsEntity>, NoParams> {
  final DashboardRepository _repository;

  GetNewsUseCase({required DashboardRepositoryImpl repository})
      : _repository = repository;
  @override
  Future<Either<ServerFailure, List<NewsEntity>>> call(NoParams param) async {
    return await _repository.getNews();
  }
}
