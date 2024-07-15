import 'package:flutter/material.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/pages/premium.dart';

class PremiumRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return fade(
          const PremiumScreen(),
        );
      default:
        return null;
    }
  }
}
