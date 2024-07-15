import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tm_school/features/profile/data/data_source/data_source.dart';
import 'package:tm_school/features/profile/data/model/model.dart';
import 'package:tm_school/features/profile/data/model/region_ciyt_model.dart';
import 'package:tm_school/features/profile/data/model/update_model.dart';
import 'package:tm_school/features/profile/data/repository/repository.dart';
import 'package:tm_school/features/profile/domain/usecase/region_city_usecase.dart';
import 'package:tm_school/features/profile/domain/usecase/update_usecase.dart';
import 'package:tm_school/features/profile/domain/usecase/usecase.dart';
import 'package:flutter/foundation.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc()
      : super(
          ProfilState(
            gender: "Erkak",
            cityName: "Shaxringizni tanlang",
            regionName: "Viloyatingizni tanlang",
            regionNames: [],
            cityNames: [],
            status: ProfilStatus.success,
            userProfile: UserProfile(
              success: false,
              message: "",
              id: 0,
              name: "",
              surname: "",
              mobileNumber: "",
            ),
          ),
        ) {
    on<GetProfilDataEvent>(_getProfilDataEvent);
    on<SelectCityName>(_selectCityName);
    on<SelectRegionName>(_selectRegionName);
    on<SelectGenderEvent>(_selectGenderEvent);
    on<CityNameProfilEvent>(_cityNameProfilEvent);
    on<RegionNameEvent>(_regionNameEvent);
    on<UpdateEvent>(_updateEvent);
  }
  Future<void> _updateEvent(

      UpdateEvent event, Emitter<ProfilState> emit) async {
        emit(state.copyWith(status: ProfilStatus.loading,));
    final usecase = UpdateUseCase(
        repository: ProfilRepositoryImpl(dataSource: ProfilDataSource()));
    final either =
        await usecase.call(UpdateParam(updateModel: event.updateModel));
    either.either(
      (failure) {
        emit(state.copyWith(status: ProfilStatus.success,));

        event.failure();
      },
      (value) {
        emit(state.copyWith(status: ProfilStatus.success,));

        event.onSuccess();
      },
    );
  }

  Future<void> _regionNameEvent(
      RegionNameEvent event, Emitter<ProfilState> emit) async {
    final usecase = RegionCityNameUseCase(
        repository: ProfilRepositoryImpl(dataSource: ProfilDataSource()));
    final either = await usecase.call(RegionNameParam());
    either.either(
      (failure) {},
      (value) {
        emit(state.copyWith(regionNames: value));
      },
    );
  }

  Future<void> _cityNameProfilEvent(
      CityNameProfilEvent event, Emitter<ProfilState> emit) async {
    final usecase = RegionCityNameUseCase(
        repository: ProfilRepositoryImpl(dataSource: ProfilDataSource()));
    final either = await usecase.call(CityNameProfilParam(id: event.id));
    either.either(
      (failure) {},
      (value) {
        emit(state.copyWith(cityNames: value));
      },
    );
  }

  Future<void> _selectGenderEvent(
      SelectGenderEvent event, Emitter<ProfilState> emit) async {
    emit(state.copyWith(gender: event.gender));
  }

  Future<void> _selectRegionName(
      SelectRegionName event, Emitter<ProfilState> emit) async {
    emit(state.copyWith(regionName: event.region));
  }

  Future<void> _selectCityName(
      SelectCityName event, Emitter<ProfilState> emit) async {
    emit(state.copyWith(cityName: event.city, cityId: event.id));
  }

  Future<void> _getProfilDataEvent(
      GetProfilDataEvent event, Emitter<ProfilState> emit) async {
    emit(state.copyWith(status: ProfilStatus.loading));
    final useCase = ProfilUseCase(
        repository: ProfilRepositoryImpl(dataSource: ProfilDataSource()));
    final either = await useCase.call(GetProfilParam());
    either.either(
      (failure) {
        print("Xato");
      },
      (value) {
        emit(state.copyWith(userProfile: value));
        emit(state.copyWith(status: ProfilStatus.success));
      },
    );
  }
}
