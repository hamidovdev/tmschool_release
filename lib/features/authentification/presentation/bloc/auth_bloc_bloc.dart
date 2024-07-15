import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm_school/core/injector/get_it.dart';
import 'package:tm_school/features/authentification/data/model/model.dart';
import 'package:tm_school/features/authentification/data/repository/repository.dart';
import 'package:tm_school/features/authentification/domain/usecase/city_usecase.dart';
import 'package:tm_school/features/authentification/domain/usecase/login_usecase.dart';
import 'package:tm_school/features/authentification/domain/usecase/logout_usecase.dart';
import 'package:tm_school/features/authentification/domain/usecase/region_names.dart';
import 'package:tm_school/features/authentification/domain/usecase/usecase.dart';
import 'package:flutter/foundation.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc()
      : super(AuthBlocState(
          registerStatus: RegisterStatus.success,
          status: Status.unknown,
          regionName: "Viloyatingizni tanlang",
          regions: const [],
          cityName: 'Shaxringizni tanlang',
          city: const [],
          userinfo: UserInfo(
            success: false,
            message: "",
            data: UserInfoData(
              name: "",
              surname: "",
              password: "",
              mobileVerifyCode: 0,
              mobileNumber: '',
            ),
          ),
          genderExpansiontileIndex: 0,
        )) {
    on<RegisterEvent>(_registerEvent);
    on<LogOutEvent>(_logOutEvent);
    on<GetUserStatusEvent>(_getUserStatusEvent);
    on<LoginEvent>(_loginEvent);
    on<VeriFicationSmsEvent>(_veriFicationSmsEvent);
    on<RegionNameIndexEvent>(_regionNameIndexEvent);
    on<GetRegionNameEvent>(_getRegionNameEvent);
    on<GetCiytNameEvent>(_getCiytNameEvent);
    on<CityNameIndexEvent>(_cityNameIndexEvent);
    on<GenderIndexEvent>(_genderIndexEvent);
    on<DeleteAccauntEvent>(_deleteAccauntEvent);
  }
  Future<void> _deleteAccauntEvent(
      DeleteAccauntEvent event, Emitter<AuthBlocState> emit) async {
    final usecase = LogOutUseCase(repository: ins<AuthRepositoryImpl>());
    final either = await usecase.call(DeleteAccauntParam());

    either.either(
      (failure) {
        event.failure();
      },
      (value) {
        event.onsuccess();
      },
    );
  }

  Future<void> _genderIndexEvent(
      GenderIndexEvent event, Emitter<AuthBlocState> emit) async {
    emit(state.copyWith(genderExpansiontileIndex: event.index));
  }

  Future<void> _cityNameIndexEvent(
      CityNameIndexEvent event, Emitter<AuthBlocState> emit) async {
    emit(
      state.copyWith(
        cityName: state.city[event.index].name,
      ),
    );
  }

  Future<void> _getCiytNameEvent(
      GetCiytNameEvent event, Emitter<AuthBlocState> emit) async {
    final usecase = CityNameUsecase(repository: ins<AuthRepositoryImpl>());
    final either = await usecase.call(CityNameAuthParam(id: event.id));
    either.either(
      (failure) {},
      (value) {
        emit(
          state.copyWith(
            city: value,
          ),
        );
      },
    );
  }

  Future<void> _getRegionNameEvent(
      GetRegionNameEvent event, Emitter<AuthBlocState> emit) async {
    final usecase = RegionNameUsecase(repository: ins<AuthRepositoryImpl>());
    final either = await usecase.call(RegionNameParam(id: event.id));
    either.either(
      (failure) {},
      (value) {
        emit(state.copyWith(regions: value));
      },
    );
  }

  Future<void> _regionNameIndexEvent(
      RegionNameIndexEvent event, Emitter<AuthBlocState> emit) async {
    emit(
      state.copyWith(
        regionName: state.regions[event.index].name,
      ),
    );
  }

  Future<void> _veriFicationSmsEvent(
      VeriFicationSmsEvent event, Emitter<AuthBlocState> emit) async {
    final usecase = SignInUseCase(repository: ins<AuthRepositoryImpl>());

    final either = await usecase.call(
      VerificationSmsParam(
        userInfo: state.userinfo,
      ),
    );
    either.either(
      (failure) {},
      (value) async {
        final shared = ins<SharedPreferences>();
        await shared.setString("token", value.authToken!);
        await shared.setInt("id", value.data.id!);

        event.onSuccess();
      },
    );
  }

  Future<void> _loginEvent(
      LoginEvent event, Emitter<AuthBlocState> emit) async {
    final usecase = LoginUseCase(repository: ins<AuthRepositoryImpl>());
    final either = await usecase.call(
        LoginParam(phoneNumber: event.phoneNumber, password: event.password));
    either.either(
      (failure) {
        event.failure();
      },
      (value) async {
        final shared = ins<SharedPreferences>();
        await shared.setString("token", value.token);
        await shared.setInt("id", value.id);

        event.onSuccess();
      },
    );
  }

  Future<void> _getUserStatusEvent(
      GetUserStatusEvent event, Emitter<AuthBlocState> emit) async {
    final shared = ins<SharedPreferences>();

    if (shared.getString("token") != null) {
      emit(
        state.copyWith(status: Status.authen),
      );
    } else {
      emit(
        state.copyWith(status: Status.unAuth),
      );
    }
  }

  Future<void> _logOutEvent(
      LogOutEvent event, Emitter<AuthBlocState> emit) async {
    final usecase = LogOutUseCase(repository: ins<AuthRepositoryImpl>());
    final either = await usecase.call(LogOutParam());
    either.either(
      (failure) {
        event.failure();
      },
      (value) {
        event.onsuccess();
      },
    );
  }

  Future<void> _registerEvent(
      RegisterEvent event, Emitter<AuthBlocState> emit) async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));
    final repository = SignInUseCase(
      repository: ins<AuthRepositoryImpl>(),
    );
    final result = await repository.call(
      RegisterParam(
        model: RegisterModel(
          birthDate: event.birthDate,
          cityId: event.cityId,
          gender: event.gender,
          imageName: event.imageName,
          imagePath: event.imagePath,
          name: event.name,
          surName: event.surName,
          number: event.number,
          password: event.password,
          passwordConfirmation: event.passwordConfirmation,
        ),
      ),
    );
    result.either(
      (failure) {
        emit(state.copyWith(registerStatus: RegisterStatus.success));

        event.failure();
      },
      (value) {
        emit(
          state.copyWith(
            userinfo: value,
          ),
        );
        emit(state.copyWith(registerStatus: RegisterStatus.success));

        event.onSuccess();
      },
    );
  }
}
