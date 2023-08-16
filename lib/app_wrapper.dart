import 'package:cars_app/Core/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:cars_app/UI/views/home_screen/home_screen.dart';
import 'package:cars_app/UI/views/login_screen/login_screen.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  AppWrapperState createState() => AppWrapperState();
}

class AppWrapperState extends State<AppWrapper> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationUninitialized) {
        } else if (state is AuthenticationLoading) {
          return const Scaffold(
              body: Center(
            child: LoadingWidget(),
          ));
        } else if (state is AuthenticationUnauthenticated) {
          return const LoginScreen();
        } else if (state is AuthenticationAuthenticated) {
          return const HomeScreen();
        } else if (state is AuthenticationFailed) {
          return const Scaffold(
              body: Center(child: Text('AuthenticationFailed')));
        }
        return const LoginScreen();
      },
    );
  }
}
