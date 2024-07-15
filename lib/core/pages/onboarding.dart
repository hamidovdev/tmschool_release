import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/assets/icons.dart';
import 'package:tm_school/assets/images.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/core/route_names/route_name.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.onboardingFon,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(70),
              SvgPicture.asset(AppIcons.logo),
              const Gap(50),
              Text(
                textAlign: TextAlign.center,
                "Assalomu alaykum!",
                style: context.style.fontSize22Weight400,
              ),
              Text(
                textAlign: TextAlign.center,
                "Teacher Muzaffar",
                style: context.style.fontSize22Weight600.copyWith(
                  color: context.colors.orange,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "ta’lim platformasiga xush kelibsiz ",
                style: context.style.fontSize22Weight400,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  ins<SharedPreferences>().setBool("wizard", true);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouteName.loginOrSignin,
                    (route) => false,
                  );
                },
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    bottom: 78,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.orange,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Ro’yhatdan o’tish",
                    style: context.style.fontSize19Weight400.copyWith(
                      color: context.colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
