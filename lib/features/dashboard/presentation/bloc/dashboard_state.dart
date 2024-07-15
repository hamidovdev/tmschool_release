// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'dashboard_bloc.dart';

class DashboardState {
  final MainStatus appbarStatus;
  final MainStatus mainStatus;
  final int carouselPageNumber;
  final DashAuthData? userInfo;
  final List<DatumEntity> news;
  final List<NewsEntity> forNotifications;
  final List<CoursesEntity> courses;
  final MainStatus joinCourseStatus;

  DashboardState({
    required this.appbarStatus,
    required this.mainStatus,
    required this.carouselPageNumber,
    this.userInfo,
    required this.news,
    required this.forNotifications,
    required this.courses,
    required this.joinCourseStatus,
  });

  DashboardState copyWith({
    MainStatus? appbarStatus,
    MainStatus? mainStatus,
    int? carouselPageNumber,
    DashAuthData? userInfo,
    List<DatumEntity>? news,
    List<NewsEntity>? forNotifications,
    List<CoursesEntity>? courses,
    MainStatus? joinCourseStatus,
  }) {
    return DashboardState(
      appbarStatus: appbarStatus ?? this.appbarStatus,
      mainStatus: mainStatus ?? this.mainStatus,
      carouselPageNumber: carouselPageNumber ?? this.carouselPageNumber,
      userInfo: userInfo ?? this.userInfo,
      news: news ?? this.news,
      forNotifications: forNotifications ?? this.forNotifications,
      courses: courses ?? this.courses,
      joinCourseStatus: joinCourseStatus ?? this.joinCourseStatus,
    );
  }

  @override
  bool operator ==(covariant DashboardState other) {
    if (identical(this, other)) return true;
  
    return 
      other.appbarStatus == appbarStatus &&
      other.mainStatus == mainStatus &&
      other.carouselPageNumber == carouselPageNumber &&
      other.userInfo == userInfo &&
      listEquals(other.news, news) &&
      listEquals(other.forNotifications, forNotifications) &&
      listEquals(other.courses, courses) &&
      other.joinCourseStatus == joinCourseStatus;
  }

  @override
  int get hashCode {
    return appbarStatus.hashCode ^
      mainStatus.hashCode ^
      carouselPageNumber.hashCode ^
      userInfo.hashCode ^
      news.hashCode ^
      forNotifications.hashCode ^
      courses.hashCode ^
      joinCourseStatus.hashCode;
  }

  @override
  String toString() {
    return 'DashboardState(appbarStatus: $appbarStatus, mainStatus: $mainStatus, carouselPageNumber: $carouselPageNumber, userInfo: $userInfo, news: $news, forNotifications: $forNotifications, courses: $courses, joinCourseStatus: $joinCourseStatus)';
  }
}
