part of 'add_car_cubit.dart';

abstract class AddCarState {}

class AddCarInitial extends AddCarState {}

class AddCarLoading extends AddCarState {}

class AddCarSucceeded extends AddCarState {}

class AddCarFailed extends AddCarState {
  final String error;

  AddCarFailed(this.error);
}
