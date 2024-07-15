import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/dashboard/data/model/models.dart';
import 'package:tm_school/features/dashboard/data/repository/repository.dart';
import 'package:tm_school/features/dashboard/domain/repository/repository.dart';

class GetUserInfoUseCase implements UseCase<DashAuthData, NoParams> {
  final DashboardRepository _repository;

  GetUserInfoUseCase({required DashboardRepositoryImpl repository})
      : _repository = repository;
  @override
  Future<Either<ServerFailure, DashAuthData>> call(NoParams param) async {
    return await _repository.getUserInfo();
  }
}
