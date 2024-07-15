// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/features/courses/presentation/bloc/courses_bloc.dart';

class ForYouTubeVideoPage extends StatelessWidget {
  // YoutubePlayerController controller;
  const ForYouTubeVideoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<CoursesBloc>().add(
              EditFullScreenEvent(
                success: () {},
                failure: () {},
              ),
            );
        Navigator.of(context).pop();

        return false;
      },
      child: Scaffold(
        body: BlocBuilder<CoursesBloc, CoursesState>(
          builder: (context, state) {
            return Container(
              width: double.maxFinite,
              height: MediaQuery.sizeOf(context).height,
              alignment: Alignment.center,
              color: Colors.black,
              child: SizedBox(
                height: state.controller!.value.isFullScreen
                    ? MediaQuery.sizeOf(context).width
                    : MediaQuery.sizeOf(context).height / 100 * 100,
                width: state.controller!.value.isFullScreen
                    ? MediaQuery.sizeOf(context).width
                    : MediaQuery.sizeOf(context).height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: "youtubeplayer_video",
                      child: YoutubePlayer(
                        controller: state.controller!,
                        onReady: () {
                          state.controller!.addListener(() {});
                        },
                        topActions: [
                          !state.controller!.value.isFullScreen
                              ? const SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: GestureDetector(
                                    onTap: () async {
                                      state.controller!.toggleFullScreenMode();
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                      context.icon.arrowLeft,
                                      color: context.colors.white,
                                    ),
                                  ),
                                ),
                        ],
                        bottomActions: [
                          CurrentPosition(),
                          ProgressBar(
                            isExpanded: true,
                            colors: ProgressBarColors(
                              playedColor: context.colors.mainRadishColor,
                              handleColor: context.colors.mainRadishColor,
                            ),
                          ),
                          RemainingDuration(),
                          const PlaybackSpeedButton(),
                          FullScreenButton(
                            controller: state.controller!,
                          ),
                        ],
                      ),
                    ),
                    state.controller!.value.isFullScreen
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 50),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  context.icon.arrowLeft,
                                  color: context.colors.white,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
