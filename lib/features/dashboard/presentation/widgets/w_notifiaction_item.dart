import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';

class WNotificationItem extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final String date;

  const WNotificationItem({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String descriptionValue = "";
    for (int i = 1; i > desc.length; i++) {
      if (desc[i] == ">") {
        break;
      } else {
        descriptionValue += desc[i];
      }
    }
    String description = desc.substring(
      descriptionValue.length + 3,
      desc.length - (descriptionValue.length + 4),
    );
    return Container(
      margin: const EdgeInsets.only(top: 13),
      padding: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: context.colors.c4Color))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              context.image.internetConnectionImg1,
              width: 64,
              height: 64,
            ),
          ),
          const Gap(9),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 100 * 60,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  title,
                  style: context.style.fontSize18Weight600,
                ),
              ),
              const Gap(3),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 100 * 60,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  description,
                  style: descriptionValue == "h1"
                      ? context.style.fontSize18Weight500
                      : (descriptionValue == "h2"
                          ? context.style.fontSize16Weight400
                          : (descriptionValue == "h3"
                              ? context.style.fontSize14Weight400
                              : context.style.fontSize12Weight400)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
