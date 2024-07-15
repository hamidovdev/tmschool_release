// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'home_bloc.dart';

class HomeState {
  final List<ConnectivityResult> connectionStatus;
  final int bottomBarIndex;
  final NotchBottomBarController bottomBarController;
  final PageController pageController;

  HomeState({
    required this.connectionStatus,
    required this.bottomBarIndex,
    required this.bottomBarController,
    required this.pageController,
  });

  HomeState copyWith({
    List<ConnectivityResult>? connectionStatus,
    int? bottomBarIndex,
    NotchBottomBarController? bottomBarController,
    PageController? pageController,
  }) {
    return HomeState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
      bottomBarIndex: bottomBarIndex ?? this.bottomBarIndex,
      bottomBarController: bottomBarController ?? this.bottomBarController,
      pageController: pageController ?? this.pageController,
    );
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return listEquals(other.connectionStatus, connectionStatus) &&
        other.bottomBarIndex == bottomBarIndex &&
        other.bottomBarController == bottomBarController &&
        other.pageController == pageController;
  }

  @override
  int get hashCode {
    return connectionStatus.hashCode ^
        bottomBarIndex.hashCode ^
        bottomBarController.hashCode ^
        pageController.hashCode;
  }
}
