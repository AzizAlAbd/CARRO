import 'package:dio/dio.dart';

import '../../Storage/secure_storage.dart';
import '../custom_errors.dart' as custom_errors;

class ResponseInterceptors extends Interceptor {
  Dio dio;

  SecureStorage secureStorage = SecureStorage();
  ResponseInterceptors(this.dio);
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // print(response.statusMessage);
    // print(response.data);
    if (response.data['response'] != 1) {
      handler.reject(
        custom_errors.CustomException(response.requestOptions, response),
        true,
      );
    } else {
      return handler.next(response);
    }

    // }
    // bool x = options.extra['token'];
    // print(x);
    // var token = await secureStorage.getToken();
// options.
    // options.headers["Accept"] = "application/json";
    // options.headers["content-type"] = "application/json";
    // if (accessToken != null) {
    //   var expiration = await TokenRepository().getAccessTokenRemainingTime();
    //   options.headers['Authorization'] = 'Bearer $accessToken';
    // }
  }
}
