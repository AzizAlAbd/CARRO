part of 'my_cars_cubit.dart';

abstract class MyCarsState {}

class MyCarsInitial extends MyCarsState {}

class MyCarsLoading extends MyCarsState {}

class carDeleteLoading extends MyCarsState {}

class carDeleteSucceeded extends MyCarsState {}

class carDeleteFailed extends MyCarsState {
  final String error;

  carDeleteFailed(this.error);
}

class MyCarsEmpty extends MyCarsState {}

class MyCarsLoaded extends MyCarsState {
  final List<CarData> mycars;

  MyCarsLoaded(this.mycars);
}

class MyCarsFailed extends MyCarsState {
  final String error;

  MyCarsFailed(this.error);
}
