// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/features/courses/presentation/bloc/courses_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WYouTubePlayer extends StatelessWidget {
  final String initialVideoId;
  const WYouTubePlayer({
    super.key,
    required this.initialVideoId,
  });

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );
    return YoutubePlayer(
      width: MediaQuery.sizeOf(context).width,
      controller: controller,
      showVideoProgressIndicator: true,
      progressColors: ProgressBarColors(
        playedColor: context.colors.mainRadishColor,
        bufferedColor: context.colors.mainRadishColor,
      ),
      onReady: () {
        controller.addListener(() {});
      },
      bottomActions: [
        CurrentPosition(),
        ProgressBar(
          isExpanded: true,
          colors: ProgressBarColors(
            playedColor: context.colors.mainRadishColor,
            handleColor: context.colors.mainRadishColor,
          ),
        ),
        const PlaybackSpeedButton(),
        FullScreenButton(
          controller: controller,
        ),
      ],
    );
  }
}
