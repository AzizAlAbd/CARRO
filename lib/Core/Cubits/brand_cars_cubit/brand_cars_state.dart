part of 'brand_cars_cubit.dart';

abstract class BrandCarsState {}

class BrandCarsInitial extends BrandCarsState {}

class BrandCarsLoading extends BrandCarsState {}

class BrandCarsLoaded extends BrandCarsState {
  final List<CarData> cars;

  BrandCarsLoaded(this.cars);
}

class BrandCarsFailed extends BrandCarsState {
  final String error;

  BrandCarsFailed(this.error);
}
