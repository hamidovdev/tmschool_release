import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:tm_school/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tm_school/features/dashboard/presentation/widgets/w_notifiaction_item.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    context.read<DashboardBloc>().add(
          ClearBlocEvent(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String resultDesc(String desc) {
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
      return description;
    }

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
                "Bildirishnoma",
                style: context.style.fontSize20Weight500,
              ),
            ),
            SvgPicture.asset(context.icon.notificationsIcon)
          ],
        ),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          switch (state.mainStatus) {
            case MainStatus.pure:
              context.read<DashboardBloc>().add(
                    GetNewsEvent(
                      success: () {},
                      haveGroupDate: true,
                    ),
                  );
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
              if (state.forNotifications.isEmpty) {
                return Center(
                  child: Text(
                    "Hozircha yangiliklar yo'q",
                    style: context.style.fontSize22Weight600.copyWith(
                      color: context.colors.darkGrey,
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: [
                      ...List.generate(
                        state.forNotifications.length,
                        (i) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(25),
                            SizedBox(
                              width:
                                  MediaQuery.sizeOf(context).width / 100 * 70,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                state.forNotifications[i].groupDate ==
                                        "${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().year}"
                                    ? "Bugun"
                                    : state.forNotifications[i].groupDate,
                                style: context.style.fontSize18Weight600,
                              ),
                            ),
                            const Gap(20),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 13, right: 13, bottom: 13),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: context.colors.notificationsBgColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: List.generate(
                                  state.forNotifications[i].data.length,
                                  (j) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).pushNamed(AppRouteName.news,
                                          arguments: state
                                              .forNotifications[i].data[j]);
                                    },
                                    child: WNotificationItem(
                                      image: state
                                          .forNotifications[i].data[j].images,
                                      title: state
                                          .forNotifications[i].data[j].title,
                                      desc: state.forNotifications[i].data[j]
                                          .description,
                                      date: state.forNotifications[i].data[j]
                                          .createdTime,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(40),
                    ],
                  ),
                );
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
