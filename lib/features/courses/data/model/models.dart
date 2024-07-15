import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LessonModel {
  final int id;
  final String name;
  final int courseId;
  final String files;
  final List<VideoModel> videos;

  LessonModel({
    required this.id,
    required this.name,
    required this.courseId,
    required this.files,
    required this.videos,
  });

  LessonModel copyWith({
    int? id,
    String? name,
    int? courseId,
    String? files,
    List<VideoModel>? videos,
  }) =>
      LessonModel(
        id: id ?? this.id,
        name: name ?? this.name,
        courseId: courseId ?? this.courseId,
        files: files ?? this.files,
        videos: videos ?? this.videos,
      );

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        id: json["id"],
        name: json["name"],
        courseId: json["course_id"],
        files: json["files"],
        videos: List<VideoModel>.from(
            json["videos"].map((x) => VideoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "course_id": courseId,
        "files": files,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'LessonModel(id: $id, name: $name, courseId: $courseId, files: $files, videos: $videos)';
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class InfoModel {
  final int id;
  final String description;
  final String link;
  final int lessonId;
  final List<dynamic> files;

  InfoModel({
    required this.id,
    required this.description,
    required this.link,
    required this.lessonId,
    required this.files,
  });

  InfoModel copyWith({
    int? id,
    String? description,
    String? link,
    int? lessonId,
    List<dynamic>? files,
  }) =>
      InfoModel(
        id: id ?? this.id,
        description: description ?? this.description,
        link: link ?? this.link,
        lessonId: lessonId ?? this.lessonId,
        files: files ?? this.files,
      );

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        id: json["id"],
        description: json["description"],
        link: json["link"],
        lessonId: json["lesson_id"],
        files: List<dynamic>.from(json["files"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "link": link,
        "lesson_id": lessonId,
        "files": List<dynamic>.from(files.map((x) => x)),
      };

  @override
  String toString() {
    return 'InfoModel(id: $id, description: $description, link: $link, lessonId: $lessonId, files: $files)';
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class VideoModel {
  final int id;
  final String link;
  final String description;
  final String lesson;
  final String course;
  final bool saved;
  final bool liked;
  final int? courseId;
  final int? lessonId;
  final int? viewCount;
  final List<Files> files;

  VideoModel({
    required this.id,
    required this.link,
    required this.description,
    required this.lesson,
    required this.course,
    required this.saved,
    required this.liked,
    this.courseId,
    this.lessonId,
    this.viewCount,
    required this.files,
  });

  VideoModel copyWith({
    int? id,
    String? link,
    String? description,
    String? lesson,
    String? course,
    bool? saved,
    bool? liked,
    int? courseId,
    int? lessonId,
    int? viewCount,
    List<Files>? files,
  }) {
    return VideoModel(
      id: id ?? this.id,
      link: link ?? this.link,
      description: description ?? this.description,
      lesson: lesson ?? this.lesson,
      course: course ?? this.course,
      saved: saved ?? this.saved,
      liked: liked ?? this.liked,
      courseId: courseId ?? this.courseId,
      lessonId: lessonId ?? this.lessonId,
      viewCount: viewCount ?? this.viewCount,
      files: files ?? this.files,
    );
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
      id: json["id"],
      link: json["link"],
      description: json["description"],
      lesson: json["lesson"],
      course: json["course"],
      saved: json["saved"],
      liked: json["liked"],
      courseId: json["course_id"],
      lessonId: json["lesson_id"],
      viewCount: json["view_count"],
      files: json["files"] != []
          ? List<Files>.from(json["files"].map((x) => Files.fromJson(x)))
          : []
      //(json["original_url"] as List).map((e) => Files.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "description": description,
        "lesson": lesson,
        "course": course,
        "saved": saved,
        "liked": liked,
        "course_id": courseId,
        "lesson_id": lessonId,
        "view_count": viewCount,
      };

  @override
  String toString() {
    return 'VideoModel(id: $id, link: $link, description: $description, lesson: $lesson, course: $course, saved: $saved, liked: $liked, courseId: $courseId, lessonId: $lessonId, viewCount: $viewCount, files: $files)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.link == link &&
        other.description == description &&
        other.lesson == lesson &&
        other.course == course &&
        other.saved == saved &&
        other.liked == liked &&
        other.courseId == courseId &&
        other.lessonId == lessonId &&
        other.viewCount == viewCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        link.hashCode ^
        description.hashCode ^
        lesson.hashCode ^
        course.hashCode ^
        saved.hashCode ^
        liked.hashCode ^
        courseId.hashCode ^
        lessonId.hashCode ^
        viewCount.hashCode;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

class Files {
  final String? originalUrl;
  Files({
    this.originalUrl,
  });
  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      originalUrl: json['original_url'],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

class CommentModel {
  final int id;
  final String comments;
  final VideoModel video;
  final User user;

  CommentModel({
    required this.id,
    required this.comments,
    required this.video,
    required this.user,
  });

  CommentModel copyWith({
    bool? success,
    String? message,
    int? id,
    String? comments,
    VideoModel? video,
    User? user,
  }) =>
      CommentModel(
        id: id ?? this.id,
        comments: comments ?? this.comments,
        video: video ?? this.video,
        user: user ?? this.user,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        comments: json["comments"],
        video: VideoModel.fromJson(json["video"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comments": comments,
        "video": video.toJson(),
        "user": user.toJson(),
      };

  @override
  String toString() {
    return 'CommentModel(id: $id, comments: $comments, video: $video, user: $user)';
  }
}

class User {
  final int? id;
  final String name;
  final String surname;
  final String? image;

  User({
    this.id,
    required this.name,
    required this.surname,
    this.image,
  });

  User copyWith({
    int? id,
    String? name,
    String? surname,
    String? image,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        image: image ?? this.image,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "image": image,
      };

  @override
  String toString() {
    return 'User(id: $id, name: $name, surname: $surname, image: $image)';
  }
}

class Video {
  final int id;
  final String link;
  final String description;
  final String lesson;
  final String course;
  final String saved;
  final String liked;

  Video({
    required this.id,
    required this.link,
    required this.description,
    required this.lesson,
    required this.course,
    required this.saved,
    required this.liked,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        link: json["link"],
        description: json["description"],
        lesson: json["lesson"],
        course: json["course"],
        saved: json["saved"],
        liked: json["liked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "description": description,
        "lesson": lesson,
        "course": course,
        "saved": saved,
        "liked": liked,
      };

  Video copyWith({
    int? id,
    String? link,
    String? description,
    String? lesson,
    String? course,
    String? saved,
    String? liked,
  }) {
    return Video(
      id: id ?? this.id,
      link: link ?? this.link,
      description: description ?? this.description,
      lesson: lesson ?? this.lesson,
      course: course ?? this.course,
      saved: saved ?? this.saved,
      liked: liked ?? this.liked,
    );
  }

  @override
  String toString() {
    return 'Video(id: $id, link: $link, description: $description, lesson: $lesson, course: $course, saved: $saved, liked: $liked)';
  }
}
