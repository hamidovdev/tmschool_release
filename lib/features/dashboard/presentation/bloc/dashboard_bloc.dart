import 'package:bloc/bloc.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/dashboard/data/datasource/datasource.dart';
import 'package:tm_school/features/dashboard/data/model/models.dart';
import 'package:tm_school/features/dashboard/data/repository/repository.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';
import 'package:flutter/foundation.dart';
import 'package:tm_school/features/dashboard/domain/usecase/getCoursesUseCase.dart';
import 'package:tm_school/features/dashboard/domain/usecase/getNewsUseCase.dart';
import 'package:tm_school/features/dashboard/domain/usecase/getUserInfoUseCase.dart';
import 'package:tm_school/features/dashboard/domain/usecase/resultBoolUseCase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc()
      : super(
          DashboardState(
            appbarStatus: MainStatus.pure,
            carouselPageNumber: 0,
            mainStatus: MainStatus.pure,
            courses: [],
            news: [],
            forNotifications: [],
            joinCourseStatus: MainStatus.success,
          ),
        ) {
    on<GetUserInfoEvent>(_getUserInfoEvent);

    on<GetNewsEvent>(_getNewsEvent);

    on<GetCoursesEvent>(_getCoursesEvent);

    on<JoinCourseEvent>(_joinCourse);

    on<EditCarouselPage>((event, emit) {
      emit(
        state.copyWith(
          carouselPageNumber: event.pageNum,
        ),
      );
    });

    on<ClearBlocEvent>((event, emit) {
      emit(state.copyWith(
        mainStatus: MainStatus.pure,
        appbarStatus: MainStatus.pure,
        courses: [],
        news: [],
      ));
    });

    on<PercentageEvent>((event, emit) async {
      final usecase = ResultBoolUseCase(
        repository: DashboardRepositoryImpl(
          dataSource: DashboardDataSource(),
        ),
      );
      final either = await usecase.call(
        PercentageParam(
          courseId: event.courseId,
          lessonId: event.lessonId,
          videoId: event.videoId,
        ),
      );
      either.either((failure) {}, (value) {
        List<CoursesEntity> ls = [];
        for (var i = 0; i < state.courses.length; i++) {
          if (state.courses[i].id.toString() == event.courseId) {
            ls.add(
              state.courses[i].copyWith(
                percentage: value,
              ),
            );
          } else {
            ls.add(
              state.courses[i],
            );
          }
        }

        emit(
          state.copyWith(
            courses: ls,
          ),
        );
        event.success();
      });
    });
  }

  Future<void> _joinCourse(
      JoinCourseEvent event, Emitter<DashboardState> emit) async {
    emit(
      state.copyWith(
        joinCourseStatus: MainStatus.loading,
      ),
    );
    final usecase = ResultBoolUseCase(
      repository: ins<DashboardRepositoryImpl>(),
    );
    final either = await usecase.call(
      JoinCourseParam(newsId: event.newsId),
    );
    either.either(
      (failure) {
        emit(
          state.copyWith(
            joinCourseStatus: MainStatus.success,
          ),
        );
        event.failure();
      },
      (value) {
        emit(
          state.copyWith(
            joinCourseStatus: MainStatus.success,
          ),
        );
        event.success();
      },
    );
  }

  Future<void> _getUserInfoEvent(
      GetUserInfoEvent event, Emitter<DashboardState> emit) async {
    emit(
      state.copyWith(
        appbarStatus: MainStatus.loading,
      ),
    );
    final usecase =
        GetUserInfoUseCase(repository: ins<DashboardRepositoryImpl>());
    final either = await usecase.call(
      NoParams(),
    );
    either.either((failure) {
      emit(
        state.copyWith(
          appbarStatus: MainStatus.failure,
        ),
      );
    }, (value) {
      emit(
        state.copyWith(
          appbarStatus: MainStatus.success,
          userInfo: value,
        ),
      );
    });
  }

  Future<void> _getCoursesEvent(
      GetCoursesEvent event, Emitter<DashboardState> emit) async {
    emit(
      state.copyWith(
        mainStatus: MainStatus.loading,
      ),
    );
    final usecase = GetCoursesUseCase(
      repository: ins<DashboardRepositoryImpl>(),
    );
    final either = await usecase.call(
      NoParams(),
    );
    either.either((failure) {
      emit(
        state.copyWith(
          mainStatus: MainStatus.failure,
        ),
      );
    }, (value) {
      emit(
        state.copyWith(
          mainStatus: MainStatus.success,
          courses: value,
        ),
      );
    });
  }

  Future<void> _getNewsEvent(
      GetNewsEvent event, Emitter<DashboardState> emit) async {
    emit(
      state.copyWith(
        mainStatus: MainStatus.loading,
      ),
    );
    final usecase = GetNewsUseCase(
      repository: ins<DashboardRepositoryImpl>(),
    );
    final either = await usecase.call(
      NoParams(),
    );
    either.either((failure) {
      emit(
        state.copyWith(
          mainStatus: MainStatus.failure,
        ),
      );
    }, (value) {
      List<DatumEntity> ls = [];

      if (event.haveGroupDate) {
        emit(
          state.copyWith(
            mainStatus: MainStatus.success,
            forNotifications: value,
          ),
        );
      } else {
        for (var i = 0; i < value.length; i++) {
          for (var j = 0; j < value[i].data.length; j++) {
            ls.add(value[i].data[j]);
          }
        }
        emit(
          state.copyWith(
            mainStatus: MainStatus.success,
            news: ls,
          ),
        );
      }
      event.success();
    });
  }
}
