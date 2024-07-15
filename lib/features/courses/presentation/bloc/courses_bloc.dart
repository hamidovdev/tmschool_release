import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/core/status/status.dart';
import 'package:flutter/foundation.dart';
import 'package:tm_school/core/usecase/usecase.dart';
import 'package:tm_school/features/courses/data/model/models.dart';
import 'package:tm_school/features/courses/data/repository/repository.dart';
import 'package:tm_school/features/courses/domain/usecase/clickUseCase.dart';
import 'package:tm_school/features/courses/domain/usecase/getCommentsUseCase.dart';
import 'package:tm_school/features/courses/domain/usecase/getLessonsUseCase.dart';
import 'package:tm_school/features/courses/domain/usecase/getVideosUseCase.dart';
import 'package:tm_school/features/courses/domain/usecase/sendCommentUseCase.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc()
      : super(
          CoursesState(
            mainStatus: MainStatus.pure,
            commentsStatus: MainStatus.pure,
            lessonsStatus: MainStatus.pure,
            videosStatus: MainStatus.pure,
            activePageIndex: 2,
            activeCoursesList: [],
            comments: [],
            lessons: [],
            videos: [],
            activeVideoIndex: "",
            thisPage: 0,
          ),
        ) {
    on<EditActivePageIndex>((event, emit) {
      emit(
        state.copyWith(
          activePageIndex: event.ind,
        ),
      );
    });
    on<ClearCourseBlocEvent>((event, emit) {
      if (state.controller != null && state.controller!.value.isFullScreen) {
        state.controller!.toggleFullScreenMode();
      }
      emit(
        state.copyWith(
          mainStatus: MainStatus.pure,
          lessonsStatus: MainStatus.pure,
          activePageIndex: 2,
          commentsStatus: MainStatus.pure,
          comments: [],
          lessons: [],
        ),
      );
    });

    on<EditFullScreenEvent>((event, emit) {
      if (state.controller != null && state.controller!.value.isFullScreen) {
        state.controller!.toggleFullScreenMode();
        event.success();
      } else {
        event.failure();
      }
    });
    on<EditActiveCourseIndex>(_editActiveCourseIndex);

    on<GetLessonsEvent>(_getLessonsEvent);

    on<GetVideosEvent>(_getVideosEvent);

    on<GetCommentsEvent>(_getCommentsEvent);

    on<ClickBtnsEvent>(_clickBtnsEvent);

    on<SendCommentEvent>(_sendCommentEvent);

    on<EditActiveVideoEvent>(_editActiveVideoEvent);
  }

  Future<void> _editActiveCourseIndex(
      EditActiveCourseIndex event, Emitter<CoursesState> emit) async {
    List<int> ls = state.activeCoursesList;
    if (ls.contains(event.activeCourseInd)) {
      ls.remove(event.activeCourseInd);
    } else {
      ls.add(event.activeCourseInd);
    }
    emit(
      state.copyWith(activeCoursesList: ls),
    );
  }

  Future<void> _getLessonsEvent(
      GetLessonsEvent event, Emitter<CoursesState> emit) async {
    emit(
      state.copyWith(
        mainStatus: MainStatus.loading,
      ),
    );
    final usecase = GetLessonsUseCase(
      courseId: event.courseId,
      repository: ins<CoursesRepositoryImpl>(),
    );
    final either = await usecase.call(NoParams());
    either.either((failure) {
      emit(
        state.copyWith(
          mainStatus: MainStatus.failure,
        ),
      );
    }, (value) {
      print(value);
      if (event.lessonId != null) {
        print("Lesson ID ${event.lessonId} || Video ID ${event.videoId}");
        List<VideoModel> videos = [];
        VideoModel? video;
        for (var i = 0; i < value.length; i++) {
          if (value[i].id.toString() == event.lessonId) {
            videos = value[i].videos;
            break;
          }
        }

        for (var e in videos) {
          if (e.id.toString() == event.videoId) {
            video = e;
          }
        }
        emit(
          state.copyWith(
              lessons: value,
              activeVideo: video!,
              mainStatus: MainStatus.success,
              activeVideoIndex: "${value[0].name}-0",
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(video.link) ?? "",
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              videosStatus: MainStatus.success),
        );
      } else {
        emit(
          state.copyWith(
              lessons: value,
              activeVideo: value[0].videos[0],
              mainStatus: MainStatus.success,
              activeVideoIndex: "${value[0].name}-0",
              controller: YoutubePlayerController(
                initialVideoId:
                    YoutubePlayer.convertUrlToId(value[0].videos[0].link) ?? "",
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              videosStatus: MainStatus.success),
        );
      }
      event.success();
    });
  }

  Future<void> _getVideosEvent(
      GetVideosEvent event, Emitter<CoursesState> emit) async {
    final usecase = GetVideosUseCase(
      lessonId: event.lessonId,
      repository: ins<CoursesRepositoryImpl>(),
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
          videosStatus: MainStatus.success,
          videos: value,
        ),
      );
    });
  }

  Future<void> _getCommentsEvent(
      GetCommentsEvent event, Emitter<CoursesState> emit) async {
    emit(
      state.copyWith(
        commentsStatus: MainStatus.loading,
      ),
    );
    final usecase = GetCommentsUseCase(
      videoId: event.videoId,
      repository: ins<CoursesRepositoryImpl>(),
    );
    final either = await usecase.call(
      NoParams(),
    );
    either.either((failure) {
      emit(
        state.copyWith(
          commentsStatus: MainStatus.success,
        ),
      );
    }, (value) {
      emit(
        state.copyWith(
          commentsStatus: MainStatus.success,
          comments: (value.reversed).toList(),
        ),
      );
    });
  }

  Future<void> _clickBtnsEvent(
      ClickBtnsEvent event, Emitter<CoursesState> emit) async {
    final usecase = ClickBtnsUseCase(
      repository: ins<CoursesRepositoryImpl>(),
      paramm: event.param,
      videoId: event.videoId,
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
      VideoModel aV = state.activeVideo!;

      if (event.param == "like") {
        aV = aV.copyWith(liked: false);
      } else if (event.param == "disLike") {
        aV = aV.copyWith(liked: true);
      } else if (event.param == "save") {
        aV = aV.copyWith(saved: false);
      } else if (event.param == "noSave") {
        aV = aV.copyWith(saved: true);
      }

      emit(
        state.copyWith(
          activeVideo: aV,
          mainStatus: MainStatus.success,
        ),
      );
    });
  }

  Future<void> _sendCommentEvent(
      SendCommentEvent event, Emitter<CoursesState> emit) async {
    emit(state.copyWith(commentsStatus: MainStatus.loading));
    final usecase = SendCommentUseCase(
      videoId: event.videoId,
      message: event.message,
      repository: ins<CoursesRepositoryImpl>(),
    );

    final either = await usecase.call(NoParams());
    either.either((failure) {
      emit(
        state.copyWith(
          commentsStatus: MainStatus.success,
        ),
      );
    }, (value) {
      List<CommentModel> ls = (state.comments.reversed).toList();

      ls.add(value);
      emit(
        state.copyWith(
          comments: (ls.reversed).toList(),
          commentsStatus: MainStatus.success,
        ),
      );
    });
  }

  Future<void> _editActiveVideoEvent(
      EditActiveVideoEvent event, Emitter<CoursesState> emit) async {
    // state.controller!
    //     .load(YoutubePlayer.convertUrlToId(event.video.link) ?? "");
    emit(
      state.copyWith(
        videosStatus: MainStatus.success,
        activeVideo: event.video,
        activeVideoIndex: "${event.lessonId}-${event.videoIndex}",
        commentsStatus: MainStatus.pure,
        controller: YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(event.video.link) ?? "",
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        ),
      ),
    );
    event.success();
  }
}
