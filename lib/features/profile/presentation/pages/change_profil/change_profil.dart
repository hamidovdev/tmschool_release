// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tm_school/assets/icons.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/widgets/w_expansiontile.dart';
import 'package:tm_school/core/widgets/w_textfield.dart';
import 'package:tm_school/features/authentification/presentation/widgets/signin_widgets.dart';
import 'package:tm_school/features/profile/data/model/model.dart';
import 'package:tm_school/features/profile/data/model/update_model.dart';
import 'package:tm_school/features/profile/presentation/bloc/profil_bloc.dart';

class ChangeProfile extends StatefulWidget {
  final UserProfile userProfile;
  const ChangeProfile({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
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
    nameController = TextEditingController(text: widget.userProfile.name);
    surNameController = TextEditingController(text: widget.userProfile.surname);
    birthDateController = TextEditingController(
        text: widget.userProfile.birthDate?.split("-")[2] ?? "DD");
    birthMonthController = TextEditingController(
        text: widget.userProfile.birthDate?.split("-")[1] ?? "MM");
    birthYearController = TextEditingController(
        text: widget.userProfile.birthDate?.split("-")[0] ?? "YY");
    regionController = ExpansionTileController();
    cityController = ExpansionTileController();
    phoneController =
        TextEditingController(text: widget.userProfile.mobileNumber);
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    context.read<ProfilBloc>().add(RegionNameEvent());
    context.read<ProfilBloc>().add(CityNameProfilEvent(id: 1));
    super.initState();
  }

  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(context.icon.arrowLeft),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 100 * 60,
              child: Text(
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                "Profile",
                style: context.style.fontSize20Weight500,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRouteName.notifications,
                );
              },
              child: SvgPicture.asset(context.icon.notificationsIcon),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProfilBloc, ProfilState>(
        builder: (context, state) {
          switch (state.status) {
            case ProfilStatus.success:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    const Gap(23),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                height:
                                    (MediaQuery.of(context).size.height / 100) *
                                        14.7,
                                width:
                                    (MediaQuery.of(context).size.height / 100) *
                                        14.7,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: image == null
                                        ? state.userProfile.image == null
                                            ? Border.all(
                                                color: context.colors.orange,
                                              )
                                            : null
                                        : null),
                                child: state.userProfile.image != null &&
                                        image == null
                                    ? Image.network(
                                        state.userProfile.image!,
                                        fit: BoxFit.cover,
                                      )
                                    : image == null
                                        ? Stack(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        100) *
                                                    14.7,
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        100) *
                                                    14.7,
                                                child: SvgPicture.asset(
                                                  context.icon.noPhoto,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Image.file(
                                            File(image!.path),
                                            fit: BoxFit.cover,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    100) *
                                                14.7,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    100) *
                                                14.7,
                                          ),
                              ),
                            ),
                            const Gap(20),
                            GestureDetector(
                              onTap: () async {
                                image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 26.h,
                                width: 125.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: context.colors.orange,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Rasm o’zgartirish",
                                  style: context.style.fontSize12Weight500
                                      .copyWith(
                                    fontSize: 12.sp,
                                    color: context.colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(22),
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
                      textStyle: context.style.fontSize18Weight400,
                      textAlign: TextAlign.start,
                    ),
                    const GetTextFunc2(text: "Familiyangiz"),
                    WTextField(
                      controller: surNameController,
                      textStyle: context.style.fontSize18Weight400,
                      textAlign: TextAlign.start,
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
                            controller: birthDateController,
                            textStyle: context.style.fontSize18Weight400,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: WTextField(
                            controller: birthMonthController,
                            keyboardType: TextInputType.number,
                            textStyle: context.style.fontSize18Weight400,
                            maxLength: 2,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: WTextField(
                            controller: birthYearController,
                            keyboardType: TextInputType.number,
                            textStyle: context.style.fontSize18Weight400,
                            maxLength: 4,
                          ),
                        ),
                      ],
                    ),
                    const GetTextFunc2(text: "Jinsingiz"),
                    WExpansionTile(
                      controller: genderController,
                      title: state.gender,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ProfilBloc>().add(
                                  SelectGenderEvent(gender: "Erkak"),
                                );
                            genderController.collapse();
                          },
                          child: const SizedBox(
                            width: double.maxFinite,
                            child: GetTextFunc(text: "Erkak"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<ProfilBloc>().add(
                                  SelectGenderEvent(gender: "Ayol"),
                                );
                            genderController.collapse();
                          },
                          child: const SizedBox(
                            width: double.maxFinite,
                            child: GetTextFunc(text: "Ayol"),
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
                          state.regionNames.length,
                          (index) => GestureDetector(
                            onTap: () {
                              context.read<ProfilBloc>().add(
                                  CityNameProfilEvent(
                                      id: state.regionNames[index].id));
                              context.read<ProfilBloc>().add(SelectRegionName(
                                  region: state.regionNames[index].name));
                              regionController.collapse();
                            },
                            child: SizedBox(
                              width: double.maxFinite,
                              child: GetTextFunc(
                                text: state.regionNames[index].name,
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
                          state.cityNames.length,
                          (index) => GestureDetector(
                            onTap: () {
                              context.read<ProfilBloc>().add(SelectCityName(
                                  id: state.cityNames[index].id,
                                  city: state.cityNames[index].name));
                              cityController.collapse();
                            },
                            child: SizedBox(
                              width: double.maxFinite,
                              child: GetTextFunc(
                                text: state.cityNames[index].name,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const GetTextFunc2(text: "Telefon raqam"),
                    WTextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      hintText: "+998 __ ___ __ __",
                    ),
                    const GetTextFunc2(text: "Parol"),
                    WTextField(
                      obscureText: true,
                      obscuringCharacter: "*",
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      hintText: "********",
                    ),
                    const GetTextFunc2(text: "Parolni tasdiqlang"),
                    WTextField(
                      obscureText: true,
                      obscuringCharacter: "*",
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      hintText: "********",
                    ),
                    const Gap(35),
                    GestureDetector(
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          wSnacbar("Ism maydonini to'ldiring", context);
                          return;
                        } else if (surNameController.text.isEmpty) {
                          wSnacbar("Familiya maydonini to'ldiring", context);
                          return;
                        } else if (phoneController.text.isEmpty ||
                            phoneController.text.length < 13 ||
                            phoneController.text.length > 13) {
                          wSnacbar("Telefon raqamini kiriting", context);
                          return;
                        } else if (passwordController.text.isNotEmpty &&
                            passwordController.text.length < 6) {
                          wSnacbar(
                              "Paroli kamida 6 xonali bo'lishi kerak", context);
                          return;
                        } else if (passwordConfirmationController.text !=
                            passwordController.text) {
                          wSnacbar("Tastiqlash kodi mos kelmayapti", context);
                          return;
                        } else if (int.tryParse(birthDateController.text) ==
                                null ||
                            int.tryParse(birthDateController.text) != null &&
                                int.parse(birthDateController.text) > 31) {
                          wSnacbar("Tug'ilgan sanangizni to'g'ri kiriting!",
                              context);
                          return;
                        } else if (int.tryParse(birthMonthController.text) ==
                                null ||
                            int.tryParse(birthMonthController.text) != null &&
                                int.parse(birthMonthController.text) > 12) {
                          wSnacbar(
                              "Tug'ilgan oyingizni to'g'ri kiriting!", context);
                          return;
                        } else if (int.tryParse(birthYearController.text) ==
                                null ||
                            int.tryParse(birthYearController.text) != null &&
                                int.parse(birthYearController.text) >
                                    DateTime.now().year ||
                            int.parse(birthYearController.text) < 1900) {
                          wSnacbar("Tug'ilgan yilingizni to'g'ri kiriting!",
                              context);
                          return;
                        }
                        context.read<ProfilBloc>().add(
                              UpdateEvent(
                                updateModel: UpdateModel(
                                  birthDate:
                                      "${birthYearController.text}-${birthMonthController.text}-${birthDateController.text}",
                                  cityId: state.cityId,
                                  gender: state.gender == "Erkak" ? 1 : 0,
                                  imageName: image?.name,
                                  imagePath: image?.path == null
                                      ? null
                                      : File(image!.path),
                                  name: nameController.text,
                                  surname: surNameController.text,
                                  mobilNumber: phoneController.text,
                                  password: passwordController.text,
                                ),
                                onSuccess: () {
                                  context
                                      .read<ProfilBloc>()
                                      .add(GetProfilDataEvent());
                                  Navigator.pop(context);
                                },
                                failure: () {
                                  wSnacbar("Internet aloqasini tekshiring!",
                                      context);
                                },
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
                          "Saqlash",
                          style: context.style.fontSize19Weight400.copyWith(
                            color: context.colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Gap(35),
                  ],
                ),
              );
            case ProfilStatus.loading:
              return const Center(
                child: CupertinoActivityIndicator(),
              );

            default:
              return const Center(
                child: CupertinoActivityIndicator(),
              );
          }
        },
      ),
    );
  }
}
