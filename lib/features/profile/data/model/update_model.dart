// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

class UpdateModel {
  final String name;
  final String surname;
  final String? birthDate; 
  final int? gender;
  final String mobilNumber;
  final String? imageName;
  final File? imagePath;
  final String password;
  final int? cityId;
  UpdateModel({
    required this.name,
    required this.surname,
    this.birthDate,
    this.gender,
    required this.mobilNumber,
    this.imageName,
    this.imagePath,
    required this.password,
    this.cityId,
  });


  
  
 

}

 
Future<FormData> updateProfil(UpdateModel model) async {
  FormData formData = FormData.fromMap({
    'name': model.name,
    "surname": model.surname,
    'mobil_number': model.mobilNumber,
    'password': model.password,
    'birth_date': model.birthDate,
    'gender': model.gender.toString(),
    'city_id': model.cityId,
    "password_confirmation": model.password,
    'image': model.imagePath != null
        ? await MultipartFile.fromFile(
            model.imagePath!.path,
            filename: model.imageName,
          )
        : null
  });

  return formData;
}