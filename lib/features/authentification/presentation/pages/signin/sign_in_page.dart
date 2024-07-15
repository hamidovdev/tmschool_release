// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tm_school/assets/icons.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/widgets/w_expansiontile.dart';
import 'package:tm_school/core/widgets/w_textfield.dart';
import 'package:tm_school/features/authentification/presentation/bloc/auth_bloc_bloc.dart';
import 'package:tm_school/features/authentification/presentation/widgets/signin_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final TextEditingController nameController;
  late final TextEditingController surNameController;
  late final TextEditingController birthDateController;
  late final TextEditingController birthMonthController;
  late final TextEditingController birthYearController;
  late final ExpansionTileController regionController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmationController;
  late final ExpansionTileController genderController;
  late final ExpansionTileController cityController;
  @override
  void initState() {
    genderController = ExpansionTileController();
    nameController = TextEditingController();
    surNameController = TextEditingController();
    birthDateController = TextEditingController();
    birthMonthController = TextEditingController();
    birthYearController = TextEditingController();
    regionController = ExpansionTileController();
    cityController = ExpansionTileController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    super.initState();
    context.read<AuthBlocBloc>().add(
          GetCiytNameEvent(id: 1),
        );
    context.read<AuthBlocBloc>().add(GetRegionNameEvent(id: 1));
  }

  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Ro’yhatdan o’tish",
          style: context.style.fontSize32Weight500.copyWith(
            color: context.colors.dark,
          ),
        ),
      ),
      body: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          switch (state.registerStatus) {
            case RegisterStatus.loading:
              return const Center(
                child: CupertinoActivityIndicator(),
              );

            case RegisterStatus.success:
              return ListView(
                children: [
                  const Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: context.colors.pink,
                            borderRadius: BorderRadius.circular(6)),
                        height: 140,
                        width: 140,
                        child: GestureDetector(
                          onTap: () async {
                            image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: image == null
                                ? SvgPicture.asset(
                                    AppIcons.changeImage,
                                  )
                                : Image.file(
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(40),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Ismingiz",
                            style: context.style.fontSize18Weight400,
                          ),
                        ),
                        const Gap(20),
                        WTextField(
                          controller: nameController,
                          hintText: "name",
                        ),
                        const GetTextFunc2(text: "Familiyangiz"),
                        WTextField(
                          controller: surNameController,
                          hintText: "name",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 17,
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Tug’ilgan sana",
                                style: context.style.fontSize18Weight400,
                              ),
                              const Gap(12),
                              SvgPicture.asset(
                                AppIcons.calendar,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: WTextField(
                                keyboardType: TextInputType.number,
                                controller: birthDateController,
                                hintText: "DD",
                                maxLength: 2,
                                onChanged: (p0) {},
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: WTextField(
                                keyboardType: TextInputType.number,
                                controller: birthMonthController,
                                hintText: "MM",
                                maxLength: 2,
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: WTextField(
                                keyboardType: TextInputType.number,
                                controller: birthYearController,
                                hintText: "YY",
                                maxLength: 4,
                              ),
                            ),
                          ],
                        ),
                        const GetTextFunc2(text: "Jinsingiz"),
                        WExpansionTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          controller: genderController,
                          onExpansionChanged: (p0) {},
                          title: state.genderExpansiontileIndex == 1
                              ? "Erkak"
                              : "Ayol",
                          children: [
                            GestureDetector(
                              onTap: () {
                                genderController.collapse();
                                context
                                    .read<AuthBlocBloc>()
                                    .add(GenderIndexEvent(index: 1));
                              },
                              child: const SizedBox(
                                width: double.maxFinite,
                                child: GetTextFunc(
                                  text: "Erkak",
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                genderController.collapse();
                                context
                                    .read<AuthBlocBloc>()
                                    .add(GenderIndexEvent(index: 0));
                              },
                              child: const SizedBox(
                                width: double.maxFinite,
                                child: GetTextFunc(
                                  text: "Ayol",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const GetTextFunc2(text: "Viloyat"),
                        WExpansionTile(
                          controller: regionController,
                          title: state.regionName,
                          children: [
                            ...List.generate(
                              state.regions.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  context.read<AuthBlocBloc>().add(
                                        GetCiytNameEvent(
                                            id: state.regions[index].id),
                                      );
                                  context
                                      .read<AuthBlocBloc>()
                                      .add(RegionNameIndexEvent(index: index));
                                  regionController.collapse();
                                },
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: GetTextFunc(
                                    text: state.regions[index].name,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const GetTextFunc2(text: "Shaxringiz"),
                        WExpansionTile(
                          controller: cityController,
                          title: state.cityName,
                          children: [
                            ...List.generate(
                              state.city.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  cityController.collapse();
                                  context.read<AuthBlocBloc>().add(
                                        CityNameIndexEvent(index: index),
                                      );
                                },
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: GetTextFunc(
                                    text: state.city[index].name,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const GetTextFunc2(text: "Telefon raqam"),
                        WTextField(
                          prefixText: "+998",
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          // hintText: "+998__ ___ __ __",
                        ),
                        const GetTextFunc2(text: "Parol"),
                        WTextField(
                          obscuringCharacter: "*",
                          obscureText: true,
                          controller: passwordController,
                          hintText: "********",
                        ),
                        const GetTextFunc2(text: "Parolni tasdiqlang"),
                        WTextField(
                          obscuringCharacter: "*",
                          obscureText: true,
                          controller: passwordConfirmationController,
                          hintText: "********",
                        ),
                        const Gap(35),
                        GestureDetector(
                          onTap: () {
                            int cityId = 0;
                            for (var i = 0; i < state.city.length; i++) {
                              if (state.city[i].name == state.cityName) {
                                cityId = state.city[i].regionId;
                              }
                            }
                            if (nameController.text.isEmpty) {
                              wSnacbar("Ism maydonini to'ldiring", context);
                              return;
                            } else if (surNameController.text.isEmpty) {
                              wSnacbar(
                                  "Familiya maydonini to'ldiring", context);
                              return;
                            } else if (phoneController.text.isEmpty) {
                              wSnacbar("Telefon raqam kiriting", context);
                              return;
                            } else if (phoneController.text.length < 9 ||
                                phoneController.text.length > 9) {
                              print(phoneController.text);
                              wSnacbar(
                                  "Telefon raqamni quyidagi ko'rinishda kiriting: 991235522",
                                  context);
                              return;
                            } else if (passwordController.text.isEmpty) {
                              wSnacbar("Parolingizni kiriting", context);
                              return;
                            } else if (passwordController.text.length < 6) {
                              wSnacbar("Paroli kamida 6 xonali bo'lishi kerak",
                                  context);
                              return;
                            } else if (passwordConfirmationController.text !=
                                passwordController.text) {
                              wSnacbar(
                                  "Tastiqlash kodi mos kelmayapti", context);
                              return;
                            } else if (int.tryParse(birthDateController.text) ==
                                    null ||
                                int.tryParse(birthDateController.text) !=
                                        null &&
                                    int.parse(birthDateController.text) > 31) {
                              wSnacbar("Tug'ilgan sanangizni to'g'ri kiriting!",
                                  context);
                              return;
                            } else if (int.tryParse(
                                        birthMonthController.text) ==
                                    null ||
                                int.tryParse(birthMonthController.text) !=
                                        null &&
                                    int.parse(birthMonthController.text) > 12) {
                              wSnacbar("Tug'ilgan oyingizni to'g'ri kiriting!",
                                  context);
                              return;
                            } else if (int.tryParse(birthYearController.text) ==
                                    null ||
                                int.tryParse(birthYearController.text) !=
                                        null &&
                                    int.parse(birthYearController.text) >
                                        DateTime.now().year ||
                                int.parse(birthYearController.text) < 1900) {
                              wSnacbar("Tug'ilgan yilingizni to'g'ri kiriting!",
                                  context);
                              return;
                            }
                            context.read<AuthBlocBloc>().add(
                                  RegisterEvent(
                                    failure: () {
                                      wSnacbar("Internet aloqasini tekshiring",
                                          context);
                                    },
                                    onSuccess: () {
                                      Navigator.pushNamed(
                                          context, AppRouteName.verification);
                                    },
                                    imageName: image?.name,
                                    imagePath: image?.path == null
                                        ? null
                                        : File(image!.path),
                                    name: nameController.text,
                                    surName: surNameController.text,
                                    number: "+998${phoneController.text}",
                                    password: passwordController.text,
                                    birthDate:
                                        "${birthYearController.text}-${birthMonthController.text}-${birthDateController.text}",
                                    gender: state.genderExpansiontileIndex,
                                    passwordConfirmation:
                                        passwordController.text,
                                    cityId: cityId == 0 ? null : cityId,
                                  ),
                                );
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: context.colors.orange,
                            ),
                            child: Text(
                              "Yuborish",
                              style: context.style.fontSize19Weight400.copyWith(
                                color: context.colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
