part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUploading extends SignUpState {}

class SignUpSucceeded extends SignUpState {}

class SignUpFailed extends SignUpState {
  final String error;

  SignUpFailed(this.error);
}
