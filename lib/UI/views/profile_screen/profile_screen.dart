import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Cubits/avatar_cubit/avatar_cubit.dart';
import 'package:cars_app/Core/Cubits/profile_cubit/profile_cubit.dart';
import 'package:cars_app/Core/Models/profile_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/views/edit_profile_screen/edit_profile_screen.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:cars_app/UI/widgets/my_avater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animate_do/animate_do.dart' as animate;

class ProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileData? data;
  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Profile',
        showSearchBar: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(EditProfileScreen.routeName, arguments: data);
        },
        child: Icon(Icons.edit),
        backgroundColor: secondColor,
      ),
      body: BlocListener<AvatarCubit, AvatarState>(
        listener: (context, state) {
          if (state is AvatarLoading) {
            Loader.show(status: EasyLoadingConfig.loadingText);
          }
          if (state is! AvatarLoading) {
            Loader.dismiss();
          }
          if (state is AvatarSucceeded) {
            context.read<AppCubit>().reReadAvatar();
          }
          if (state is AvatarFailed) {
            DialogUtils.ourAlertDialog(context,
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 100,
                ),
                content: state.error);
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: LoadingWidget(),
              );
            }
            if (state is ProfileFailed) {
              return MyErrorWidget(
                error: state.error,
                func: () {
                  context.read<ProfileCubit>().getProfile();
                },
              );
            }

            if (state is ProfileLoaded) {
              data = state.data;
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  animate.SlideInDown(
                    duration: Duration(milliseconds: 800),
                    child: SizedBox(
                      height: 32.h,
                      child: Stack(children: [
                        Material(
                            elevation: 4,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80.Q),
                                bottomRight: Radius.circular(80.Q)),
                            child: Container(
                              height: 30.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: secondColor, width: 2),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(80.Q),
                                      bottomRight: Radius.circular(80.Q))),
                            )),
                        Positioned(
                          right: 0,
                          top: -8.h,
                          child: Container(
                            height: 30.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                                color: secondColor.withOpacity(0.5),
                                // borderRadius: BorderRadius.circular(300.Q)
                                borderRadius: BorderRadius.only(
                                    // topRight: Radius.circular(50.Q),
                                    // topLeft: Radius.circular(200.Q),
                                    bottomLeft: Radius.circular(300.Q))),
                          ),
                        ),
                        Positioned(
                          top: -6.h,
                          right: 0,
                          child: Container(
                            height: 20.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                color: secondColor.withOpacity(0.5),

                                // borderRadius: BorderRadius.circular(300.Q)
                                borderRadius: BorderRadius.only(
                                    // topRight: Radius.circular(50.Q),
                                    // topLeft: Radius.circular(200.Q),
                                    bottomLeft: Radius.circular(300.Q))),
                          ),
                        ),
                        Positioned(
                          top: 3.h,
                          bottom: 3.h,
                          right: 20.w,
                          left: 20.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyAvatar(
                                showEdit: true,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                data!.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 18.sp, color: mainColor),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
                    child: Column(
                      children: [
                        buildProfileTile(
                            icon: Icons.person,
                            title: 'Name',
                            subtitle: data!.name),
                        buildProfileTile(
                            icon: Icons.email,
                            title: 'Email',
                            subtitle: data!.email,
                            delay: 200),
                        buildProfileTile(
                            icon: Icons.phone,
                            title: 'Mobile Number',
                            subtitle: data!.phoneNumber,
                            delay: 400),
                        buildProfileTile(
                            icon: Icons.location_city,
                            title: 'Location',
                            subtitle: '${data!.location}, Syria',
                            delay: 600),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildProfileTile(
      {required IconData icon,
      required String title,
      required String subtitle,
      int delay = 0}) {
    return animate.FadeIn(
      duration: Duration(milliseconds: 800),
      delay: Duration(milliseconds: delay),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.Q),
              border: Border.all(width: 2, color: secondColor)),
          child: Icon(
            icon,
            color: secondColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: secondColor,
            fontSize: 17.sp,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: mainColor),
        ),
      ),
    );
  }
}
