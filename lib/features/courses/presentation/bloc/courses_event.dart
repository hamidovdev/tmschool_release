// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'courses_bloc.dart';

abstract class CoursesEvent {}

class EditActiveCourseIndex extends CoursesEvent {
  final int activeCourseInd;

  EditActiveCourseIndex({required this.activeCourseInd});
}

class EditActivePageIndex extends CoursesEvent {
  final int ind;

  EditActivePageIndex({
    required this.ind,
  });
}

class GetLessonsEvent extends CoursesEvent {
  final String courseId;
  final String? lessonId;
  final String? videoId;
  final VoidCallback success;

  GetLessonsEvent({
    required this.courseId,
    required this.success,
    this.lessonId,
    this.videoId,
  });
}

class GetVideosEvent extends CoursesEvent {
  final String lessonId;

  GetVideosEvent({
    required this.lessonId,
  });
}

class GetCommentsEvent extends CoursesEvent {
  final String videoId;

  GetCommentsEvent({
    required this.videoId,
  });
}

class ClickBtnsEvent extends CoursesEvent {
  final String videoId;
  final String param;

  ClickBtnsEvent({
    required this.videoId,
    required this.param,
  });
}

class SendCommentEvent extends CoursesEvent {
  final String message;
  final String videoId;

  SendCommentEvent({
    required this.message,
    required this.videoId,
  });
}

class EditActiveVideoEvent extends CoursesEvent {
  final VideoModel video;
  final int videoIndex;
  final String lessonId;
  final VoidCallback success;

  EditActiveVideoEvent({
    required this.videoIndex,
    required this.lessonId,
    required this.video,
    required this.success,
  });
}

class ClearCourseBlocEvent extends CoursesEvent {}

class EditFullScreenEvent extends CoursesEvent {
  final VoidCallback success;
  final VoidCallback failure;

  EditFullScreenEvent({
    required this.success,
    required this.failure,
  });
}
