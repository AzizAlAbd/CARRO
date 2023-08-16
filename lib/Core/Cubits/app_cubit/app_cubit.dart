import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Models/brands_model.dart';
import 'package:cars_app/Core/Services/app_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppRepo repo;
  final SecureStorage storage;

  AppCubit({required this.storage, required this.repo}) : super(AppState());

  void initializeApp() async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      await getBrands();
      if (state.status == AppStatus.loading) {
        String? avatar = await storage.getProfileImage();
        String? name = await storage.getCustomerName();
        emit(state.copyWith(
            status: AppStatus.succeeded, avatar: avatar, name: name));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(error: e.toString(), status: AppStatus.failed));
    }
  }

  void reReadAvatar() async {
    String? avatar = await storage.getProfileImage();
    emit(state.copyWith(avatar: avatar));
  }

  Future<void> reReadName() async {
    String? name = await storage.getCustomerName();
    emit(state.copyWith(name: name));
  }

  Future<void> getBrands() async {
    try {
      final response = await repo.getBrands();

      List<String> brands = [];
      response!.data.forEach((element) {
        brands.add(element.name);
      });
      emit(state.copyWith(brands: brands, brandsData: response.data));
    } on DioError catch (e) {
      emit(state.copyWith(error: e.toString(), status: AppStatus.failed));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(error: e.toString(), status: AppStatus.failed));
    }
  }
}
