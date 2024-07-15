// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/profile/data/model/model.dart';
import 'package:tm_school/features/profile/domain/repository/repository.dart';

class ProfilUseCase implements UseCase<UserProfile, NoParams> {
  final ProfilRepository repository;
  ProfilUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserProfile>> call(NoParams param) async {
    if (param is GetProfilParam) {
      final result = await repository.getProfil();
      return result;
    }
    throw UnimplementedError();
  }
}

class GetProfilParam extends NoParams {}
