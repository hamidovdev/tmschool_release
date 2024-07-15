// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/profile/data/model/region_ciyt_model.dart';
import 'package:tm_school/features/profile/domain/repository/repository.dart';

class RegionCityNameUseCase
    implements UseCase<List<RegionCityModel>, NoParams> {
  final ProfilRepository repository;
  RegionCityNameUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<RegionCityModel>>> call(NoParams param) async {
    if (param is RegionNameParam) {
      final result = await repository.regionName();
      return result;
    } else if (param is CityNameProfilParam) {
      final result = await repository.cityName(param.id);
      return result;
    }
    throw UnimplementedError();
  }
}

class RegionNameParam extends NoParams {}

class CityNameProfilParam extends NoParams {
  final int id;
  CityNameProfilParam({
    required this.id,
  });
}
