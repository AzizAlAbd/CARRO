import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/profile_model.dart';
import 'package:cars_app/Core/Services/profile_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  final SecureStorage storage;
  ProfileCubit({
    required this.repo,
    required this.storage,
  }) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final response = await repo.getProfile();
      emit(ProfileLoaded(response!.data));
    } on DioError catch (e) {
      emit(ProfileFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(ProfileFailed(ErrorInterceptors.unhandledException));
    }
  }

  Future<void> updateProfile(
      {required String name,
      required String phone,
      required String location}) async {
    emit(UpdateLoading());
    try {
      await repo.updateProfile(name: name, phone: phone, location: location);
      await storage.saveCustomerName(name);
      await storage.saveLocation(location);
      await storage.saveMobileNumber(phone);
      emit(UpdateSucceeded());
    } on DioError catch (e) {
      emit(UpdateFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(UpdateFailed(ErrorInterceptors.unhandledException));
    }
  }
}
