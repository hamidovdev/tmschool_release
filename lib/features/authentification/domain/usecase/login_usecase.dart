// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/authentification/data/model/login_model.dart';
import 'package:tm_school/features/authentification/domain/repository/repository.dart';

class LoginUseCase implements UseCase<LoginModel, NoParams> {
  final AuthRepository repository;
  LoginUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, LoginModel>> call(NoParams param) async {
    if (param is LoginParam) {
      final result = await repository.login(param.phoneNumber, param.password);
      return result;
    }
    throw UnimplementedError();
  }
}

class LoginParam extends NoParams {
  final String phoneNumber;
  final String password;
  LoginParam({
    required this.phoneNumber,
    required this.password,
  });
}
