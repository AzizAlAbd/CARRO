import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Services/auth_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepo repo;
  final SecureStorage storage;
  LogInCubit({required this.repo, required this.storage})
      : super(LogInInitial());

  void login({
    required String email,
    required String password,
  }) async {
    emit(LogInloading());
    try {
      final response = await repo.create(email: email, password: password);
      await storage.saveAccessToken(response!.data.token);
      await storage.saveEmail(response.data.user.email);
      await storage.saveCustomerID(response.data.user.id);
      await storage.saveCustomerName(response.data.user.name);
      await storage.saveLocation(response.data.user.location);
      await storage.saveMobileNumber(response.data.user.phoneNumber);
      await storage.saveProfileImage(response.data.user.avatar);
      emit(LogInSucceeded());
    } on DioError catch (e) {
      print(e.toString());
      emit(LogInFailed(e.toString()));
    } catch (e) {
      print(e.toString());
      emit(LogInFailed(ErrorInterceptors.unhandledException));
    }
  }
}
