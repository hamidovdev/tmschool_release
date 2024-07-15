// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/core/routes/app_route.dart';
import 'package:tm_school/features/authentification/presentation/bloc/auth_bloc_bloc.dart';
import 'package:tm_school/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tm_school/features/home/bloc/home_bloc.dart';
import 'package:tm_school/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:tm_school/features/profile/presentation/bloc/profil_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: const [GestureType.onTap],
        child: ScreenUtilInit(
          designSize: const Size(414, 932),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProfilBloc(),
              ),
              BlocProvider(
                create: (context) => AuthBlocBloc(),
              ),
              BlocProvider(
                create: (context) => DashboardBloc(),
              ),
              BlocProvider(
                create: (context) => CoursesBloc(),
              ),
              BlocProvider(
                create: (context) => SavedBloc(),
              ),
              BlocProvider(
                create: (context) => HomeBloc(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: context.theme.lightTheme(),
              themeMode: ThemeMode.dark,
              themeAnimationDuration: const Duration(milliseconds: 250),
              themeAnimationCurve: Curves.slowMiddle,
              darkTheme: context.theme.darkTheme(),
              onGenerateRoute: AppRoute.onGenerateRoute,
            ),
          ),
        ));
  }
}
