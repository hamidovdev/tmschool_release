// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profil_bloc.dart';

class ProfilState extends Equatable {
  final List<RegionCityModel> regionNames;
  final List<RegionCityModel> cityNames;
  final UserProfile userProfile;
  final ProfilStatus status;
  final String gender;
  final String regionName;
  final int? cityId;

  final String cityName;
  const ProfilState({
    required this.regionNames,
    required this.cityNames,
    required this.userProfile,
    required this.status,
    required this.gender,
    required this.regionName,
    this.cityId,
    required this.cityName,
  });

  @override
  List<Object?> get props => <Object?>[
        regionNames,
        cityNames,
        userProfile,
        status,
        gender,
        regionName,
        cityName,
        cityId,
      ];

  ProfilState copyWith({
    List<RegionCityModel>? regionNames,
    List<RegionCityModel>? cityNames,
    UserProfile? userProfile,
    ProfilStatus? status,
    String? gender,
    String? regionName,
    int? cityId,
    String? cityName,
  }) {
    return ProfilState(
      regionNames: regionNames ?? this.regionNames,
      cityNames: cityNames ?? this.cityNames,
      userProfile: userProfile ?? this.userProfile,
      status: status ?? this.status,
      gender: gender ?? this.gender,
      regionName: regionName ?? this.regionName,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
    );
  }
}

enum ProfilStatus { loading, success }
