// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'saved_bloc.dart';

class SavedState {
  final MainStatus mainStatus;
  final List<SavedModel> saveds;
  final int allSavedsLength;

  SavedState({
    required this.mainStatus,
    required this.saveds,
    required this.allSavedsLength,
  });

  SavedState copyWith({
    MainStatus? mainStatus,
    List<SavedModel>? saveds,
    int? allSavedsLength,
  }) {
    return SavedState(
      mainStatus: mainStatus ?? this.mainStatus,
      saveds: saveds ?? this.saveds,
      allSavedsLength: allSavedsLength ?? this.allSavedsLength,
    );
  }

  @override
  bool operator ==(covariant SavedState other) {
    if (identical(this, other)) return true;

    return other.mainStatus == mainStatus &&
        listEquals(other.saveds, saveds) &&
        other.allSavedsLength == allSavedsLength;
  }

  @override
  int get hashCode =>
      mainStatus.hashCode ^ saveds.hashCode ^ allSavedsLength.hashCode;
}
