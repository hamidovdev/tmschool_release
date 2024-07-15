import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';

class WSavedCourse extends StatelessWidget {
  final String bgImg;
  final String courseTitle;
  final String courseName;
  // final String courseLength;

  const WSavedCourse({
    super.key,
    required this.bgImg,
    required this.courseTitle,
    required this.courseName,
    // required this.courseLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(3),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: context.colors.coursesItemBgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                bgImg,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              SvgPicture.asset(
                context.icon.playSavedCircle,
                height: 32,
                width: 32,
              ),
            ],
          ),
          const Gap(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 100 * 50,
                child: Text(
                  courseTitle,
                  style: context.style.fontSize14Weight600,
                ),
              ),
              const Gap(8),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 100 * 40,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  courseName,
                  style: context.style.fontSize12Weight400,
                ),
              ),
              // const Gap(6),
              // SizedBox(
              //   width: MediaQuery.sizeOf(context).width / 100 * 20,
              //   child: Text(
              //     overflow: TextOverflow.ellipsis,
              //     maxLines: 1,
              //     courseLength,
              //     style: context.style.fontSize7Weight600
              //         .copyWith(color: context.colors.mainRadishColor),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
