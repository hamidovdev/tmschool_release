import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';

class CourseWidget extends StatelessWidget {
  final String courseImg;
  final String courseTitle;
  final int courseElementNumber;
  final String courseLength;
  final String courseDescription;
  final int completed;

  const CourseWidget({
    super.key,
    required this.courseImg,
    required this.courseTitle,
    required this.courseElementNumber,
    required this.courseLength,
    required this.courseDescription,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 15),
      width: double.maxFinite,
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: context.colors.coursesItemBgColor,
      ),
      child: Row(
        children: [
          Image.network(
            courseImg,
            fit: BoxFit.cover,
            width: 82,
            height: 82,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              context.image.internetConnectionImg1,
              width: 82,
              height: 82,
            ),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(5),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 100 * 38,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      courseTitle,
                      style: context.style.fontSize18Weight600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(context.icon.activeImg),
                      const Gap(2),
                      SizedBox(
                        width: 30,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          courseElementNumber.toString(),
                          style: context.style.fontSize8Weight400,
                        ),
                      )
                    ],
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(context.icon.timeImg),
                      const Gap(2),
                      SizedBox(
                        width: 40,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          courseLength,
                          style: context.style.fontSize8Weight400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Gap(3),
              SizedBox(
                width: 250,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  courseDescription,
                  style: context.style.fontSize14Weight400,
                ),
              ),
              const Gap(12),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width / 100 * 55,
                        height: 7,
                        decoration: BoxDecoration(
                          color:
                              context.colors.mainRadishColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width /
                            100 *
                            55 /
                            100 *
                            completed,
                        height: 7,
                        decoration: BoxDecoration(
                          color: context.colors.mainRadishColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  const Gap(9),
                  Text(
                    "$completed%",
                    style: context.style.fontSize8Weight400,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
