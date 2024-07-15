import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/assets/icons.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/features/authentification/presentation/bloc/auth_bloc_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state.status == Status.unAuth) {
          if (ins<SharedPreferences>().getBool('wizard') == true) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouteName.loginOrSignin, (route) => false);
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouteName.onboarding, (route) => false);
          }
        }else if(state.status == Status.authen){ 
           Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouteName.home, (route) => false);
        }
      },
      builder: (context, state) {
        if (state.status == Status.unknown) {
          Timer(const Duration(seconds: 2), () { 
            context.read<AuthBlocBloc>().add(GetUserStatusEvent());
          });
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SvgPicture.asset(
                  AppIcons.logo,
                ),
                const Spacer(),
                const CupertinoActivityIndicator(),
                const Gap(40),
              ],
            ),
          ),
        );
      },
    );
  }
}
