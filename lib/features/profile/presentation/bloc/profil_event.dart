// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profil_bloc.dart';

class ProfilEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class GetProfilDataEvent extends ProfilEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class UpdateEvent extends ProfilEvent {
  final UpdateModel updateModel;
  final VoidCallback onSuccess;
  final VoidCallback failure;
  UpdateEvent({
    required this.updateModel,
    required this.onSuccess,
    required this.failure,
  });

  @override
  List<Object?> get props => <Object?>[updateModel, onSuccess, failure];
}

class RegionNameEvent extends ProfilEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class CityNameProfilEvent extends ProfilEvent {
  final int id;
  CityNameProfilEvent({
    required this.id,
  });

  @override
  List<Object?> get props => <Object?>[id];
}

class SelectGenderEvent extends ProfilEvent {
  final String gender;
  SelectGenderEvent({
    required this.gender,
  });

  @override
  List<Object?> get props => <Object?>[gender];
}

class SelectRegionName extends ProfilEvent {
  final String region;
  SelectRegionName({
    required this.region,
  });

  @override
  List<Object?> get props => <Object?>[region];
}

class SelectCityName extends ProfilEvent {
  final String city;
  final int id;
  SelectCityName({
    required this.city,
    required this.id,
  });

  @override
  List<Object?> get props => <Object?>[city, id];
}
