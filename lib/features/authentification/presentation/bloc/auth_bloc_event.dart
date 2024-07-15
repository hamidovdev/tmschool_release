// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent extends Equatable {}

class RegisterEvent extends AuthBlocEvent {
  final VoidCallback onSuccess;
  final VoidCallback failure;
  final String name;
  final String surName;
  final String number;
  final String password;
  final String? birthDate;
  final int? gender;
  final String passwordConfirmation;
  final int? cityId;
  final File? imagePath;
  final String? imageName;
  RegisterEvent({
    required this.onSuccess,
    required this.failure,
    required this.name,
    required this.surName,
    required this.number,
    required this.password,
    this.birthDate,
    this.gender,
    required this.passwordConfirmation,
    this.cityId,
    this.imagePath,
    this.imageName,
  });

  @override
  List<Object?> get props => <Object?>[
        onSuccess,
        failure,
        name,
        surName,
        number,
        password,
        birthDate,
        passwordConfirmation,
        cityId,
        imageName,
        imagePath,
      ];
}

class GenderIndexEvent extends AuthBlocEvent {
  final int index;
  GenderIndexEvent({
    required this.index,
  });

  @override
  List<Object?> get props => <Object?>[index];
}

class CityNameIndexEvent extends AuthBlocEvent {
  final int index;
  CityNameIndexEvent({
    required this.index,
  });

  @override
  List<Object?> get props => <Object?>[index];
}

class GetCiytNameEvent extends AuthBlocEvent {
  final int id;
  GetCiytNameEvent({
    required this.id,
  });

  @override
  List<Object?> get props => <Object?>[id];
}

class GetRegionNameEvent extends AuthBlocEvent {
  final int id;
  GetRegionNameEvent({
    required this.id,
  });

  @override
  List<Object?> get props => <Object?>[id];
}

class RegionNameIndexEvent extends AuthBlocEvent {
  final int index;
  RegionNameIndexEvent({
    required this.index,
  });

  @override
  List<Object?> get props => <Object?>[index];
}

class VeriFicationSmsEvent extends AuthBlocEvent {
  final VoidCallback onSuccess;
  final VoidCallback failure;
  final UserInfo user;
  VeriFicationSmsEvent({
    required this.onSuccess,
    required this.failure,
    required this.user,
  });

  @override
  List<Object?> get props => <Object?>[onSuccess, failure, user];
}

class LoginEvent extends AuthBlocEvent {
  final String phoneNumber;
  final String password;
  final VoidCallback onSuccess;
  final VoidCallback failure;
  LoginEvent({
    required this.phoneNumber,
    required this.password,
    required this.onSuccess,
    required this.failure,
  });

  @override
  List<Object?> get props =>
      <Object?>[phoneNumber, password, onSuccess, failure];
}

class GetUserStatusEvent extends AuthBlocEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class LogOutEvent extends AuthBlocEvent {
  final VoidCallback onsuccess;
  final VoidCallback failure;
  LogOutEvent({
    required this.onsuccess,
    required this.failure,
  });
  
  @override
  List<Object?> get props => <Object?>[ onsuccess , failure ];

}

class DeleteAccauntEvent extends AuthBlocEvent {
  final VoidCallback onsuccess;
  final VoidCallback failure;
  DeleteAccauntEvent({
    required this.onsuccess,
    required this.failure,
  });
  
  @override
  List<Object?> get props => <Object?>[ onsuccess , failure ];

}
