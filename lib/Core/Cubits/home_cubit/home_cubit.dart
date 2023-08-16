import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/Core/Services/home_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;
  final SecureStorage storage;
  HomeCubit({required this.repo, required this.storage}) : super(HomeInitial());

  void getHome() async {
    emit(HomeLoading());
    try {
      final response = await repo.getHome();
      emit(HomeLoaded(response!.data));
    } on DioError catch (e) {
      emit(HomeFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(HomeFailed(ErrorInterceptors.unhandledException));
    }
  }
}
