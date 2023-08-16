part of 'my_fav_cubit.dart';

abstract class MyFavState {}

class MyFavInitial extends MyFavState {}

class MyFavLoading extends MyFavState {}

class MyFavLoaded extends MyFavState {
  final List<CarData> cars;

  MyFavLoaded(this.cars);
}

class MyFavFailed extends MyFavState {
  final String error;

  MyFavFailed(this.error);
}

class MyFavEmpty extends MyFavState {}

// class favToggleLoading extends MyFavState {}

// class favToggleSucceeded extends MyFavState {}

class favToggleFailed extends MyFavState {
  final String error;

  favToggleFailed(this.error);
}
