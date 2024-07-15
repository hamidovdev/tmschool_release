import 'package:tm_school/features/courses/data/model/models.dart';

class SavedModel {
  final String groupDate;
  final List<MiniSavedModel> data;

  SavedModel({
    required this.groupDate,
    required this.data,
  });

  SavedModel copyWith({
    String? groupDate,
    List<MiniSavedModel>? data,
  }) =>
      SavedModel(
        groupDate: groupDate ?? this.groupDate,
        data: data ?? this.data,
      );

  factory SavedModel.fromJson(Map<String, dynamic> json) => SavedModel(
        groupDate: json["group_date"],
        data: List<MiniSavedModel>.from(
            json["data"].map((x) => MiniSavedModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group_date": groupDate,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MiniSavedModel {
  final int id;
  final String saved;
  final String liked;
  final VideoModel video;
  final DateTime createdAt;

  MiniSavedModel({
    required this.id,
    required this.saved,
    required this.liked,
    required this.video,
    required this.createdAt,
  });

  MiniSavedModel copyWith({
    int? id,
    String? saved,
    String? liked,
    VideoModel? video,
    DateTime? createdAt,
  }) =>
      MiniSavedModel(
        id: id ?? this.id,
        saved: saved ?? this.saved,
        liked: liked ?? this.liked,
        video: video ?? this.video,
        createdAt: createdAt ?? this.createdAt,
      );

  factory MiniSavedModel.fromJson(Map<String, dynamic> json) => MiniSavedModel(
        id: json["id"],
        saved: json["saved"],
        liked: json["liked"],
        video: VideoModel.fromJson(json["video"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "saved": saved,
        "liked": liked,
        "video": video.toJson(),
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

// class MiniSavedVideoModel {
//   final int id;
//   final String link;
//   final String description;
//   final String lessonId;
//   final String course;

//   MiniSavedVideoModel({
//     required this.id,
//     required this.link,
//     required this.description,
//     required this.lessonId,
//     required this.course,
//   });

//   MiniSavedVideoModel copyWith({
//     int? id,
//     String? link,
//     String? description,
//     String? lessonId,
//     String? course,
//   }) =>
//       MiniSavedVideoModel(
//         id: id ?? this.id,
//         link: link ?? this.link,
//         description: description ?? this.description,
//         lessonId: lessonId ?? this.lessonId,
//         course: course ?? this.course,
//       );

//   factory MiniSavedVideoModel.fromJson(Map<String, dynamic> json) =>
//       MiniSavedVideoModel(
//         id: json["id"],
//         link: json["link"],
//         description: json["description"],
//         lessonId: json["lesson_id"],
//         course: json["course"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "link": link,
//         "description": description,
//         "lesson_id": lessonId,
//         "course": course,
//       };
// }
