import 'package:cars_app/Core/Cubits/log_in_cubit/log_in_cubit.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/helpers/validators.dart';
import 'package:cars_app/UI/views/home_screen/home_screen.dart';
import 'package:cars_app/UI/views/singup_screen/signup_screen.dart';
import 'package:cars_app/UI/widgets/button.dart';
import 'package:cars_app/UI/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animate_do/animate_do.dart' as animation;

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInloading) {
            Loader.show(status: EasyLoadingConfig.loadingText);
          }
          if (state is! LogInloading) {
            Loader.dismiss();
          }
          if (state is LogInSucceeded) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          }
          if (state is LogInFailed) {
            DialogUtils.ourAlertDialog(context,
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 100,
                ),
                content: state.error);
          }
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  animation.ZoomIn(
                      child: SvgPicture.asset('assets/images/logo.svg')),
                  SizedBox(
                    height: 5.h,
                  ),
                  animation.Pulse(
                    child: Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 18.sp),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Welcome to CARRO',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          InputField(
                            label: 'Email',
                            formContext: context,
                            controller: usernameController,
                            icon: Icons.email,
                            validator: emailValidator,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          InputField(
                            label: 'Password',
                            formContext: context,
                            controller: passwordController,
                            icon: Icons.lock,
                            showEye: true,
                            obsecure: true,
                            multiLine: false,
                            validator: passValidator,
                          )
                        ],
                      )),
                  SizedBox(
                    height: 4.h,
                  ),
                  Button(
                    buttonWidth: double.infinity,
                    text: 'Login',
                    buttonColor: secondColor,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LogInCubit>().login(
                            email: usernameController.text.trim(),
                            password: passwordController.text.trim());
                      }
                    },
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                        child: Text('Signup',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: secondColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
