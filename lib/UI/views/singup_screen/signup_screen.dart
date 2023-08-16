import 'package:cars_app/Core/Cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/helpers/validators.dart';
import 'package:cars_app/UI/views/home_screen/home_screen.dart';
import 'package:cars_app/UI/views/login_screen/login_screen.dart';
import 'package:cars_app/UI/widgets/button.dart';
import 'package:cars_app/UI/widgets/input_field.dart';
import 'package:cars_app/UI/widgets/my_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animate_do/animate_do.dart' as animation;

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String? governorate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUploading) {
            Loader.show(status: EasyLoadingConfig.loadingText);
          }
          if (state is! SignUploading) {
            Loader.dismiss();
          }
          if (state is SignUpSucceeded) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
          }
          if (state is SignUpFailed) {
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
                          height: 11.h,
                        ),
                        animation.ZoomIn(
                            child: SvgPicture.asset('assets/images/logo.svg')),
                        SizedBox(
                          height: 5.h,
                        ),
                        animation.Pulse(
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Find your dream car!',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 18.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                InputField(
                                  label: 'Username',
                                  formContext: context,
                                  controller: usernameController,
                                  icon: Icons.person,
                                  multiLine: false,
                                  valMessage: 'Please enter username',
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                InputField(
                                  label: 'Email',
                                  formContext: context,
                                  controller: emailController,
                                  icon: Icons.email,
                                  validator: emailValidator,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                InputField(
                                  label: 'Phone number',
                                  formContext: context,
                                  controller: phoneController,
                                  icon: Icons.phone,
                                  keybordType: TextInputType.phone,
                                  valMessage: 'Please enter phone number',
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                InputField(
                                  label: 'Password',
                                  formContext: context,
                                  controller: passwordController,
                                  icon: Icons.lock,
                                  validator: passValidator,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                MyDropdownMenu(
                                    value: governorate,
                                    isItForSignup: true,
                                    icon: Icons.location_city_rounded,
                                    onChange: (value) {
                                      setState(() {
                                        governorate = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'please choose a governorate';
                                      }
                                      return null;
                                    },
                                    menu: governrates,
                                    hint: 'Choose the governorate')
                              ],
                            )),
                        SizedBox(
                          height: 3.h,
                        ),
                        Button(
                          buttonWidth: double.infinity,
                          text: 'Sing Up',
                          buttonColor: secondColor,
                          onPressed: () {
                            // Loader.show(status: EasyLoadingConfig.loadingText);
                            if (formKey.currentState!.validate()) {
                              context.read<SignUpCubit>().signUp(
                                  name: usernameController.text,
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  mobile: phoneController.text.trim(),
                                  location: governorate!);
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                              child: Text('Sign In',
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
                    )))),
      ),
    );
  }
}
