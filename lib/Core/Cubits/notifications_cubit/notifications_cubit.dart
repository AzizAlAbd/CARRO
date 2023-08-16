import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Models/notifications_model.dart';
import 'package:cars_app/Core/Services/notifications_repo.dart';
import 'package:dio/dio.dart';

import '../../Apis/interceptors/error_interceptors.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo repo;
  NotificationsCubit({required this.repo}) : super(NotificationsInitial());

  Future<void> getNotifications() async {
    emit(NotificationsLoading());
    try {
      final response = await repo.getNotifications();
      if (response!.data.isEmpty) {
        emit(NotificationsEmpty());
      } else
        emit(NotificationsLoaded(response.data));
    } on DioError catch (e) {
      emit(NotificationsFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(NotificationsFailed(ErrorInterceptors.unhandledException));
    }
  }

  Future<void> replay({required String notID, required bool accept}) async {
    emit(ReplayLoading());
    try {
      await repo.replay(notID: notID, accept: accept);

      emit(ReplaySucceeded());
    } on DioError catch (e) {
      emit(ReplayFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(ReplayFailed(ErrorInterceptors.unhandledException));
    }
  }
}
