// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/authentification/data/model/model.dart';
import 'package:tm_school/features/authentification/domain/repository/repository.dart';

class SignInUseCase implements UseCase<UserInfo, NoParams> {
  final AuthRepository repository;
  SignInUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserInfo>> call(NoParams param) async {
    if (param is RegisterParam) {
      final response = await repository.register(param.model);
      return response;
    } else if (param is VerificationSmsParam) {
      final response = await repository.verificationSms(param.userInfo);
      return response;
    }
    throw UnimplementedError();
  }
}

class RegisterParam extends NoParams {
  final RegisterModel model;
  RegisterParam({
    required this.model,
  });
}

class VerificationSmsParam extends NoParams {
  final UserInfo userInfo;
  VerificationSmsParam({
    required this.userInfo,
  });
}
