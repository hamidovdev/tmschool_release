// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/authentification/data/model/login_model.dart';
import 'package:tm_school/features/authentification/data/model/model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserInfo>> register(RegisterModel model);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> delete();
  Future<Either<Failure, List<GetCityDataModel>>> cityNames(int id);
  Future<Either<Failure, List<GetRegionNameModel>>> regionNames(int id);
  Future<Either<Failure, UserInfo>> verificationSms(UserInfo userInfo);
  Future<Either<Failure, LoginModel>> login(String phoneNumber, String password);
  
  
}
