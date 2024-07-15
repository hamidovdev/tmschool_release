import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/widgets/w_button.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tm_school/features/dashboard/presentation/widgets/w_modal.dart';

class NewsPage extends StatelessWidget {
  final DatumEntity data;

  const NewsPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String descriptionValue = "";
    for (int i = 1; i > data.description.length; i++) {
      if (data.description[i] == ">") {
        break;
      } else {
        descriptionValue += data.description[i];
      }
    }
    String description = data.description.substring(
      descriptionValue.length + 3,
      data.description.length - (descriptionValue.length + 4),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(context.icon.arrowLeft),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 100 * 60,
              child: Text(
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                "Yangiliklar",
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
              child: SvgPicture.asset(context.icon.notificationsIcon),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const Gap(30),
            Image.network(
              data.images,
              width: double.maxFinite,
              height: 256,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                context.image.internetConnectionImg1,
                width: 256,
                height: 256,
              ),
            ),
            const Gap(20),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 100 * 60,
              child: Text(
                data.title,
                style: context.style.fontSize18Weight500,
              ),
            ),
            const Gap(15),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Text(
                description,
                style: descriptionValue == "h1"
                    ? context.style.fontSize18Weight500
                    : (descriptionValue == "h2"
                        ? context.style.fontSize16Weight400
                        : (descriptionValue == "h3"
                            ? context.style.fontSize14Weight400
                            : context.style.fontSize12Weight400)),
              ),
            ),
            const Gap(30),
            data.status != "0"
                ? WButton(
                    onTap: () {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return ModalWidget(
                            newsId: data.id.toString(),
                            image: data.images,
                            title: data.title,
                            desc: description,
                            isFirstModal: true,
                          );
                        },
                      );
                    },
                    text: "Kursga yozilish",
                    borderRadius: 5,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
