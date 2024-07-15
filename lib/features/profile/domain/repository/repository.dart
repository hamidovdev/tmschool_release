import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/profile/data/model/model.dart';
import 'package:tm_school/features/profile/data/model/region_ciyt_model.dart';
import 'package:tm_school/features/profile/data/model/update_model.dart';

abstract class ProfilRepository {
 Future<Either<Failure, UserProfile>> getProfil();  
 Future<Either<Failure, bool>> updateProfil(UpdateModel updateModel);  
 Future<Either<Failure, List<RegionCityModel>>> regionName();  
 Future<Either<Failure, List<RegionCityModel>>> cityName(int id);  
}