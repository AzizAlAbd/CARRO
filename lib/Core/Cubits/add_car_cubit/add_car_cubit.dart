import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Services/my_cars_repo.dart';
import 'package:dio/dio.dart';

import '../../Apis/interceptors/error_interceptors.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  final MyCarsRepo repo;
  AddCarCubit({required this.repo}) : super(AddCarInitial());

  void addCar(
      {required List<String> images,
      required bool forSelling,
      required String brand,
      required String model,
      required String location,
      required String price,
      required String odometer,
      required String description}) async {
    emit(AddCarLoading());
    try {
      await repo.addCar(
          images: images,
          forSelling: forSelling,
          brand: brand,
          model: model,
          location: location,
          price: price,
          odometer: odometer,
          description: description);

      emit(AddCarSucceeded());
    } on DioError catch (e) {
      emit(AddCarFailed(e.toString()));
    } catch (e) {
      log(e.toString());
      emit(AddCarFailed(ErrorInterceptors.unhandledException));
    }
  }
}
