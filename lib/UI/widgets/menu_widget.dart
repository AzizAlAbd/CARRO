import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:cars_app/UI/views/my_fav_screen/my_fav_screen.dart';
import 'package:cars_app/UI/views/profile_screen/profile_screen.dart';
import 'package:cars_app/UI/views/schedual_screen/schedual_screen.dart';
import 'package:cars_app/UI/widgets/my_avater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../views/notifications_screen/notifications_screen.dart';

class MenuWidget extends StatelessWidget {
  final Function toggle;
  const MenuWidget({super.key, required this.toggle});

  Widget buildTile(
      {required String title,
      required IconData icon,
      required TextStyle style,
      required Function func}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          func();
        },
        splashColor: Colors.white30,
        borderRadius: BorderRadius.circular(30),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          minLeadingWidth: 0,
          leading: Icon(
            icon,
            size: 28.Q,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: style.copyWith(fontSize: 17.sp),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 20.sp);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        String name = state.name;
        return Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 3.w, bottom: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            MyAvatar(),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              name,
                              textAlign: TextAlign.center,
                              style: style,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            toggle();
                          },
                          child: Icon(Icons.cancel_outlined,
                              color: Colors.white, size: 30.Q),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    buildTile(
                        title: 'My Profile',
                        icon: Icons.account_box,
                        style: style,
                        func: () {
                          Navigator.of(context)
                              .pushNamed(ProfileScreen.routeName);
                        }),
                    buildTile(
                        title: 'Schedual',
                        icon: Icons.schedule,
                        style: style,
                        func: () {
                          Navigator.of(context)
                              .pushNamed(SchedualScreen.routeName);
                        }),
                    buildTile(
                        title: 'My Favorites',
                        icon: Icons.favorite_rounded,
                        style: style,
                        func: () {
                          Navigator.of(context)
                              .pushNamed(MyFavScreen.routeName);
                        }),
                    buildTile(
                        title: 'Notificatios',
                        icon: Icons.notifications,
                        style: style,
                        func: () {
                          Navigator.of(context)
                              .pushNamed(NotificationsScreen.routeName);
                        }),
                  ],
                ),
                OutlinedButton.icon(
                    onPressed: () {
                      context.read<AuthenticationCubit>().logout();
                    },
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white)),
                    icon: Icon(Icons.exit_to_app),
                    label: Text(
                      'Logout',
                      style: style.copyWith(fontSize: 16),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
