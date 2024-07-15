// ignore_for_file: public_member_api_docs, sort_constructors_first

class NewsModel {
  final String groupDate;
  final List<MiniNewsModel> data;

  NewsModel({
    required this.groupDate,
    required this.data,
  });

  NewsModel copyWith({
    String? groupDate,
    List<MiniNewsModel>? data,
  }) =>
      NewsModel(
        groupDate: groupDate ?? this.groupDate,
        data: data ?? this.data,
      );

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        groupDate: json["group_date"],
        data: List<MiniNewsModel>.from(
          json["data"].map(
            (x) => MiniNewsModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "group_date": groupDate,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MiniNewsModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final String images;
  final String createdTime;

  MiniNewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.images,
    required this.createdTime,
  });

  MiniNewsModel copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    String? images,
    String? createdTime,
  }) =>
      MiniNewsModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        images: images ?? this.images,
        createdTime: createdTime ?? this.createdTime,
      );

  factory MiniNewsModel.fromJson(Map<String, dynamic> json) => MiniNewsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        images: json["images"],
        createdTime: json["created_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "images": images,
        "created_time": createdTime,
      };
}

class CourseModel {
  final bool success;
  final String message;
  final int id;
  final String name;
  final DateTime createdAt;
  final int lessonsCount;
  final String images;
  final String lessonTitle;
  final int percentage;
  CourseModel({
    required this.success,
    required this.message,
    required this.id,
    required this.name,
    required this.createdAt,
    required this.lessonsCount,
    required this.images,
    required this.lessonTitle,
    required this.percentage,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
      success: json["success"],
      message: json["message"],
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      lessonsCount: json["lessons_count"],
      images: json["images"],
      lessonTitle: json["lesson_title"],
      percentage: json["percentage"]);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "lessons_count": lessonsCount,
        "images": images,
        "lesson_title": lessonTitle,
        "percentage": percentage
      };

  CourseModel copyWith({
    bool? success,
    String? message,
    int? id,
    String? name,
    DateTime? createdAt,
    int? lessonsCount,
    String? images,
    String? lessonTitle,
    int? percentage,
  }) {
    return CourseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      images: images ?? this.images,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  String toString() {
    return 'CourseModel(success: $success, message: $message, id: $id, name: $name, createdAt: $createdAt, lessonsCount: $lessonsCount, images: $images, lessonTitle: $lessonTitle, percentage: $percentage)';
  }
}

class DashAuthData {
  final String fullName;
  final String? image;
  DashAuthData({
    required this.fullName,
     this.image,
  });

  @override
  String toString() => 'DashAuthData(fullName: $fullName, image: $image)';

  @override
  bool operator ==(covariant DashAuthData other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName && other.image == image;
  }

  factory DashAuthData.fromJson(Map<String, dynamic> json) => DashAuthData(
        fullName: "${json["name"]} ${json["surname"]}",
        image: json["image"],
      );

  @override
  int get hashCode => fullName.hashCode ^ image.hashCode;
}
