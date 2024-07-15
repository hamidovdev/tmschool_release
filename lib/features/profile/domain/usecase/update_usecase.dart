// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/profile/data/model/update_model.dart';
import 'package:tm_school/features/profile/domain/repository/repository.dart';

class UpdateUseCase implements UseCase<bool, NoParams> {
  final ProfilRepository repository;
  UpdateUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams param) async {
    if (param is UpdateParam) {
      final result = await repository.updateProfil(param.updateModel);
      return result;
    }
    throw UnimplementedError();
  }
}

class UpdateParam extends NoParams {
  final UpdateModel updateModel;
  UpdateParam({
    required this.updateModel,
  });
}
