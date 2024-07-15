import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:tm_school/core/widgets/w_button.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class ModalWidget extends StatefulWidget {
  final bool isFirstModal;
  final String? image;
  final String? title;
  final String? desc;
  final String? newsId;

  const ModalWidget({
    super.key,
    this.image,
    this.title,
    this.desc,
    this.newsId,
    required this.isFirstModal,
  });

  @override
  State<ModalWidget> createState() => _ModalWidgetState();
}

class _ModalWidgetState extends State<ModalWidget> {
  @override
  void initState() {
    if (!widget.isFirstModal) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 0,
      backgroundColor: context.colors.white,
      content: widget.isFirstModal
          ? SizedBox(
              width: MediaQuery.sizeOf(context).width / 100 * 94,
              height: 400,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(context.icon.exit)),
                  ),
                  Image.network(
                    widget.image ?? "",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const Gap(20),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 100 * 70,
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      widget.title ?? "",
                      style: context.style.fontSize22Weight600,
                    ),
                  ),
                  const Gap(13),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 100 * 70,
                    child: Text(
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      widget.desc ?? "",
                      style: context.style.fontSize18Weight400,
                    ),
                  ),
                  const Spacer(),
                  WButton(
                    color: context.colors.mainRadishColor,
                    onTap: () {
                      context.read<DashboardBloc>().add(
                            JoinCourseEvent(
                              newsId: widget.newsId ?? "0",
                              success: () {
                                Navigator.pop(context);
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const ModalWidget(
                                        isFirstModal: false);
                                  },
                                );
                              },
                              failure: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Coursga yozila olmadingiz! Qaytadan urinib ko'ring.",
                                      style: context.style.fontSize16Weight600
                                          .copyWith(
                                              color: context
                                                  .colors.mainRadishColor),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                    },
                    borderRadius: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 100 * 47,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            "Kursga yozilish",
                            style: context.style.fontSize24Weight400
                                .copyWith(color: context.colors.white),
                          ),
                        ),
                        BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            return Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: context.colors.white),
                              width: 47,
                              height: 47,
                              child:
                                  state.joinCourseStatus == MainStatus.loading
                                      ? CupertinoActivityIndicator(
                                          color: context.colors.mainRadishColor,
                                          radius: 10,
                                        )
                                      : SvgPicture.asset(
                                          context.icon.rightLine,
                                        ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : SizedBox(
              width: MediaQuery.sizeOf(context).width / 100 * 94,
              height: 400,
              child: Column(
                children: [
                  const Gap(40),
                  Image.asset(
                    context.image.congratulations,
                    width: MediaQuery.sizeOf(context).width / 100 * 50,
                    height: MediaQuery.sizeOf(context).height / 100 * 25,
                    fit: BoxFit.cover,
                  ),
                  const Gap(13),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 100 * 70,
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      "Congratulations",
                      style: context.style.fontSize24Weight700,
                    ),
                  ),
                  const Gap(24),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 100 * 70,
                    child: Text(
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      "Kursga muvaffaqiyatli qo’shildingiz",
                      style: context.style.fontSize22Weight400,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
