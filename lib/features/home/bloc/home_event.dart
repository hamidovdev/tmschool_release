// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent {}

class EditConnectivity extends HomeEvent {
  final List<ConnectivityResult> result;

  EditConnectivity({required this.result});
}

class EditBottomBarIndexEvent extends HomeEvent {
  final int ind;

  EditBottomBarIndexEvent({required this.ind});
}

class EditPageEvent extends HomeEvent {
  final int index;
  final VoidCallback success;
  final VoidCallback failure;

  EditPageEvent({
    required this.index,
    required this.success,
    required this.failure,
  });
}
