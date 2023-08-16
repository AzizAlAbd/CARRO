part of 'search_cubit.dart';

enum SearchStatus { inital, loading, failed, succeeded }

class SearchState extends Equatable {
  final SearchStatus status;
  final String model;
  final String brand;
  final String priceRange;

  final String meterRange;

  final String location;
  final String type;
  final String error;
  final List<CarData> result;
  const SearchState(
      {this.status = SearchStatus.inital,
      this.model = '',
      this.brand = '',
      this.priceRange = '',
      this.meterRange = '',
      this.location = '',
      this.type = '',
      this.error = '',
      this.result = const []});

  @override
  List<Object> get props => [
        this.status,
        this.brand,
        this.model,
        this.priceRange,
        this.meterRange,
        this.location,
        this.type,
        this.error,
        this.result
      ];

  SearchState copyWith({
    SearchStatus? status,
    String? model,
    String? brand,
    String? priceRange,
    String? meterRange,
    String? location,
    String? type,
    String? error,
    List<CarData>? result,
  }) {
    return SearchState(
        status: status ?? this.status,
        model: model ?? this.model,
        brand: brand ?? this.brand,
        priceRange: priceRange ?? this.priceRange,
        meterRange: meterRange ?? this.meterRange,
        location: location ?? this.location,
        type: type ?? this.type,
        error: error ?? this.error,
        result: result ?? this.result);
  }
}
