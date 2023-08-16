import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class EasyLoadingConfig {
  static const loadingText = "Loading...";
  static void config() {
    EasyLoading.instance
      ..radius = 20.0
      ..contentPadding = const EdgeInsets.all(30)
      ..maskColor = Colors.black.withOpacity(0.5)
      ..progressColor = Colors.white
      ..indicatorColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.custom
      ..userInteractions = false
      ..indicatorWidget = const LoadingWidget()
      ..maskType = EasyLoadingMaskType.custom
      ..dismissOnTap = false
      ..backgroundColor = Colors.white
      ..textColor = secondColor;
  }
}

class Loader {
  static void show({String? status}) {
    // Intercept the back button
    BackButtonInterceptor.add(interceptor);

    // Show the loader
    EasyLoading.show(status: status);
  }

  static void dismiss() {
    // Dismiss the loader
    EasyLoading.dismiss();

    // Dismiss the back button interceptor
    BackButtonInterceptor.remove(interceptor);
  }

  // Back button interceptor function
  static bool interceptor(bool stopEvent, RouteInfo info) {
    // Do whatever you want when intercepting the back button
    return true;
  }
}
