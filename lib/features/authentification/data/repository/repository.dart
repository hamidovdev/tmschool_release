// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tm_school/core/either/either.dart';
import 'package:tm_school/core/failure/failure.dart';
import 'package:tm_school/features/authentification/data/data_source/data_sourse.dart';
import 'package:tm_school/features/authentification/data/model/login_model.dart';
import 'package:tm_school/features/authentification/data/model/model.dart';
import 'package:tm_school/features/authentification/domain/repository/repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, UserInfo>> register(RegisterModel model) async {
    try {
      final response = await dataSource.register(model);
      print("Repository data $response");
      return Right(response);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<GetCityDataModel>>> cityNames(int id) async {
    try {
      final response = await dataSource.cityModel(id);
      return Right(response);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<GetRegionNameModel>>> regionNames(int id) async {
    try {
      final response = await dataSource.regionModel();
      return Right(response);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserInfo>> verificationSms(UserInfo userInfo) async {
    try {
      final response = await dataSource.verificationSms(userInfo);
      return Right(response);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(
      String phoneNumber, String password) async {
    try {
      final response = await dataSource.login(phoneNumber, password);
      return Right(response);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final response = await dataSource.logout();
      return Right(response);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, bool>> delete()async {
    try {
      final response = await dataSource.delete();
      return Right(response);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }
}
