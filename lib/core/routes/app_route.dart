import 'package:flutter/material.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/pages/onboarding.dart';
import 'package:tm_school/core/pages/premium.dart';
import 'package:tm_school/core/pages/splash.dart';
import 'package:tm_school/core/route_names/courses_route_names.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/features/courses/presentation/pages/forYouTubeVideo.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';
import 'package:tm_school/features/dashboard/presentation/pages/news.dart';
import 'package:tm_school/features/dashboard/presentation/pages/notifications.dart';
import 'package:tm_school/features/home/pages/home.dart';
import 'package:tm_school/features/authentification/presentation/pages/login/login_or_signin.dart';
import 'package:tm_school/features/authentification/presentation/pages/signin/sign_in_page.dart';
import 'package:tm_school/features/authentification/presentation/pages/signin/verification.dart';
import 'package:tm_school/features/profile/data/model/model.dart';
import 'package:tm_school/features/profile/presentation/pages/change_profil/change_profil.dart';
import 'package:tm_school/features/profile/presentation/pages/profile.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.splash:
        return fade(
          const SplashScreen(),
        );
      case AppRouteName.onboarding:
        return fade(
          const OnBoardingPage(),
        );
      case AppRouteName.signIn:
        return fade(
          const SignIn(),
        );
      case AppRouteName.verification:
        return fade(
          const VerificationPassWordPage(),
        );
      case AppRouteName.loginOrSignin:
        return fade(
          const LoginOrSignIn(),
        );
      case AppRouteName.news:
        return fade(
          NewsPage(
            data: settings.arguments as DatumEntity,
          ),
        );
      case AppRouteName.notifications:
        return fade(
          const NotificationsPage(),
        );
      case AppRouteName.profile:
        return fade(
          const Profile(),
        );
      case AppRouteName.changeProfile:
        return fade(
          ChangeProfile(
            userProfile: settings.arguments as UserProfile,
          ),
        );
      case AppRouteName.home:
        return fade(
          const HomeScreen(),
        );
      case AppRouteName.premium:
        return fade(
          const PremiumScreen(),
        );
      case AppRouteName.youtubePlayerPage:
        return fade(
          ForYouTubeVideoPage(),
        );

      default:
        return null;
    }
  }
}
