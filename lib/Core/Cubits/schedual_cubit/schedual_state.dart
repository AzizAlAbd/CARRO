part of 'schedual_cubit.dart';

abstract class SchedualState {}

class SchedualInitial extends SchedualState {}

class SchedualLoading extends SchedualState {}

class SchedualEmpty extends SchedualState {}

class SchedualLoaded extends SchedualState {
  final List<AppointmentData> recivedAppointment;
  final List<AppointmentData> sentAppointment;

  SchedualLoaded(
      {required this.recivedAppointment, required this.sentAppointment});
}

class SchedualFailed extends SchedualState {
  final String error;

  SchedualFailed(this.error);
}

class DeleteAppointmentLoading extends SchedualState {}

class DeleteAppointmentSucceeded extends SchedualState {}

class DeleteAppointmentFailed extends SchedualState {
  final String error;

  DeleteAppointmentFailed(this.error);
}
