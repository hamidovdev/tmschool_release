// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/authentification/data/model/model.dart';
import 'package:tm_school/features/authentification/domain/repository/repository.dart';

class RegionNameUsecase implements UseCase<List<GetRegionNameModel>, NoParams> {
  final AuthRepository repository; 
  RegionNameUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<GetRegionNameModel>>> call(NoParams param) async{
    if (param is RegionNameParam) { 
        final result = await repository.regionNames(param.id); 
        return result;
      
    }
    throw UnimplementedError();
  }
  
}

class RegionNameParam extends NoParams{
  final int id;
  RegionNameParam({
    required this.id,
  });
  
}