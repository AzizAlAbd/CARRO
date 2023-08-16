import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/Core/Services/my_cars_repo.dart';
import 'package:dio/dio.dart';

part 'my_cars_state.dart';

class MyCarsCubit extends Cubit<MyCarsState> {
  final MyCarsRepo repo;

  MyCarsCubit({required this.repo}) : super(MyCarsInitial());

  Future<void> getMyCars() async {
    emit(MyCarsLoading());
    try {
      final response = await repo.getMyCars();
      if (response!.data.isEmpty) {
        emit(MyCarsEmpty());
      } else {
        emit(MyCarsLoaded(response.data));
      }
    } on DioError catch (e) {
      emit(MyCarsFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(MyCarsFailed(ErrorInterceptors.unhandledException));
    }
  }

  Future<void> deleteCar({required String id}) async {
    emit(carDeleteLoading());
    try {
      await repo.deleteCar(id: id);
      emit(carDeleteSucceeded());
    } on DioError catch (e) {
      emit(carDeleteFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(carDeleteFailed(ErrorInterceptors.unhandledException));
    }
  }
}
