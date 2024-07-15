import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/dashboard/data/repository/repository.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';
import 'package:tm_school/features/dashboard/domain/repository/repository.dart';

class GetCoursesUseCase implements UseCase<List<CoursesEntity>, NoParams> {
  final DashboardRepository _repository;

  GetCoursesUseCase({required DashboardRepositoryImpl repository})
      : _repository = repository;
  @override
  Future<Either<ServerFailure, List<CoursesEntity>>> call(
      NoParams param) async {
    return await _repository.getCourses();
  }
}
