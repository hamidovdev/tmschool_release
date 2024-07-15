// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

class RegisterModel {
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
  RegisterModel({
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      "surname": surName,
      'mobil_number': number,
      'password': password,
      'birth_date': "2003-02-17",
      'gender': gender,
      'city_id': 1,
      "password_confirmation": passwordConfirmation,
      'image': null,
    };
  }

  @override
  String toString() {
    return 'RegisterModel(name: $name, surName: $surName, number: $number, password: $password, birthDate: $birthDate, gender: $gender, passwordConfirmation: $passwordConfirmation, cityId: $cityId, imagePath: $imagePath, imageName: $imageName)';
  }
}

Future<FormData> toJson(RegisterModel model) async {
  FormData formData = FormData.fromMap({
    'name': model.name,
    "surname": model.surName,
    'mobil_number': model.number,
    'password': model.password,
    'birth_date': model.birthDate,
    'gender': model.gender.toString(),
    'city_id': model.cityId,
    "password_confirmation": model.passwordConfirmation,
    'image': model.imagePath != null
        ? await MultipartFile.fromFile(
            model.imagePath!.path,
            filename: model.imageName,
          )
        : null
  });

  return formData;
}

class GetCityDataModel {
  final int id;
  final String name;
  final int regionId;
  GetCityDataModel({
    required this.id,
    required this.name,
    required this.regionId,
  });

  factory GetCityDataModel.fromJson(Map<String, dynamic> json) {
    return GetCityDataModel(
      id: json['id'],
      name: json['name'],
      regionId: json['region_id']["id"],
    );
  }
}

class GetRegionNameModel {
  final int id;
  final String name;
  GetRegionNameModel({
    required this.id,
    required this.name,
  });

  factory GetRegionNameModel.fromJson(Map<String, dynamic> json) {
    return GetRegionNameModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() => 'GetRegionNameModel(id: $id, name: $name)';
}

class UserInfo {
  final bool success;
  final String message;
  final String? authToken;

  final UserInfoData data;
  UserInfo({
    required this.success,
    required this.message,
    this.authToken,
    required this.data,
  });
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      authToken: json['auth_token'],
      success: json['success'],
      message: json['message'],
      data: UserInfoData.fromJson(json['data']),
    );
  }

  @override
  String toString() {
    return 'UserInfo(success: $success, message: $message, authToken: $authToken, data: $data)';
  }
}

class UserInfoData {
  final int? id;
  final String name;
  final String surname;
  final String mobileNumber;
  final String password;
  final String? birthDate;
  final int? gander;
  final int? ciytId;
  final String? image;
  final int? mobileVerifyCode;
  UserInfoData({
    this.id,
    required this.name,
    required this.surname,
    required this.mobileNumber,
    required this.password,
    this.birthDate,
    this.gander,
    this.ciytId,
    this.image,
    this.mobileVerifyCode,
  });
  factory UserInfoData.fromJson(Map<String, dynamic> json) {
    return UserInfoData(
      id: json['id'],
      image: json['image'],
      gander: json['gender'],
      ciytId: json['city_id'],
      birthDate: json["birth_date"],
      name: json['name'],
      surname: json['surname'],
      mobileNumber: json['mobil_number'],
      password: json['password'],
      mobileVerifyCode: json['mobile_verify_code'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'UserInfoData(id: $id, name: $name, surname: $surname, mobileNumber: $mobileNumber, password: $password, birthDate: $birthDate, gander: $gander, ciytId: $ciytId, image: $image, mobileVerifyCode: $mobileVerifyCode)';
  }
}


// class UserInfo {
//   final bool success;
//   final String message;
//   final String? authToken;
//   final UserData data;

//   UserInfo({
//     required this.success,
//     required this.message,
//     this.authToken,
//     required this.data,
//   });

//   factory UserInfo.fromJson(Map<String, dynamic> json) {
//     return UserInfo(
//       success: json['success'],
//       message: json['message'],
//       authToken: json['auth_token'],
//       data: UserData.fromJson(json['data']),
//     );
//   }
// }

// class UserData {
//   final int? id;
//   final String name;
//   final String mobilNumber;
//   final String? gender;
//   final String? birthDate;
//   final int? cityId;
//   final String surname;
//   final String password;
//   final String? passwordConfirmation;
//   final String? image;
//   final int? mobileVerifyCode;

//   UserData({
//     this.id,
//     required this.name,
//     required this.mobilNumber,
//     this.gender,
//     this.birthDate,
//     this.cityId,
//     required this.surname,
//     required this.password,
//     this.passwordConfirmation,
//     this.image,
//     this.mobileVerifyCode,
//   });

//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       id: json['id'],
//       name: json['name'],
//       mobilNumber: json['mobil_number'],
//       gender: json['gender'],
//       birthDate: json['birth_date'],
//       cityId: json['city_id'],
//       surname: json['surname'],
//       password: json['password'],
//       passwordConfirmation: json['password_confirmation'],
//       image: json['image'],
//       mobileVerifyCode: json['mobile_verify_code']
//     );
//   }
// }
