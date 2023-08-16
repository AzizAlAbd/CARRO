import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/appointments_model.dart';
import 'package:cars_app/Core/Services/schedula_repo.dart';
import 'package:dio/dio.dart';

part 'schedual_state.dart';

class SchedualCubit extends Cubit<SchedualState> {
  final SchedualRepo repo;
  SchedualCubit({required this.repo}) : super(SchedualInitial());

  Future<void> getAppointments() async {
    emit(SchedualLoading());
    try {
      final response = await repo.getAppointments();
      if (response!.data.received.isEmpty && response.data.sent.isEmpty) {
        emit(SchedualEmpty());
      } else {
        emit(SchedualLoaded(
            recivedAppointment: response.data.received,
            sentAppointment: response.data.sent));
      }
    } on DioError catch (e) {
      emit(SchedualFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(SchedualFailed(ErrorInterceptors.unhandledException));
    }
  }

  Future<void> deteleAppointment({required String id}) async {
    emit(DeleteAppointmentLoading());
    try {
      await repo.deleteAppointment(id: id);
      emit(DeleteAppointmentSucceeded());
    } on DioError catch (e) {
      emit(DeleteAppointmentFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(DeleteAppointmentFailed(ErrorInterceptors.unhandledException));
    }
  }
}
