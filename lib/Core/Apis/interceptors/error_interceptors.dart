import 'dart:developer';

import 'package:cars_app/Core/Apis/custom_errors.dart';
import 'package:cars_app/Core/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:cars_app/Core/Services/auth_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';

import '../api_client.dart';
import '../custom_errors.dart' as custom_errors;

class ErrorInterceptors extends Interceptor {
  final storage = SecureStorage();

  ErrorInterceptors();
  static const String unhandledException =
      'Something went wrong, please try again';

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw custom_errors.DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            if (err.response != null) {
              switch (err.response!.data['response']) {
                case 12:
                  throw InvalidData(err.requestOptions, err.response);
                case 50:
                  throw LimitExceeded(err.requestOptions, err.response);
                case 51:
                  throw OverlapingLeave(err.requestOptions, err.response);
                case 52:
                  throw OverlapingOffDay(err.requestOptions, err.response);
                case 53:
                  throw InvalidHourlyLeave(err.requestOptions, err.response);

                default:
                  throw custom_errors.BadRequestException(err.requestOptions);
              }
            } else {
              throw custom_errors.BadRequestException(err.requestOptions);
            }

          case 401:
            AuthRepo repo = AuthRepo();
            AuthenticationCubit cubit =
                AuthenticationCubit(storage: storage, repo: repo);
            cubit.logout();
            throw custom_errors.UnauthorizedException(
                err.requestOptions, err.response);
          // if (err.response != null &&
          //     err.response!.data != "" &&
          //     err.response!.data != null) {
          //   switch (err.response!.data['response']) {
          //     case 13:
          //       // BlocProvider.of<AuthenticationCubit>(
          //       //         MyApp.navigatorKey.currentState!.context)
          //       //     .clear();
          //       // Navigator.of(MyApp.navigatorKey.currentState!.context)
          //       //     .pushNamedAndRemoveUntil(IntroScreen.routeName,
          //       //         (Route<dynamic> route) => false);
          //       throw custom_errors.UnauthorizedException(
          //           err.requestOptions, err.response);
          //     case 14:
          //       throw InvalidLogin(err.requestOptions, err.response);
          //     default:
          //       throw custom_errors.UnauthorizedException(
          //           err.requestOptions, err.response);
          //   }
          // } else {
          //   return;
          //   //  _handle401(err, handler);
          // }
          case 403:
            throw custom_errors.UnauthorizedException(
                err.requestOptions, err.response);
          case 404:
            throw custom_errors.NotFoundException(err.requestOptions);
          case 409:
            throw custom_errors.ConflictException(err.requestOptions);
          case 500:
            throw custom_errors.InternalServerErrorException(
                err.requestOptions, err.response);
          default:
            throw custom_errors.InternalServerErrorException(
                err.requestOptions, err.response);
        }
      // break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        if (err.response != null) {
          switch (err.response!.data['response']) {
            case 15:
              throw (custom_errors.InvalidLogin(
                  err.requestOptions, err.response));

            case 31:
              throw (custom_errors.InvalidEmployee(
                  err.requestOptions, err.response));
            case 33:
              throw (custom_errors.InvalidEmployee(
                  err.requestOptions, err.response));
            case 401:
              throw (custom_errors.UnauthorizedException(
                  err.requestOptions, err.response));
            case 26:
              throw custom_errors.IncorrectOldPassword(
                  err.requestOptions, err.response);
            case 230:
              throw custom_errors.InvalidPermission(
                  err.requestOptions, err.response);
            default:
              log(err.response.toString());
              throw custom_errors.NoInternetConnectionException(
                  err.requestOptions);
          }
        } else {
          throw custom_errors.NoInternetConnectionException(err.requestOptions);
        }
    }
    return handler.next(err);
  }

  // void _handle401(DioError err, ErrorInterceptorHandler handler) async {
  //   try {
  //     var refreshToken = await SecureStorage().getRefreshToken();
  //     if (refreshToken != null) {
  //       int? statusCode = await _refreshToken(err.requestOptions);
  //       if (statusCode == 200) {
  //         return handler.resolve(await _retry(err.requestOptions));
  //       }
  //     } else {
  //       throw custom_errors.UnauthorizedException(
  //           err.requestOptions, err.response);
  //     }
  //   } on DioError catch (error) {
  //     handler.next(error);
  //   } catch (error) {
  //     throw custom_errors.UnauthorizedException(
  //         err.requestOptions, err.response);
  //   }
  // }

  // static Future<int?> _refreshToken(RequestOptions requestOptions) async {
  //   if (requestOptions.headers['Retry-Count'] != 1) {
  //     var res = await AuthSrvc().refreshToken();
  //     await saveAuthData(res);
  //     requestOptions.headers['Retry-Count'] = 1;
  //     return res.statusCode;

  //     // if (res.statusCode == 200) {
  //     // }
  //   }
  //   return null;
  // }

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return await ApiClient().dio.request<dynamic>(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
  }

  // static Future<void> getAndSetAccessTokenVariable(Dio dio,
  //     RequestOptions options, RequestInterceptorHandler handler) async {
  //   try {
  //     final response = await AuthSrvc().refreshTokenBeforeTokenExpiredTime();
  //     log("refreshTokenResponse is  $response");
  //     await saveAuthData(response);
  //     options.headers['Retry-Count'] = 1;
  //   } on DioError catch (e) {
  //     log("refreshToken error");
  //     handler.reject(e, true);
  //   }
  // }

  // static Future<void> saveAuthData(Response<dynamic> response) async {
  //   await SecureStorage().saveAccessToken(response.data['data']['accessToken']);
  //   await SecureStorage()
  //       .saveRefreshToken(response.data['data']['refreshToken']);
  //   await SecureStorage().saveExpiration(response.data['data']['expiration']);
  // }
}
