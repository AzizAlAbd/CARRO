import 'package:dio/dio.dart';

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Something went wrong, please retry later';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occured';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested resource could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() {
    return 'No internet connection detected, please check your network connection';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has Timeout, please try again';
  }
}

class CustomException extends DioError {
  CustomException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Custom Exception';
  }
}

class InvalidLogin extends DioError {
  InvalidLogin(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Invalid Login';
  }
}

class InvalidEmployee extends DioError {
  InvalidEmployee(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Invalid Employee';
  }
}

class InvalidPermission extends DioError {
  InvalidPermission(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Invalid Permission';
  }
}

class IncorrectOldPassword extends DioError {
  IncorrectOldPassword(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Incorrect old password';
  }
}

class InvalidData extends DioError {
  InvalidData(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Incorrect dates, try again with different dates';
  }
}

class OverlapingLeave extends DioError {
  OverlapingLeave(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'This leave is overlapping with other leaves !';
  }
}

class InvalidHourlyLeave extends DioError {
  InvalidHourlyLeave(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Invalid selected hours, try again with different selected hours';
  }
}

class OverlapingOffDay extends DioError {
  OverlapingOffDay(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'This leave is overlapping with off days !';
  }
}

class LimitExceeded extends DioError {
  LimitExceeded(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Sorry,Leave type limit exceeded !';
  }
}
