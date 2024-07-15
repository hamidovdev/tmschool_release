import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/assets/images.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/route_names/dashboard_route_names.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tm_school/features/dashboard/presentation/widgets/course_widget.dart';
import 'package:tm_school/features/home/bloc/home_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CarouselController carouselController = CarouselController();
  List<String> images = [
    AppImages().courseImg1,
    AppImages().courseImg2,
    AppImages().courseImg3,
    AppImages().courseImg4,
  ];
  List<String> titles = ["Beginner", "Elementary", "Beginner", "Elementary"];

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(
          ClearBlocEvent(),
        );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            switch (state.appbarStatus) {
              case MainStatus.pure:
                context.read<DashboardBloc>().add(
                      GetUserInfoEvent(),
                    );
                return const SizedBox();
              case MainStatus.loading:
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              case MainStatus.failure:
                return Center(
                  child: Text(
                    "Xatolik",
                    style: context.style.fontSize20Weight600.copyWith(
                      color: context.colors.mainRadishColor,
                    ),
                  ),
                );
              case MainStatus.success:
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(AppRouteName.profile);
                      },
                      child: state.userInfo!.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                state.userInfo!.image!,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    width: 40,
                                    height: 40,
                                    context.image.userDefaultIcon,
                                  );
                                },
                              ),
                            )
                          : Image.asset(
                              width: 40,
                              height: 40,
                              context.image.userDefaultIcon,
                            ),
                    ),
                    const Gap(15),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 100 * 68,
                      child: Text(
                        state.userInfo!.fullName,
                        style: context.style.fontSize20Weight600
                            .copyWith(color: context.colors.mainRadishColor),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRouteName.notifications,
                        );
                      },
                      child: SvgPicture.asset(context.icon.notificationsIcon),
                    ),
                  ],
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<DashboardBloc>().add(
                ClearBlocEvent(),
              );
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            switch (state.mainStatus) {
              case MainStatus.pure:
                context.read<DashboardBloc>().add(GetNewsEvent(
                      success: () {
                        context.read<DashboardBloc>().add(
                              GetCoursesEvent(),
                            );
                      },
                      haveGroupDate: false,
                    ));
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              case MainStatus.loading:
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              case MainStatus.failure:
                return Center(
                  child: Text(
                    "Xatolik",
                    style: context.style.fontSize20Weight600.copyWith(
                      color: context.colors.mainRadishColor,
                    ),
                  ),
                );
              case MainStatus.success:
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListView(
                    children: [
                      Text(
                        "Yangiliklar",
                        style: context.style.fontSize18Weight600,
                      ),
                      const Gap(11),
                      BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              CarouselSlider(
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  height: 207,
                                  padEnds: false,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    context.read<DashboardBloc>().add(
                                          EditCarouselPage(
                                            pageNum: index,
                                          ),
                                        );
                                  },
                                ),
                                items: state.news.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pushNamed(
                                              AppRouteName.news,
                                              arguments: DatumEntity(
                                                id: i.id,
                                                status: i.status,
                                                images: i.images,
                                                title: i.title,
                                                description: i.description,
                                                createdTime: i.createdTime,
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            i.images,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              context
                                                  .image.internetConnectionImg1,
                                              width: 256,
                                              height: 256,
                                            ),
                                          ));
                                    },
                                  );
                                }).toList(),
                              ),
                              const Gap(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    state.news.length,
                                    (index) => AnimatedContainer(
                                      margin: const EdgeInsets.only(
                                          right: 3.5, left: 3.5),
                                      duration:
                                          const Duration(milliseconds: 250),
                                      height: 6,
                                      width: state.carouselPageNumber == index
                                          ? 23
                                          : 6,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: state.carouselPageNumber ==
                                                  index
                                              ? context.colors.mainRadishColor
                                              : context.colors
                                                  .carouselPgNumGreyishColor),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Column(
                          children: List.generate(
                            state.courses.length,
                            (index) {
                              DateTime cr = state.courses[index].createdAt;
                              return GestureDetector(
                                onTap: () {
                                  context.read<HomeBloc>().add(
                                        EditBottomBarIndexEvent(
                                          ind: 1,
                                        ),
                                      );
                                  Navigator.of(context, rootNavigator: false)
                                      .pushNamed(
                                    DashboardRouteNames.coursesScreen,
                                    arguments:
                                        state.courses[index].id.toString(),
                                  );
                                },
                                child: CourseWidget(
                                  courseImg: state.courses[index].images,
                                  courseTitle: state.courses[index].name,
                                  courseElementNumber:
                                      state.courses[index].lessonsCount,
                                  courseLength: "${cr.hour}:${cr.minute}",
                                  courseDescription:
                                      state.courses[index].lessonTitle,
                                  completed: state.courses[index].percentage,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
