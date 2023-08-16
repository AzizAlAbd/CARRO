part of 'view_all_cubit.dart';

abstract class ViewAllState {}

class ViewAllInitial extends ViewAllState {}

class ViewAllLoading extends ViewAllState {}

class ViewAllLoaded extends ViewAllState {
  final List<CarData> cars;

  ViewAllLoaded(this.cars);
}

class ViewAllFailed extends ViewAllState {
  final String error;

  ViewAllFailed(this.error);
}
