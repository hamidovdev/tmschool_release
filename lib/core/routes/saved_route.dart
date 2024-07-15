import 'package:flutter/material.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/route_names/saved_route_names.dart';
import 'package:tm_school/features/courses/presentation/pages/courseScreen.dart';
import 'package:tm_school/features/saved/presentation/pages/saved_screen.dart';

class SavedRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SavedRouteName.savedScreen:
        return fade(
          const SavedScreen(),
        );
      case SavedRouteName.courseScreen:
        final ls = (settings.arguments as String).split("_");
        return fade(
          CoursesScreen(
            courseId: ls[0],
            lessonId: ls[1],
            videoId: ls[2],
          ),
        );
      default:
        return null;
    }
  }
}
