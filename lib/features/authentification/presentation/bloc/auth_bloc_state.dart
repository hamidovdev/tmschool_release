// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_bloc_bloc.dart';

class AuthBlocState extends Equatable {
  final RegisterStatus registerStatus;
  final UserInfo userinfo;
  final int genderExpansiontileIndex;
  final List<GetCityDataModel> city;
  final String cityName;
  final List<GetRegionNameModel> regions;
  final String regionName;
  final Status status;
  const AuthBlocState({
    required this.registerStatus,
    required this.userinfo,
    required this.genderExpansiontileIndex,
    required this.city,
    required this.cityName,
    required this.regions,
    required this.regionName,
    required this.status,
  });


  @override
  
  List<Object> get props {
    return [
      registerStatus,
      userinfo,
      genderExpansiontileIndex,
      city,
      cityName,
      regions,
      regionName,
      status,
    ];
  }

  AuthBlocState copyWith({
    RegisterStatus? registerStatus,
    UserInfo? userinfo,
    int? genderExpansiontileIndex,
    List<GetCityDataModel>? city,
    String? cityName,
    List<GetRegionNameModel>? regions,
    String? regionName,
    Status? status,
  }) {
    return AuthBlocState(
      registerStatus: registerStatus ?? this.registerStatus,
      userinfo: userinfo ?? this.userinfo,
      genderExpansiontileIndex: genderExpansiontileIndex ?? this.genderExpansiontileIndex,
      city: city ?? this.city,
      cityName: cityName ?? this.cityName,
      regions: regions ?? this.regions,
      regionName: regionName ?? this.regionName,
      status: status ?? this.status,
    );
  }
}

enum Status{
  unknown, unAuth, authen,
}

enum RegisterStatus{ 
  loading, success
}
