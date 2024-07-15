class UserProfile {
  final bool success;
  final String message;
  final int id;
  final String name;
  final String surname;
  final String mobileNumber;
  final String? gender;
  final String? birthDate;
  final int? cityId;
  final String? image;

  UserProfile({
    required this.success,
    required this.message,
    required this.id,
    required this.name,
    required this.surname,
    required this.mobileNumber,
    this.gender,
    this.birthDate,
    this.cityId,
    this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      success: json['success'],
      message: json['message'],
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      mobileNumber: json['mobil_number'],
      gender: json['gender'],
      birthDate: json['birth_date'],
      cityId: json['city_id'],
      image: json['image'],
    );
  }
}
