import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cars_app/Core/Cubits/search_cubit/search_cubit.dart';

import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/views/notifications_screen/notifications_screen.dart';
import 'package:cars_app/UI/views/result_screen/result_screen.dart';
import 'package:cars_app/UI/widgets/filter_dialog.dart';
import 'package:cars_app/UI/widgets/filter_icon.dart';
import 'package:cars_app/UI/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? barColor;
  final Color? textColor;
  final bool isHome;
  final Function? toggleDrawer;
  final bool showSearchBar;
  final searchController = TextEditingController();
  MyAppBar(
      {super.key,
      this.title,
      this.barColor,
      this.textColor,
      this.isHome = false,
      this.toggleDrawer,
      this.showSearchBar = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: isHome
            ? IconButton(
                onPressed: () {
                  toggleDrawer!();
                },
                icon: Icon(Icons.menu))
            : null,
        actions: isHome
            ? [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(NotificationsScreen.routeName);
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/notification.svg',
                      color: Colors.black,
                    ))
              ]
            : null,
        elevation: 0,
        title: title == null
            ? AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                animatedTexts: [WavyAnimatedText('CARRO')]) //'CARRO'
            : Text(
                title!,
                style: TextStyle(fontSize: 20.sp),
              ),
        backgroundColor: barColor ?? Colors.transparent,
        foregroundColor: textColor ?? mainColor,
        centerTitle: true,
        bottom: showSearchBar
            ? PreferredSize(
                preferredSize: Size(double.infinity, 6.h),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 4.w, right: 4.w, bottom: 0.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: InputField(
                          icon: Icons.search,
                          controller: searchController,
                          hint: 'Search for specific model',
                          onEditingComplete: () {
                            if (searchController.text.isNotEmpty) {
                              context
                                  .read<SearchCubit>()
                                  .saveModel(model: searchController.text);

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  ResultScreen.routeName,
                                  (route) => route.isFirst,
                                  arguments: searchController.text);

                              searchController.clear();
                            }
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .pushNamed(SearchScreen.routeName);
                      //   },
                      //   child:

                      //   Container(
                      //     padding: EdgeInsets.all(3.w),
                      //     width: 80.w,
                      //     decoration: BoxDecoration(
                      //         color: lighterGray,
                      //         borderRadius: BorderRadius.circular(5)),
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.search,
                      //           color: grayColor,
                      //           size: 30.Q,
                      //         ),
                      //         SizedBox(
                      //           width: 4.w,
                      //         ),
                      //         Text(
                      //           'Search for specific car',
                      //           style: TextStyle(color: grayColor),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      FilterICon(
                        ontap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return FilterDialog(onSearch: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    ResultScreen.routeName,
                                    (route) => route.isFirst,
                                    arguments: searchController.text);
                              });
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            : null);
  }

  @override
  Size get preferredSize => Size(100.w, showSearchBar ? 15.h : 8.h);
}
