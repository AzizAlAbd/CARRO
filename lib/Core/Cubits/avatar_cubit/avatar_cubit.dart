import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Services/profile_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';

part 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  final ProfileRepo repo;
  final SecureStorage storage;
  AvatarCubit({required this.repo, required this.storage})
      : super(AvatarInitial());

  void uploadAvatar(String avatar) async {
    emit(AvatarLoading());
    try {
      final response = await repo.uploadAvatar(avatar: avatar);

      storage.saveProfileImage(response!);
      emit(AvatarSucceeded());
    } on DioError catch (e) {
      emit(AvatarFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(AvatarFailed(ErrorInterceptors.unhandledException));
    }
  }
}
