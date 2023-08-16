import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/Core/Services/search_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;
  SearchCubit({required this.repo}) : super(SearchState());

  void saveModel({required String model}) {
    emit(state.copyWith(model: model));

    log('$model model is saved!');
  }

  void saveFilter({
    required String? type,
    required String? brand,
    required String? priceRange,
    required String? meterRange,
    required String? location,
  }) {
    emit(state.copyWith(
      brand: brand,
      location: location,
      meterRange: meterRange,
      priceRange: priceRange,
      type: type,
    ));
    log('filter is saved!');
  }

  void clear() {
    emit(state.copyWith(
        brand: '',
        location: '',
        meterRange: '',
        priceRange: '',
        type: '',
        model: '',
        error: '',
        status: SearchStatus.inital,
        result: []));
  }

  Future<void> search() async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      String minPrice = '', maxPrice = '';
      String minMeter = '', maxMeter = '';
      final splitingPrice = state.priceRange.isNotEmpty
          ? state.priceRange.trim().split('->')
          : [];
      final splitingMeter = state.meterRange.isNotEmpty
          ? state.meterRange.trim().split('->')
          : [];
      if (splitingPrice.isNotEmpty) {
        minPrice = splitingPrice[0];
        maxPrice = splitingPrice[1];
      }
      if (splitingMeter.isNotEmpty) {
        minMeter = splitingMeter[0];
        maxMeter = splitingMeter[1];
      }
      final response = await repo.search(
          model: state.model,
          brand: state.brand,
          minPrice: minPrice,
          maxPrice: maxPrice,
          minMeter: minMeter,
          maxMeter: maxMeter,
          location: state.location,
          type: state.type);

      emit(state.copyWith(
          result: response.data, status: SearchStatus.succeeded));
    } on DioError catch (e) {
      emit(state.copyWith(error: e.toString(), status: SearchStatus.failed));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          error: ErrorInterceptors.unhandledException,
          status: SearchStatus.failed));
    }
  }
}
