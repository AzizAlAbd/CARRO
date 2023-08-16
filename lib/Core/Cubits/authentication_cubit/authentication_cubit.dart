import 'package:cars_app/Core/Services/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
// import 'package:shared_preferences/shared_preferences.dart';

import '../../Storage/secure_storage.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SecureStorage? storage;
  final AuthRepo? repo;
  AuthenticationCubit({required this.storage, required this.repo})
      : super(AuthenticationUninitialized());

  Future<void> appStarted() async {
    emit(AuthenticationLoading());

    await _cleanIfFirstUseAfterUninstall();
    _initStartup();
  }

  Future<void> _initStartup() async {
    try {
      final hasToken = await storage!.hasAccessToken();
      await Future.delayed(Duration(seconds: 1));
      if (!hasToken) {
        emit(AuthenticationUnauthenticated());
        return;
      } else {
        // bool isoldInstalledVersion = await checkAppVersion();
        // if (isoldInstalledVersion) {
        //   emit(AuthenticationUnauthenticated());
        //   return;
        // }

        emit(AuthenticationAuthenticated());
      }
    } catch (error) {
      developer.log(error.toString());
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthenticationLoading());
    try {
      // int? response = await repo!.logout();
      // if (response == 200) {
      await storage!.deleteAll();
      emit(AuthenticationUnauthenticated());
      // } else {
      //   _initStartup();
      // }
    } on DioError catch (error) {
      developer.log(error.toString());
      _initStartup();
    } catch (error) {
      developer.log(error.toString());
      _initStartup();
    }
  }

  Future<void> clear() async {
    emit(AuthenticationLoading());
    try {
      await storage!.deleteAll();
      emit(AuthenticationUnauthenticated());
    } on DioError catch (error) {
      developer.log(error.toString());
      _initStartup();
    } catch (error) {
      developer.log(error.toString());
      _initStartup();
    }
  }

  Future<void> _cleanIfFirstUseAfterUninstall() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await storage!.deleteAll();
      await prefs.setBool('first_run', false);
    }
  }

  // Future<bool> checkAppVersion() async {
  //   String? x = await storage!.getAppVersion();
  //   var storedAppVersion = x!.split(".");
  //   int localMajor = int.parse(storedAppVersion[0]);
  //   int localMinor = int.parse(storedAppVersion[1]);
  //   int localMaintenance = int.parse(storedAppVersion[2]);

  //   ///
  //   var deviceInfo = await AppConfig.getDeviceInfo();
  //   var currentAppVersion = deviceInfo![0].split(".");
  //   int currentMajor = int.parse(currentAppVersion[0]);
  //   int currentMinor = int.parse(currentAppVersion[1]);
  //   int currentMaintenance = int.parse(currentAppVersion[2]);

  //   if (localMajor <= currentMajor && localMinor <= currentMinor) {
  //     if (localMaintenance < currentMaintenance) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }
}
