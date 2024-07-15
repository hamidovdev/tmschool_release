// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/authentification/data/model/model.dart';
import 'package:tm_school/features/authentification/domain/repository/repository.dart';

class CityNameUsecase implements UseCase<List<GetCityDataModel>, NoParams> {
  final AuthRepository repository;
  CityNameUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<GetCityDataModel>>> call(NoParams param) async {
    if (param is CityNameAuthParam) {
      final result = await repository.cityNames(param.id);
      return result;
    }
    throw UnimplementedError();
  }
}

class CityNameAuthParam extends NoParams {
  final int id;
  CityNameAuthParam({
    required this.id,
  });
}

