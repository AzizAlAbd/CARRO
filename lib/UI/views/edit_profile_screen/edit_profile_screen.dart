import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Cubits/profile_cubit/profile_cubit.dart';
import 'package:cars_app/Core/Models/profile_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/widgets/button.dart';
import 'package:cars_app/UI/widgets/input_field.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:cars_app/UI/widgets/my_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/EditProfileScreen';
  final ProfileData data;
  const EditProfileScreen({super.key, required this.data});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  final phoneController = TextEditingController();

  String? governorate;

  @override
  void initState() {
    usernameController.text = widget.data.name;
    phoneController.text = widget.data.phoneNumber;
    governorate =
        widget.data.location == 'homs' ? 'Homs' : widget.data.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Update Profile',
        showSearchBar: false,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) async {
          if (state is UpdateLoading) {
            Loader.show(status: EasyLoadingConfig.loadingText);
          }
          if (state is! UpdateLoading) {
            Loader.dismiss();
          }
          if (state is UpdateSucceeded) {
            await context.read<ProfileCubit>().getProfile();
            await context.read<AppCubit>().reReadName();
            Navigator.of(context).pop();
          }
          if (state is UpdateFailed) {
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
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
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
                      menu: ['Homs', 'Hama', 'Damascus', 'Aleppo'],
                      hint: 'Choose the governorate'),
                  SizedBox(
                    height: 3.h,
                  ),
                  Button(
                    buttonWidth: double.infinity,
                    text: 'Update',
                    buttonColor: secondColor,
                    onPressed: () {
                      // Loader.show(status: EasyLoadingConfig.loadingText);
                      if (formKey.currentState!.validate()) {
                        context.read<ProfileCubit>().updateProfile(
                            name: usernameController.text,
                            phone: phoneController.text,
                            location: governorate!);
                      }
                    },
                  ),
                ],
              )),
        )),
      ),
    );
  }
}
