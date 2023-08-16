part of 'app_cubit.dart';

enum AppStatus {
  initial,
  loading,
  failed,
  succeeded,
}

class AppState extends Equatable {
  final AppStatus status;
  final String avatar;
  final String name;
  final String error;
  final List<String> brands;
  final List<BrandData> brandsData;

  const AppState(
      {this.status = AppStatus.initial,
      this.avatar = '',
      this.name = '',
      this.error = '',
      this.brands = const [],
      this.brandsData = const []});

  @override
  List<Object> get props => [
        this.status,
        this.avatar,
        this.name,
        this.error,
        this.brands,
        this.brandsData
      ];

  AppState copyWith(
      {AppStatus? status,
      String? name,
      String? avatar,
      String? error,
      List<String>? brands,
      List<BrandData>? brandsData}) {
    return AppState(
        status: status ?? this.status,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        error: error ?? this.error,
        brands: brands ?? this.brands,
        brandsData: brandsData ?? this.brandsData);
  }
}
