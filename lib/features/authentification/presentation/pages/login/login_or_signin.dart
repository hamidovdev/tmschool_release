import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/assets/icons.dart';
import 'package:tm_school/assets/images.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/widgets/w_textfield.dart';

import '../../bloc/auth_bloc_bloc.dart';

class LoginOrSignIn extends StatefulWidget {
  const LoginOrSignIn({super.key});

  @override
  State<LoginOrSignIn> createState() => _LoginOrSignInState();
}

class _LoginOrSignInState extends State<LoginOrSignIn> {
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          return Scaffold(
            body: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.loginFon,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(AppIcons.logo),
                    const Gap(55),
                    WTextField(
                      autofocus: true,
                      textAlign: TextAlign.start,
                      prefixText: "+998",
                      prefixStyle: context.style.fontSize18Weight400,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      // hintText: "Telefon raqam",
                      hintTextSytle: context.style.fontSize18Weight400.copyWith(
                        color: context.colors.hintTextColor,
                      ),
                      textStyle: context.style.fontSize18Weight400,
                    ),
                    const Gap(30),
                    WTextField(
                      textAlign: TextAlign.start,
                      controller: passwordController,
                      hintText: "Parol",
                      hintTextSytle: context.style.fontSize18Weight400.copyWith(
                        color: context.colors.hintTextColor,
                      ),
                      textStyle: context.style.fontSize18Weight400,
                    ),
                    const Gap(40),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBlocBloc>().add(
                              LoginEvent(
                                phoneNumber: "+998${phoneController.text}",
                                password: passwordController.text,
                                onSuccess: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      AppRouteName.home, (route) => false);
                                },
                                failure: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Foydalanuvchi topilmadi!"),
                                    ),
                                  );
                                },
                              ),
                            );
                      },
                      child: Container(
                        height: 60,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: context.colors.orange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Kirish",
                          style: context.style.fontSize24Weight700.copyWith(
                            color: context.colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const Gap(26),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouteName.signIn);
                      },
                      child: Text(
                        "Ro’yhatdan o’tish",
                        style: context.style.fontSize20Weight500.copyWith(
                          color: context.colors.orange,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
