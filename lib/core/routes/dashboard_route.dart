import 'package:flutter/material.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/route_names/dashboard_route_names.dart';
import 'package:tm_school/features/courses/presentation/pages/courseScreen.dart';
import 'package:tm_school/features/dashboard/presentation/pages/dashboard_screen.dart';

class DashboardRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardRouteNames.dashboardScreen:
        return fade(
          const DashboardScreen(),
        );
      case DashboardRouteNames.coursesScreen:
        return fade(
          CoursesScreen(
            courseId: settings.arguments as String,
          ),
        );

      default:
        return null;
    }
  }
}
