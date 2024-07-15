import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/route_names/saved_route_names.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:tm_school/core/widgets/w_button.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tm_school/features/home/bloc/home_bloc.dart';
import 'package:tm_school/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:tm_school/features/saved/presentation/widgets/w_saved_course.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(AppRouteName.home);
            //   },
            //   child: SvgPicture.asset(context.icon.arrowLeft),
            // ),
            // const Gap(40),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 100 * 60,
              child: Text(
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                "Kurslar",
                style: context.style.fontSize20Weight500,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRouteName.notifications,
                );
                context.read<DashboardBloc>().add(
                      ClearBlocEvent(),
                    );
              },
              child: SvgPicture.asset(
                context.icon.notificationsIcon,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SavedBloc>().add(
                GetSavedsEvent(),
              );
        },
        child: BlocBuilder<SavedBloc, SavedState>(
          builder: (context, state) {
            switch (state.mainStatus) {
              case MainStatus.pure:
                context.read<SavedBloc>().add(GetSavedsEvent());
                return const SizedBox();

              case MainStatus.failure:
                return Center(
                  child: Text(
                    "Xatolik",
                    style: context.style.fontSize20Weight600
                        .copyWith(color: context.colors.mainRadishColor),
                  ),
                );
              case MainStatus.loading:
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              case MainStatus.success:
                if (state.saveds.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Saqlangan darslar mavjud emas!",
                          style: context.style.fontSize20Weight600.copyWith(
                            color: context.colors.mainRadishColor,
                          ),
                        ),
                        const Gap(20),
                        WButton(
                          border: Border.fromBorderSide(BorderSide.none),
                          width: MediaQuery.sizeOf(context).width / 100 * 40,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          onTap: () {
                            context.read<SavedBloc>().add(
                                  GetSavedsEvent(),
                                );
                          },
                          text: "Yangilash",
                          textStyle: context.style.fontSize20Weight600
                              .copyWith(color: context.colors.a8a8Color),
                        )
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: [
                      ...List.generate(
                        state.saveds.length,
                        (i) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20),
                            SizedBox(
                              width:
                                  MediaQuery.sizeOf(context).width / 100 * 60,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                state.saveds[i].groupDate,
                                style: context.style.fontSize14Weight500,
                              ),
                            ),
                            const Gap(15),
                            ...List.generate(
                              state.saveds[i].data.length,
                              (j) {
                                final saved = state.saveds[i].data[j].video;
                                return GestureDetector(
                                  onTap: () {
                                    context.read<HomeBloc>().add(
                                          EditBottomBarIndexEvent(
                                            ind: 1,
                                          ),
                                        );
                                    Navigator.pushNamed(
                                      context,
                                      SavedRouteName.courseScreen,
                                      arguments:
                                          "${saved.courseId.toString()}_${saved.lessonId.toString()}_${saved.id.toString()}",
                                    );
                                  },
                                  child: WSavedCourse(
                                    bgImg: context.image.logo,
                                    courseTitle: saved.course,
                                    courseName: saved.description,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
