import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/widgets/w_textfield.dart';
import 'package:tm_school/features/authentification/presentation/bloc/auth_bloc_bloc.dart';

class VerificationPassWordPage extends StatefulWidget {
  const VerificationPassWordPage({super.key});

  @override
  State<VerificationPassWordPage> createState() =>
      _VerificationPassWordPageState();
}

class _VerificationPassWordPageState extends State<VerificationPassWordPage> {
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Ro’yhatdan o’tish",
                style: context.style.fontSize32Weight500,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Tasdiqlash kodi",
                      style: context.style.fontSize18Weight400,
                    ),
                  ),
                  const Gap(20),
                  WTextField(
                    controller: controller,
                    onChanged: (p0) {
                      if (p0 ==
                          state.userinfo.data.mobileVerifyCode.toString()) {
                        context.read<AuthBlocBloc>().add(
                              VeriFicationSmsEvent(
                                onSuccess: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      AppRouteName.home, (route) => false);
                                },
                                failure: () {},
                                user: state.userinfo,
                              ),
                            );
                      }
                    },
                    keyboardType: TextInputType.number,
                    borderColor: context.colors.textFieldBackground,
                    hintText: "_ _ _ _",
                    hintTextSytle: context.style.fontSize24Weight700.copyWith(
                      color: context.colors.hintTextColor,
                    ),
                    textStyle: context.style.fontSize24Weight700,
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
