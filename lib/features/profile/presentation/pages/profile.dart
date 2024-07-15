import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/functions/app_functions.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/widgets/w_button.dart';
import 'package:tm_school/core/widgets/w_profil_widget.dart';
import 'package:tm_school/features/authentification/presentation/bloc/auth_bloc_bloc.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tm_school/features/profile/presentation/bloc/profil_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    context.read<ProfilBloc>().add(GetProfilDataEvent());
    super.initState();
  }

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
                context.read<DashboardBloc>().add(
                      GetUserInfoEvent(),
                    );
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
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 100) * 71.7,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: context.colors.textFieldBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: ((MediaQuery.of(context).size.height /
                                                100) *
                                            14.7) /
                                        2 +
                                    7,
                              ),
                              child: Text(
                                state.userProfile.name,
                                style: context.style.fontSize22Weight600,
                              ),
                            ),
                            const Gap(3),
                            Text(
                              state.userProfile.mobileNumber,
                              style: context.style.fontSize16Weight600.copyWith(
                                color: context.colors.darkGrey,
                              ),
                            ),
                            Gap(35.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRouteName.changeProfile,
                                    arguments: state.userProfile);
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: context.colors.transparentColor),
                                child: WProfileWidget(
                                  icon: context.icon.changeProfile,
                                  text: "Profil tahrirlash",
                                  wider: true,
                                ),
                              ),
                            ),
                            Gap(30.h),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  color: context.colors.transparentColor),
                              child: WProfileWidget(
                                icon: context.icon.shareApp,
                                text: "Share App",
                                wider: true,
                              ),
                            ),
                            Gap(30.h),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  color: context.colors.transparentColor),
                              child: WProfileWidget(
                                icon: context.icon.privacy,
                                text: "Privacy Policy",
                                wider: true,
                              ),
                            ),
                            Gap(30.h),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      elevation: 0,
                                      content: Container(
                                        decoration: BoxDecoration(
                                          color: context.colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                100 *
                                                40,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                100 *
                                                20,
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              "Haqiqatdan ham accauntdan chiqishni xoxlaysizmi?",
                                              style: context
                                                  .style.fontSize16Weight600
                                                  .copyWith(
                                                color: context.colors.a8a8Color,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                WButton(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  color: context
                                                      .colors.mainRadishColor,
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "No",
                                                  textStyle: context
                                                      .style.fontSize15Weight400
                                                      .copyWith(
                                                    color: context.colors.white,
                                                  ),
                                                ),
                                                WButton(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  color: context.colors.blue,
                                                  onTap: () {
                                                    context
                                                        .read<AuthBlocBloc>()
                                                        .add(
                                                          LogOutEvent(
                                                            onsuccess:
                                                                () async {
                                                              final shared = ins<
                                                                  SharedPreferences>();
                                                              final removeToken =
                                                                  await shared
                                                                      .remove(
                                                                          "token");
                                                              final removeId =
                                                                  await shared
                                                                      .remove(
                                                                          "id");
                                                              if (removeToken &&
                                                                  removeId) {
                                                                // ignore: use_build_context_synchronously
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamedAndRemoveUntil(
                                                                        AppRouteName
                                                                            .loginOrSignin,
                                                                        (route) =>
                                                                            false);
                                                              }
                                                            },
                                                            failure: () {
                                                              wSnacbar(
                                                                  "Xatolik bo'ldi",
                                                                  context);
                                                            },
                                                          ),
                                                        );
                                                  },
                                                  text: "Yes",
                                                  textStyle: context
                                                      .style.fontSize15Weight400
                                                      .copyWith(
                                                    color: context.colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: WProfileWidget(
                                icon: context.icon.logOut,
                                text: "Chiqish",
                                wider: false,
                                sytle:
                                    context.style.fontSize18Weight500.copyWith(
                                  color: context.colors.red,
                                ),
                              ),
                            ),
                            Gap(30.h),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      elevation: 0,
                                      content: Container(
                                        decoration: BoxDecoration(
                                          color: context.colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                100 *
                                                40,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                100 *
                                                20,
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              "Haqiqatdan ham accauntni o'chirishni xoxlaysizmi?",
                                              style: context
                                                  .style.fontSize16Weight600
                                                  .copyWith(
                                                color: context.colors.a8a8Color,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                WButton(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  color: context
                                                      .colors.mainRadishColor,
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "No",
                                                  textStyle: context
                                                      .style.fontSize15Weight400
                                                      .copyWith(
                                                    color: context.colors.white,
                                                  ),
                                                ),
                                                WButton(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  color: context.colors.blue,
                                                  onTap: () {
                                                    context
                                                        .read<AuthBlocBloc>()
                                                        .add(
                                                          DeleteAccauntEvent(
                                                            onsuccess:
                                                                () async {
                                                              final shared = ins<
                                                                  SharedPreferences>();
                                                              final removeToken =
                                                                  await shared
                                                                      .remove(
                                                                          "token");
                                                              final removeId =
                                                                  await shared
                                                                      .remove(
                                                                          "id");
                                                              if (removeToken &&
                                                                  removeId) {
                                                                // ignore: use_build_context_synchronously
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamedAndRemoveUntil(
                                                                        AppRouteName
                                                                            .loginOrSignin,
                                                                        (route) =>
                                                                            false);
                                                              }
                                                            },
                                                            failure: () {
                                                              wSnacbar(
                                                                  "Xatolik bo'ldi",
                                                                  context);
                                                            },
                                                          ),
                                                        );
                                                  },
                                                  text: "Yes",
                                                  textStyle: context
                                                      .style.fontSize15Weight400
                                                      .copyWith(
                                                    color: context.colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                // context.read<AuthBlocBloc>().add(
                                //       DeleteAccauntEvent(
                                //         onsuccess: () async {
                                //           final shared =
                                //               ins<SharedPreferences>();
                                //           final removeToken =
                                //               await shared.remove("token");
                                //           final removeId =
                                //               await shared.remove("id");
                                //           if (removeToken && removeId) {
                                //             // ignore: use_build_context_synchronously
                                //             Navigator.of(context)
                                //                 .pushNamedAndRemoveUntil(
                                //                     AppRouteName.loginOrSignin,
                                //                     (route) => false);
                                //           }
                                //         },
                                //         failure: () {
                                //           wSnacbar("Xatolik bo'ldi", context);
                                //         },
                                //       ),
                                //     );
                              },
                              child: WProfileWidget(
                                icon: context.icon.delete,
                                text: "Delete account",
                                wider: false,
                                sytle:
                                    context.style.fontSize18Weight500.copyWith(
                                  color: context.colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.only(
                          bottom: ((MediaQuery.of(context).size.height / 100) *
                                  71.7) -
                              (((MediaQuery.of(context).size.height / 100) *
                                      14.7) /
                                  2),
                        ),
                        height:
                            (MediaQuery.of(context).size.height / 100) * 14.7,
                        width:
                            (MediaQuery.of(context).size.height / 100) * 14.7,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: context.colors.textFieldBackground),
                            shape: BoxShape.circle,
                            color: context.colors.white),
                        child: state.userProfile.image != null
                            ? Image.network(
                                state.userProfile.image!,
                                fit: BoxFit.cover,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SvgPicture.asset(context.icon.noPhoto),
                              )),
                  ),
                ],
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
