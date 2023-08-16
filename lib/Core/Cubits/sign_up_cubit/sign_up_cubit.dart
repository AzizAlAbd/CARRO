import 'package:bloc/bloc.dart';
import 'package:cars_app/Core/Apis/interceptors/error_interceptors.dart';
import 'package:cars_app/Core/Services/auth_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:dio/dio.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo repo;
  final SecureStorage storage;
  SignUpCubit({required this.repo, required this.storage})
      : super(SignUpInitial());

  void signUp(
      {required String name,
      required String email,
      required String password,
      required String mobile,
      required String location}) async {
    emit(SignUploading());
    try {
      final response = await repo.signUp(
          name: name,
          email: email,
          password: password,
          mobile: mobile,
          location: location);
      if (response!.response == 1) {
        final response2 = await repo.create(email: email, password: password);
        await storage.saveAccessToken(response2!.data.token);
        await storage.saveEmail(response.data.email);
        await storage.saveCustomerID(response.data.id);
        await storage.saveCustomerName(response.data.name);
        await storage.saveLocation(response.data.location);
        await storage.saveMobileNumber(response.data.phoneNumber);
        await storage.saveProfileImage(response.data.avatar);
        emit(SignUpSucceeded());
      }
    } on DioError catch (e) {
      emit(SignUpFailed(e.toString()));
    } catch (e) {
      emit(SignUpFailed(ErrorInterceptors.unhandledException));
    }
  }
}
