// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class EditCarouselPage extends DashboardEvent {
  final int pageNum;

  EditCarouselPage({required this.pageNum});
}

class GetUserInfoEvent extends DashboardEvent {}

class GetNewsEvent extends DashboardEvent {
  final VoidCallback success;
  final bool haveGroupDate;

  GetNewsEvent({
    required this.success,
    required this.haveGroupDate,
  });
}

class GetCoursesEvent extends DashboardEvent {}

class ClearBlocEvent extends DashboardEvent {}

class JoinCourseEvent extends DashboardEvent {
  final String newsId;
  final VoidCallback success;
  final VoidCallback failure;

  JoinCourseEvent({
    required this.newsId,
    required this.success,
    required this.failure,
  });
}

class PercentageEvent extends DashboardEvent {
  final String lessonId;
  final String courseId;
  final String videoId;
  final VoidCallback success;

  PercentageEvent({
    required this.lessonId,
    required this.courseId,
    required this.videoId,
    required this.success,
  });
}
