// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegionCityModel {
  final int id;
  final String name;
  RegionCityModel({
    required this.id,
    required this.name,
  });
  factory RegionCityModel.fromJson(Map<String, dynamic> json) {
    return RegionCityModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
