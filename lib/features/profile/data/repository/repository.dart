// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/profile/data/data_source/data_source.dart';
import 'package:tm_school/features/profile/data/model/model.dart';
import 'package:tm_school/features/profile/data/model/region_ciyt_model.dart';
import 'package:tm_school/features/profile/data/model/update_model.dart';
import 'package:tm_school/features/profile/domain/repository/repository.dart';

class ProfilRepositoryImpl implements ProfilRepository {
  final ProfilDataSource dataSource;
  ProfilRepositoryImpl({
    required this.dataSource,
  });
  
  @override
  Future<Either<Failure, UserProfile>> getProfil() async {
    try {
      final result = await dataSource.getProfilData();
      return Right(result);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, bool>> updateProfil(UpdateModel updateModel)async {
    try {
      final result = await dataSource.updateProfile(updateModel);
      return Right(result);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<RegionCityModel>>> cityName(int id)async {
     try {
      final result = await dataSource.cityNames(id);
      return Right(result);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<RegionCityModel>>> regionName()async {
     try {
      final result = await dataSource.reionNames();
      return Right(result);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
}
