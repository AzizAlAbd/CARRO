part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class UpdateLoading extends ProfileState {}

class UpdateSucceeded extends ProfileState {}

class UpdateFailed extends ProfileState {
  final String error;

  UpdateFailed(this.error);
}

class ProfileLoaded extends ProfileState {
  final ProfileData data;

  ProfileLoaded(this.data);
}

class ProfileFailed extends ProfileState {
  final String error;

  ProfileFailed(this.error);
}
