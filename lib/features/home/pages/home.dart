// ignore_for_file: deprecated_member_use, void_checks

import 'dart:async';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tm_school/core/extensions/extension.dart';
import 'package:tm_school/core/routes/courses_route.dart';
import 'package:tm_school/core/routes/dashboard_route.dart';
import 'package:tm_school/core/routes/premium_route.dart';
import 'package:tm_school/core/routes/saved_route.dart';
import 'package:tm_school/core/widgets/w_button.dart';
import 'package:tm_school/features/home/bloc/home_bloc.dart';

int pagesController = 0;
void aaaaa(int id) {}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return await _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    context.read<HomeBloc>().add(
          EditConnectivity(
            result: result,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      context.icon.home,
      context.icon.play,
      context.icon.premium,
      context.icon.saved
    ];
    List<String> names = ["Asosiy", "Darslar", "Premium", "Saqlanganlar"];

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          bool shouldExit = false;
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
            return Future.value(false);
          } else {
            context.read<HomeBloc>().add(
                  EditPageEvent(
                    index: 0,
                    success: () {
                      context.read<HomeBloc>().add(
                            EditBottomBarIndexEvent(
                              ind: 0,
                            ),
                          );
                    },
                    failure: () async {
                      shouldExit = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          elevation: 0,
                          contentTextStyle: context.style.fontSize14Weight400,
                          titleTextStyle: context.style.fontSize22Weight600,
                          title: const Text(
                            'Ishonchingiz komilmi?',
                          ),
                          content: const Text(
                            'Dasturdan chiqishni xoxlaysizmi',
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text(
                                    'No',
                                    style: context.style.fontSize18Weight600
                                        .copyWith(
                                      color: context.colors.blue,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text(
                                    'Yes',
                                    style: context.style.fontSize18Weight600
                                        .copyWith(
                                      color: context.colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
          }
          return shouldExit;
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.connectionStatus[0] == ConnectivityResult.mobile ||
                state.connectionStatus[0] == ConnectivityResult.wifi ||
                state.connectionStatus[0] == ConnectivityResult.ethernet) {
              return Scaffold(
                resizeToAvoidBottomInset: true,
                primary: false,
                body: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: state.pageController,
                  children: const [
                    Navigator(
                      onGenerateRoute: DashboardRoute.onGenerateRoute,
                    ),
                    Navigator(
                      onGenerateRoute: CoursesRoute.onGenerateRoute,
                    ),
                    Navigator(
                      onGenerateRoute: PremiumRoute.onGenerateRoute,
                    ),
                    Navigator(
                      onGenerateRoute: SavedRoute.onGenerateRoute,
                    ),
                  ],
                ),
                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return AnimatedNotchBottomBar(
                          notchBottomBarController: state.bottomBarController,
                          color: Colors.white,
                          showLabel: true,
                          textOverflow: TextOverflow.visible,
                          maxLine: 1,
                          shadowElevation: 5,
                          kBottomRadius: 10.0,
                          notchColor: context.colors.mainRadishColor,
                          removeMargins: false,
                          bottomBarWidth: 500,
                          showShadow: true,
                          durationInMilliSeconds: 300,
                          itemLabelStyle: const TextStyle(fontSize: 10),
                          elevation: 1,
                          bottomBarItems: [
                            ...List.generate(
                              images.length,
                              (index) => BottomBarItem(
                                inActiveItem: SvgPicture.asset(images[index]),
                                itemLabelWidget: SizedBox(
                                  width: 100,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    names[index],
                                    style: context.style.fontSize10Weight400,
                                  ),
                                ),
                                activeItem: Column(
                                  children: [
                                    SvgPicture.asset(
                                      images[state.bottomBarIndex],
                                      height: 24,
                                      color: context.colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                          onTap: (index) {
                            context.read<HomeBloc>().add(
                                  EditBottomBarIndexEvent(
                                    ind: index,
                                  ),
                                );
                            context.read<HomeBloc>().add(
                                  EditPageEvent(
                                    index: index,
                                    failure: () {},
                                    success: () {},
                                  ),
                                );
                          },
                          kIconSize: 24.0,
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: context.colors.c4Color.withOpacity(0.4),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 105),
                              child: Image.asset(
                                  context.image.internetConnectionImg1),
                            ),
                            Image.asset(
                              context.image.internetConnectionImg2,
                            ),
                          ],
                        ),
                        const Gap(10),
                        WButton(
                          onTap: () async {
                            await _connectivity.checkConnectivity();
                          },
                          text: "Refresh",
                          width: 100,
                          borderRadius: 10,
                          height: 40,
                          color: context.colors.transparentColor,
                          padding: EdgeInsets.symmetric(vertical: 5),
                        )
                      ]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
