import 'package:bloc/bloc.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/saved/data/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:tm_school/features/saved/data/repository/repository.dart';
import 'package:tm_school/features/saved/domain/usecase/usecase.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc()
      : super(
          SavedState(
            mainStatus: MainStatus.pure,
            saveds: [],
            allSavedsLength: 0,
          ),
        ) {
    on<GetSavedsEvent>(_getSavedEvent);
  }
  Future<void> _getSavedEvent(
      GetSavedsEvent event, Emitter<SavedState> emit) async {
    emit(
      state.copyWith(
        mainStatus: MainStatus.loading,
      ),
    );
    final usecase = SavedUseCase(
      repository: ins<SavedRepositoryImpl>(),
    );
    final either = await usecase.call(NoParams());
    either.either((failure) {
      emit(
        state.copyWith(
          mainStatus: MainStatus.failure,
        ),
      );
    }, (value) {
      int ln = 0;
      for (var element in value) {
        ln += element.data.length;
      }
      emit(
        state.copyWith(
          mainStatus: MainStatus.success,
          saveds: value,
          allSavedsLength: ln,
        ),
      );
    });
  }
}
