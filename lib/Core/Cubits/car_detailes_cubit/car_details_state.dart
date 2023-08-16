part of 'car_details_cubit.dart';

abstract class CarDetailsState {}

class CarDetailsInitial extends CarDetailsState {}

class CarDetailsLoading extends CarDetailsState {}

class CarDetailsSucceeded extends CarDetailsState {
  final CarData car;

  CarDetailsSucceeded(this.car);
}

class CarDetailsFailed extends CarDetailsState {
  final String error;

  CarDetailsFailed(this.error);
}

class CarRatingloading extends CarDetailsState {}

class CarRatingSucceeded extends CarDetailsState {}

class CarRatingFailed extends CarDetailsState {
  final String error;

  CarRatingFailed(this.error);
}

class CarAppointmentLoading extends CarDetailsState {}

class CarAppointmentSucceeded extends CarDetailsState {}

class CarAppointmentFailed extends CarDetailsState {
  final String error;

  CarAppointmentFailed(this.error);
}
