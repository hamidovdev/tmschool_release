import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
class NewsEntity {
  final String groupDate;
  final List<DatumEntity> data;

  NewsEntity({
    required this.groupDate,
    required this.data,
  });
}

class DatumEntity {
  final int id;
  final String title;
  final String description;
  final String status;
  final String images;
  final String createdTime;

  DatumEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.images,
    required this.createdTime,
  });

  DatumEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    String? images,
    String? createdTime,
  }) {
    return DatumEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      images: images ?? this.images,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  @override
  String toString() {
    return '_DatumEntity(id: $id, title: $title, description: $description, status: $status, images: $images, createdTime: $createdTime)';
  }

  @override
  bool operator ==(covariant DatumEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.images == images &&
        other.createdTime == createdTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        status.hashCode ^
        images.hashCode ^
        createdTime.hashCode;
  }
}

class CoursesEntity {
  final int id;
  final String name;
  final DateTime createdAt;
  final int lessonsCount;
  final String images;
  final String lessonTitle;
  final int percentage;
  CoursesEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.lessonsCount,
    required this.images,
    required this.lessonTitle,
    required this.percentage,
  });

  @override
  bool operator ==(covariant CoursesEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.lessonsCount == lessonsCount &&
        other.images == images &&
        other.lessonTitle == lessonTitle &&
        other.percentage == percentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        lessonsCount.hashCode ^
        images.hashCode ^
        lessonTitle.hashCode ^
        percentage.hashCode;
  }

  @override
  String toString() {
    return 'CoursesEntity(id: $id, name: $name, createdAt: $createdAt, lessonsCount: $lessonsCount, images: $images, lessonTitle: $lessonTitle, percentage: $percentage)';
  }

  CoursesEntity copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    int? lessonsCount,
    String? images,
    String? lessonTitle,
    int? percentage,
  }) {
    return CoursesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      images: images ?? this.images,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      percentage: percentage ?? this.percentage,
    );
  }
}
