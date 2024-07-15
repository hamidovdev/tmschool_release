// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/either/either.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/features/courses/data/model/models.dart';
import 'package:tm_school/features/courses/presentation/bloc/courses_bloc.dart';

class WDropDown extends StatefulWidget {
  final int index;
  final LessonModel lesson;
  final YoutubePlayerController controller;
  final Callback success;

  const WDropDown({
    Key? key,
    required this.index,
    required this.lesson,
    required this.controller,
    required this.success,
  }) : super(key: key);

  @override
  State<WDropDown> createState() => _WDropDownState();
}

class _WDropDownState extends State<WDropDown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<CoursesBloc>().add(
                      EditActiveCourseIndex(activeCourseInd: widget.index),
                    );
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.maxFinite,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: context.colors.coursesItemBgColor,
                ),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 100 * 70,
                      child: Text(
                        widget.lesson.name,
                        style: context.style.fontSize16Weight500,
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      state.activeCoursesList.contains(widget.index)
                          ? context.icon.drop
                          : context.icon.right,
                    ),
                  ],
                ),
              ),
            ),
            state.activeCoursesList.contains(widget.index)
                ? Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: context.colors.coursesItemBgColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: double.maxFinite,
                    child: BlocBuilder<CoursesBloc, CoursesState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            ...List.generate(
                                widget.lesson.videos.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        context.read<CoursesBloc>().add(
                                              EditActiveVideoEvent(
                                                video:
                                                    widget.lesson.videos[index],
                                                lessonId: widget.lesson.name,
                                                videoIndex: index,
                                                success: () {},
                                              ),
                                            );
                                        widget.success(
                                            widget.lesson.videos[index].link);
                                        setState(() {});
                                      },
                                      child: Container(
                                        color: state.activeVideoIndex ==
                                                "${widget.lesson.name}-$index"
                                            ? context.colors.mainRadishColor
                                                .withOpacity(0.2)
                                            : context.colors.transparentColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              context.icon.playCircle,
                                            ),
                                            const Gap(15),
                                            Text(
                                              widget
                                                  .lesson.videos[index].lesson,
                                              style: context
                                                  .style.fontSize14Weight500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                          ],
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
