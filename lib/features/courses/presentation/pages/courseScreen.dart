import 'dart:async';

import 'package:bounce/bounce.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:tm_school/core/widgets/w_textfield.dart';
import 'package:tm_school/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:tm_school/features/courses/presentation/widgets/w_drop_down.dart';
import 'package:tm_school/features/courses/presentation/widgets/w_you_tube_player.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tm_school/features/home/bloc/home_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursesScreen extends StatefulWidget {
  final String? courseId;
  final String? lessonId;
  final String? videoId;
  const CoursesScreen({
    super.key,
    this.courseId,
    this.lessonId,
    this.videoId,
  });

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    context.read<CoursesBloc>().add(
          ClearCourseBlocEvent(),
        );
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    pageController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CoursesBloc>().add(
              ClearCourseBlocEvent(),
            );
      },
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          // if (state.controller != null &&
          //     state.thisPage == 0 &&
          //     state.controller!.value.isFullScreen) {
          //   state.controller!.toggleFullScreenMode();
          // }
          // context.read<CoursesBloc>().add(EditThisPage());
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 90,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.courseId != null)
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            context.read<HomeBloc>().add(
                                  EditBottomBarIndexEvent(
                                    ind:
                                        state.bottomBarController.oldIndex ?? 0,
                                  ),
                                );
                            context.read<CoursesBloc>().add(
                                  ClearCourseBlocEvent(),
                                );
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(context.icon.arrowLeft),
                        );
                      },
                    ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 100 * 60,
                    child: Text(
                      maxLines: 1,
                      textAlign: widget.courseId != null
                          ? TextAlign.center
                          : TextAlign.start,
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
                    },
                    child: SvgPicture.asset(
                      context.icon.notificationsIcon,
                    ),
                  ),
                ],
              ),
            ),
            body: Builder(
              builder: (context) {
                switch (state.mainStatus) {
                  case MainStatus.pure:
                    context.read<CoursesBloc>().add(
                          GetLessonsEvent(
                            courseId: widget.courseId == null
                                ? "1"
                                : widget.courseId!,
                            lessonId: widget.lessonId,
                            videoId: widget.videoId,
                            success: () {
                              context.read<DashboardBloc>().add(
                                    PercentageEvent(
                                      courseId: widget.courseId!,
                                      lessonId: state.activeVideo!.lessonId
                                          .toString(),
                                      videoId: state.activeVideo!.id.toString(),
                                      success: () {},
                                    ),
                                  );
                            },
                          ),
                        );
                    return const SizedBox();
                  case MainStatus.failure:
                    return const Center(
                      child: Text("Xatolik"),
                    );
                  case MainStatus.loading:
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  case MainStatus.success:
                    // print(
                    //     " **********State ichidagi controller holatin ${state.controller!.addListener(() { })}");
                    // context.read<CoursesBloc>().add(
                    //       EditFullScreenEvent(
                    //         success: () {},
                    //         failure: () {},
                    //       ),
                    //     );
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        state.controller!.value.isFullScreen
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 15),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width /
                                      100 *
                                      40,
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    "Beginner",
                                    style: context.style.fontSize18Weight600,
                                  ),
                                ),
                              ),
                        Gap(state.controller!.value.isFullScreen ? 0 : 20),
                        // YoutubePlayer(
                        //   controller: controller!,
                        //   showVideoProgressIndicator: true,
                        //   progressColors: ProgressBarColors(
                        //     playedColor: context.colors.mainRadishColor,
                        //     bufferedColor: context.colors.mainRadishColor,
                        //   ),
                        // ),
                        Stack(
                          children: [
                            Hero(
                              transitionOnUserGestures: false,
                              tag: "youtubeplayer_video",
                              child: BlocBuilder<CoursesBloc, CoursesState>(
                                builder: (context, state) {
                                  return SizedBox(
                                    height: state.controller!.value.isFullScreen
                                        ? MediaQuery.sizeOf(context).height /
                                            100 *
                                            90
                                        : 220.h,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: state.controller!.value
                                                    .isFullScreen
                                                ? 0
                                                : 15,
                                            right: state.controller!.value
                                                    .isFullScreen
                                                ? 0
                                                : 15,
                                            top: state.controller!.value
                                                    .isFullScreen
                                                ? MediaQuery.of(context)
                                                        .padding
                                                        .top +
                                                    0
                                                : 0,
                                            bottom: 0),
                                        child: WYouTubePlayer(
                                          initialVideoId:
                                              YoutubePlayer.convertUrlToId(state
                                                      .activeVideo!.link) ??
                                                  "",
                                        )),
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                  AppRouteName.youtubePlayerPage,
                                );
                              },
                              child: Container(
                                color: context.colors.transparentColor,
                                width: double.maxFinite,
                                height: 200,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15),
                          child: BlocBuilder<CoursesBloc, CoursesState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.read<CoursesBloc>().add(
                                                  EditActivePageIndex(
                                                    ind: 0,
                                                  ),
                                                );
                                          },
                                          child: SvgPicture.asset(
                                            state.activePageIndex == 0
                                                ? context.icon.activeInfo
                                                : context.icon.info,
                                          ),
                                        ),
                                        const Gap(20),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<CoursesBloc>().add(
                                                  EditActivePageIndex(
                                                    ind: 1,
                                                  ),
                                                );
                                          },
                                          child: SvgPicture.asset(
                                            state.activePageIndex == 1
                                                ? context.icon.activeComment
                                                : context.icon.comment,
                                          ),
                                        ),
                                        const Gap(20),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<CoursesBloc>().add(
                                                  EditActivePageIndex(
                                                    ind: 2,
                                                  ),
                                                );
                                          },
                                          child: SvgPicture.asset(
                                            state.activePageIndex == 2
                                                ? context.icon.active
                                                : context.icon.deActive,
                                          ),
                                        ),
                                        const Gap(20),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  100 *
                                                  20,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: context
                                                    .colors.mainRadishColor,
                                                size: 20,
                                              ),
                                              const Gap(5),
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                state.activeVideo!.viewCount
                                                    .toString(),
                                                style: context
                                                    .style.fontSize16Weight500
                                                    .copyWith(
                                                  color: context
                                                      .colors.mainRadishColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Bounce(
                                          filterQuality: FilterQuality.medium,
                                          scale: true,
                                          tilt: true,
                                          tiltAngle: 20,
                                          onTap: () {
                                            context.read<CoursesBloc>().add(
                                                  ClickBtnsEvent(
                                                    videoId: state
                                                        .activeVideo!.id
                                                        .toString(),
                                                    param:
                                                        state.activeVideo!.liked
                                                            ? "like"
                                                            : "disLike",
                                                  ),
                                                );
                                          },
                                          child: SvgPicture.asset(
                                            // width: 26,
                                            // height: 26,
                                            state.activeVideo!.liked
                                                ? context.icon.activeLike
                                                : context.icon.like,
                                          ),
                                        ),
                                        const Gap(20),
                                        Bounce(
                                          filterQuality: FilterQuality.medium,
                                          scale: true,
                                          tilt: true,
                                          tiltAngle: 20,
                                          onTap: () {
                                            context.read<CoursesBloc>().add(
                                                  ClickBtnsEvent(
                                                    videoId: state
                                                        .activeVideo!.id
                                                        .toString(),
                                                    param:
                                                        state.activeVideo!.saved
                                                            ? "save"
                                                            : "noSave",
                                                  ),
                                                );
                                          },
                                          child: SvgPicture.asset(
                                            state.activeVideo!.saved
                                                ? context.icon.activeSave
                                                : context.icon.save,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Gap(15),
                                  state.activePageIndex == 0
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.activeVideo!.description,
                                              style: context
                                                  .style.fontSize12Weight400,
                                            ),
                                            if (state
                                                .activeVideo!.files.isNotEmpty)
                                              ...List.generate(
                                                  state.activeVideo!.files
                                                      .length, (index) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    await bottomSheet(context);
                                                    // Timer(
                                                    //     const Duration(
                                                    //         seconds: 3), () {
                                                    //   Navigator.pop(context);
                                                    // });

                                                    await _downloadFileFromUrl(
                                                        state
                                                            .activeVideo!
                                                            .files[0]
                                                            .originalUrl!);
                                                  },
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.file_open,
                                                      color: context.colors
                                                          .mainRadishColor,
                                                    ),
                                                  ),
                                                );
                                              })
                                          ],
                                        )
                                      : (state.activePageIndex == 1
                                          ? SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height /
                                                  100 *
                                                  37,
                                              child: Stack(
                                                // alignment:
                                                //     Alignment.bottomCenter,
                                                children: [
                                                  BlocBuilder<CoursesBloc,
                                                      CoursesState>(
                                                    builder: (context, state) {
                                                      switch (state
                                                          .commentsStatus) {
                                                        case MainStatus.pure:
                                                          context
                                                              .read<
                                                                  CoursesBloc>()
                                                              .add(
                                                                GetCommentsEvent(
                                                                  videoId: state
                                                                      .activeVideo!
                                                                      .id
                                                                      .toString(),
                                                                ),
                                                              );
                                                          return const SizedBox();
                                                        case MainStatus.loading:
                                                          return const Center(
                                                            child:
                                                                CupertinoActivityIndicator(),
                                                          );
                                                        case MainStatus.success:
                                                          return ListView(
                                                              shrinkWrap: true,
                                                              children: [
                                                                ...List
                                                                    .generate(
                                                                  state.comments
                                                                      .length,
                                                                  (index) =>
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width /
                                                                        100 *
                                                                        80,
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            5),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          child: state.comments[index].user.image == null
                                                                              ? Image.asset(
                                                                                  context.image.userDefaultIcon,
                                                                                  width: 32.w,
                                                                                  height: 32.h,
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              : Image.network(
                                                                                  state.comments[index].user.image!,
                                                                                  width: 32.w,
                                                                                  height: 32.h,
                                                                                  fit: BoxFit.cover,
                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                    context.image.internetConnectionImg1,
                                                                                    width: 32,
                                                                                    height: 32,
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                        const Gap(
                                                                            9),
                                                                        SizedBox(
                                                                          width: MediaQuery.sizeOf(context).width /
                                                                              100 *
                                                                              75,
                                                                          child:
                                                                              Text(
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            maxLines:
                                                                                2,
                                                                            state.comments[index].comments,
                                                                            style:
                                                                                context.style.fontSize7Weight600.copyWith(fontSize: 7.sp),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Gap(45),
                                                              ]);
                                                        default:
                                                          return const SizedBox();
                                                      }
                                                    },
                                                  ),
                                                  // const Spacer(),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      height: 43,
                                                      color: context.colors
                                                          .commentPageInpColor,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 7,
                                                          horizontal: 23),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: WTextField(
                                                              controller:
                                                                  textEditingController,
                                                              hintText: "Izoh",
                                                              hintTextSytle: context
                                                                  .style
                                                                  .fontSize7Weight600
                                                                  .copyWith(
                                                                color: context
                                                                    .colors
                                                                    .a8a8Color,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              filled: true,
                                                              fillColor: context
                                                                  .colors.white,
                                                              borderColor: context
                                                                  .colors
                                                                  .transparentColor,
                                                            ),
                                                          ),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.33),
                                                              decoration: BoxDecoration(
                                                                  color: context
                                                                      .colors
                                                                      .mainRadishColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                          CoursesBloc>()
                                                                      .add(
                                                                        SendCommentEvent(
                                                                          message:
                                                                              textEditingController.text,
                                                                          videoId: state
                                                                              .activeVideo!
                                                                              .id
                                                                              .toString(),
                                                                        ),
                                                                      );

                                                                  textEditingController
                                                                      .text = "";
                                                                },
                                                                child: SvgPicture
                                                                    .asset(context
                                                                        .icon
                                                                        .send),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : BlocBuilder<CoursesBloc,
                                              CoursesState>(
                                              builder: (context, state) {
                                                return Column(
                                                  children: List.generate(
                                                    state.lessons.length,
                                                    (index) => WDropDown(
                                                      lesson:
                                                          state.lessons[index],
                                                      index: index,
                                                      controller:
                                                          state.controller!,
                                                      success: (url) {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pushNamed(
                                                          AppRouteName
                                                              .youtubePlayerPage,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ))
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _downloadFileFromUrl(String fileUrl) async {
    final tp = fileUrl.split(".");
    final tempDir = await getApplicationCacheDirectory();
    final filePath = '${tempDir.path}/temp_file.${tp.last}';
    final dio = Dio();
    await dio.download(
      fileUrl,
      filePath,
      onReceiveProgress: (count, total) {
        if (count == total) {
          Navigator.pop(context);
        }
      },
    );
    OpenFile.open(filePath);
  }

  Future<void> bottomSheet(BuildContext context) async {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Center(
          child: CupertinoActivityIndicator(
            animating: true,
            radius: 20,
            color: context.colors.mainRadishColor,
          ),
        );
      },
    );
  }
}
