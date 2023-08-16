import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/Core/Services/view_all_repo.dart';
import 'package:dio/dio.dart';

import '../../Apis/interceptors/error_interceptors.dart';

part 'view_all_state.dart';

class ViewAllCubit extends Cubit<ViewAllState> {
  final ViewAllRepo repo;
  ViewAllCubit({required this.repo}) : super(ViewAllInitial());

  Future<void> getCars({required bool isTopRated}) async {
    emit(ViewAllLoading());
    try {
      final response = await repo.getCars(isTopRated: isTopRated);
      emit(ViewAllLoaded(response!.data));
    } on DioError catch (e) {
      emit(ViewAllFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(ViewAllFailed(ErrorInterceptors.unhandledException));
    }
  }
}
