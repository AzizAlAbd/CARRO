part of 'avatar_cubit.dart';

abstract class AvatarState {}

class AvatarInitial extends AvatarState {}

class AvatarLoading extends AvatarState {}

class AvatarSucceeded extends AvatarState {}

class AvatarFailed extends AvatarState {
  final String error;

  AvatarFailed(this.error);
}
