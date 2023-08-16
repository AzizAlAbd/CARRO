import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/Core/Services/brand_cars_repo.dart';
import 'package:dio/dio.dart';

part 'brand_cars_state.dart';

class BrandCarsCubit extends Cubit<BrandCarsState> {
  final BrandCarsRepo repo;
  BrandCarsCubit({required this.repo}) : super(BrandCarsInitial());

  Future<void> getCars({required String id}) async {
    emit(BrandCarsLoading());
    try {
      final response = await repo.getCars(id: id);
      emit(BrandCarsLoaded(response!.data));
    } on DioError catch (e) {
      emit(BrandCarsFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(BrandCarsFailed(ErrorInterceptors.unhandledException));
    }
  }
}
