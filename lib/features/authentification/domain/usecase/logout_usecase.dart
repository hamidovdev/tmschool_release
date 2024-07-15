// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/authentification/domain/repository/repository.dart';

class LogOutUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  LogOutUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams param) async {
    if (param is LogOutParam) {
      final result = await repository.logout();
      return result;
    }else if(param is DeleteAccauntParam){ 
      final result = await repository.delete();
      return result;
    }
    throw UnimplementedError();
  }
}

class LogOutParam extends NoParams {}

class DeleteAccauntParam extends NoParams {}
