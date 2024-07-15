import 'package:flutter/material.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/route_names/courses_route_names.dart';
import 'package:tm_school/features/courses/presentation/pages/courseScreen.dart';
import 'package:tm_school/features/courses/presentation/pages/forYouTubeVideo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursesRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CoursesRouteNames.coursesScreen:
        return fade(
          const CoursesScreen(),
        );
      case CoursesRouteNames.forYoutubeVideoPage:
        return fade(
          ForYouTubeVideoPage(),
        );
      default:
        return null;
    }
  }
}
