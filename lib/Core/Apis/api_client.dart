import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';

// import '../custom_errors.dart' as custom_errors;

import 'api.dart';
import 'interceptors/colorize_logger_interceptor.dart';
import 'interceptors/error_interceptors.dart';
import 'interceptors/response_interceptor.dart';

class ApiClient {
  final dio = createDio();
  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        receiveTimeout: 20000, // 15 seconds
        connectTimeout: 20000,
        sendTimeout: 20000,
      ),
    );
    dio.interceptors.addAll({
      ColorizeLoggerDioInterceptor(
        logRequestTimeout: false,
        logRequestHeaders: true,
        logResponseHeaders: false,
        // Optional, defaults to the 'log' function in the 'dart:developer' package.
      ),
      QueuedInterceptorsWrapper(onRequest: (options, handler) async {
        bool x = options.extra['token'] ?? true;
        // String? customToken = options.extra['customToken'];
        if (x) {
          var token = await SecureStorage().getAccessToken();
          if (token != null) {
            // //   //   if (options.headers['Retry-Count'] != 1) {
            // //   //     var expiration = await SecureStorage().getExpiration();
            // //   //     var dateValue = DateTime.parse(expiration!);
            // //   //     var utcDate = dateValue.toLocal();
            // //   //     var difference = utcDate.difference(DateTime.now());
            // //   //     if (difference.inSeconds.isNegative ||
            // //   //         difference.inSeconds <= 60) {
            // //   //       await ErrorInterceptors.getAndSetAccessTokenVariable(
            // //   //           dio, options, handler);
            // //   //       token = await SecureStorage().getAccessToken();
            // //   //     }
            // //   //   }
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        // if (customToken != null) {
        //   options.headers['Authorization'] = 'Bearer $customToken';
        // }
        return handler.next(options);
      }),
      // RequestInterceptors(),
      ResponseInterceptors(dio),
      ErrorInterceptors(),
    });
    return dio;
  }
}
