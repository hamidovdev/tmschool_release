import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          HomeState(
            connectionStatus: [ConnectivityResult.none],
            bottomBarIndex: 0,
            bottomBarController: NotchBottomBarController(index: 0),
            pageController: PageController(initialPage: 0, keepPage: true),
          ),
        ) {
    on<EditConnectivity>((event, emit) {
      emit(
        state.copyWith(
          connectionStatus: event.result,
        ),
      );
    });
    on<EditBottomBarIndexEvent>((event, emit) async {
      await state.bottomBarController.jumpTo(event.ind);
      emit(
        state.copyWith(
          bottomBarIndex: event.ind,
        ),
      );
    });
    on<EditPageEvent>((event, emit) {
      if (state.pageController.page!.round() != 0) {
        print("Ishladiyuuuuuu****If ${state.pageController.page!.round()}");
        state.pageController.jumpToPage(event.index);
        event.success();
      } else {
        print("Ishladiyuuuuuu****Else ${state.pageController.page!.round()}");

        state.pageController.jumpToPage(event.index);
        event.failure();
      }
      // emit(state);
    });
  }
}
