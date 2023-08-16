part of 'log_in_cubit.dart';

abstract class LogInState {}

class LogInInitial extends LogInState {}

class LogInloading extends LogInState {}

class LogInSucceeded extends LogInState {}

class LogInFailed extends LogInState {
  final String error;

  LogInFailed(this.error);
}
