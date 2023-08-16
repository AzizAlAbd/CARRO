import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/views/add_car_screen/add_car_screen.dart';
import 'package:cars_app/UI/views/categories_page/categories_page.dart';
import 'package:cars_app/UI/views/home_page/home_page.dart';

import 'package:cars_app/UI/views/my_cars_page/my_cars_page.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:cars_app/UI/widgets/menu_widget.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:cars_app/UI/widgets/my_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _bottomNavIndex = 1;
  final _drawerController = ZoomDrawerController();
  final _pageController = PageController(initialPage: 1);
  List<Widget>? _pages;
  void toggleDrawer() {
    print("Toggle drawer");
    _drawerController.toggle?.call();
  }

  @override
  void initState() {
    _pages = [MyCarsPage(), Homepage(), CategoriesPage()];
    context.read<AppCubit>().initializeApp();
    super.initState();
  }

  void changePage(int value) {
    setState(() {
      _bottomNavIndex = value;

      _pageController.animateToPage(value,
          curve: Curves.easeInOut, duration: Duration(milliseconds: 400));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      slideWidth: 65.w,
      style: DrawerStyle.defaultStyle,
      menuScreenWidth: 55.w,
      angle: -0.0,
      showShadow: true,
      menuBackgroundColor: secondColor,
      mainScreenScale: 0.2,
      duration: Duration(milliseconds: 500),
      menuScreen: MenuWidget(
        toggle: toggleDrawer,
      ),
      mainScreen: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state.status == AppStatus.loading) {
            return Scaffold(
              body: Center(
                child: LoadingWidget(),
              ),
            );
          }
          if (state.status == AppStatus.failed) {
            return Scaffold(
              body: MyErrorWidget(
                error: state.error,
                func: () {
                  context.read<AppCubit>().initializeApp();
                },
              ),
            );
          }
          return Scaffold(
              extendBody: true,
              bottomNavigationBar: MyBottomBar(
                  bottomIndex: _bottomNavIndex, changePage: changePage),
              appBar: MyAppBar(
                isHome: true,
                toggleDrawer: toggleDrawer,
              ),
              floatingActionButton: _bottomNavIndex == 0
                  ? FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AddCarScreen.routeName);
                      },
                      backgroundColor: Colors.deepPurple,
                      child: SvgPicture.asset(
                        'assets/icons/add_car_icon.svg',
                        color: Colors.white,
                      ),
                    )
                  : null,
              body: PageView(
                children: [..._pages!],
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _bottomNavIndex = value;
                  });
                },
                // _pages![_bottomNavIndex]
              ));
        },
      ),
    );
  }
}
