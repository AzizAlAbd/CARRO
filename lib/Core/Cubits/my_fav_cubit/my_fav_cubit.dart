import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/Core/Services/fav_repo.dart';
import 'package:dio/dio.dart';

part 'my_fav_state.dart';

class MyFavCubit extends Cubit<MyFavState> {
  final FavRepo repo;
  MyFavCubit({required this.repo}) : super(MyFavInitial());

  Future<void> getFav() async {
    emit(MyFavLoading());
    try {
      final response = await repo.getFav();
      emit(MyFavLoaded(response!.data));
    } on DioError catch (e) {
      emit(MyFavFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(MyFavFailed(ErrorInterceptors.unhandledException));
    }
  }

  Future<void> toggleFav({required String id, required bool fav}) async {
    try {
      !fav ? await repo.addToFav(id: id) : await repo.deleteFromFav(id: id);
    } on DioError catch (e) {
      emit(favToggleFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(favToggleFailed(ErrorInterceptors.unhandledException));
    }
  }
}
