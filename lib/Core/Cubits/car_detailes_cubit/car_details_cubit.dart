import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/Core/Services/car_details_repo.dart';
import 'package:dio/dio.dart';

part 'car_details_state.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  final CarDetailsRepo repo;
  CarDetailsCubit({required this.repo}) : super(CarDetailsInitial());

  Future<void> getDetalis({
    required String id,
  }) async {
    emit(CarDetailsLoading());
    try {
      final response = await repo.getDetails(
        id: id,
      );
      emit(CarDetailsSucceeded(response!.data));
    } on DioError catch (e) {
      emit(CarDetailsFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(CarDetailsFailed(ErrorInterceptors.unhandledException));
    }
  }

  Future<void> rateCar({required String id, required int rate}) async {
    emit(CarRatingloading());
    try {
      await repo.rateCar(id: id, rate: rate);
      emit(CarRatingSucceeded());
    } on DioError catch (e) {
      emit(CarRatingFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(CarRatingFailed(ErrorInterceptors.unhandledException));
    }
  }

  Future<void> takeAppointment(
      {required String id, required String date}) async {
    emit(CarAppointmentLoading());
    try {
      await repo.takeAppointment(id: id, date: date);
      emit(CarAppointmentSucceeded());
    } on DioError catch (e) {
      emit(CarAppointmentFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(CarAppointmentFailed(ErrorInterceptors.unhandledException));
    }
  }
}
