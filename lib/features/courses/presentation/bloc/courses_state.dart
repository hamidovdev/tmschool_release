// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'courses_bloc.dart';

class CoursesState {
  final List<int> activeCoursesList;
  final MainStatus mainStatus;
  final int activePageIndex;
  final List<LessonModel> lessons;
  final List<VideoModel> videos;
  final List<CommentModel> comments;
  final VideoModel? activeVideo;
  final MainStatus commentsStatus;
  final MainStatus videosStatus;
  final MainStatus lessonsStatus;
  final String activeVideoIndex;
  final YoutubePlayerController? controller;
  final int thisPage;

  CoursesState(
      {required this.activeCoursesList,
      required this.mainStatus,
      required this.activePageIndex,
      required this.lessons,
      required this.videos,
      required this.comments,
      this.activeVideo,
      required this.commentsStatus,
      required this.videosStatus,
      required this.lessonsStatus,
      required this.activeVideoIndex,
      this.controller,
      required this.thisPage});

  CoursesState copyWith({
    List<int>? activeCoursesList,
    MainStatus? mainStatus,
    int? activePageIndex,
    List<LessonModel>? lessons,
    List<VideoModel>? videos,
    List<CommentModel>? comments,
    VideoModel? activeVideo,
    MainStatus? commentsStatus,
    MainStatus? videosStatus,
    MainStatus? lessonsStatus,
    String? activeVideoIndex,
    YoutubePlayerController? controller,
    int? thisPage,
  }) {
    return CoursesState(
      activeCoursesList: activeCoursesList ?? this.activeCoursesList,
      mainStatus: mainStatus ?? this.mainStatus,
      activePageIndex: activePageIndex ?? this.activePageIndex,
      lessons: lessons ?? this.lessons,
      videos: videos ?? this.videos,
      comments: comments ?? this.comments,
      activeVideo: activeVideo ?? this.activeVideo,
      commentsStatus: commentsStatus ?? this.commentsStatus,
      videosStatus: videosStatus ?? this.videosStatus,
      lessonsStatus: lessonsStatus ?? this.lessonsStatus,
      activeVideoIndex: activeVideoIndex ?? this.activeVideoIndex,
      controller: controller ?? this.controller,
      thisPage: thisPage ?? this.thisPage,
    );
  }

  @override
  bool operator ==(covariant CoursesState other) {
    if (identical(this, other)) return true;

    return listEquals(other.activeCoursesList, activeCoursesList) &&
        other.mainStatus == mainStatus &&
        other.activePageIndex == activePageIndex &&
        listEquals(other.lessons, lessons) &&
        listEquals(other.videos, videos) &&
        listEquals(other.comments, comments) &&
        other.activeVideo == activeVideo &&
        other.commentsStatus == commentsStatus &&
        other.videosStatus == videosStatus &&
        other.lessonsStatus == lessonsStatus &&
        other.activeVideoIndex == activeVideoIndex &&
        other.controller == controller &&
        other.thisPage == thisPage;
  }

  @override
  int get hashCode {
    return activeCoursesList.hashCode ^
        mainStatus.hashCode ^
        activePageIndex.hashCode ^
        lessons.hashCode ^
        videos.hashCode ^
        comments.hashCode ^
        activeVideo.hashCode ^
        commentsStatus.hashCode ^
        videosStatus.hashCode ^
        lessonsStatus.hashCode ^
        activeVideoIndex.hashCode ^
        controller.hashCode ^
        thisPage.hashCode;
  }
}
