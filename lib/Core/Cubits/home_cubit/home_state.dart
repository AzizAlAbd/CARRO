part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeData data;

  HomeLoaded(this.data);
}

class HomeFailed extends HomeState {
  final String error;

  HomeFailed(this.error);
}
