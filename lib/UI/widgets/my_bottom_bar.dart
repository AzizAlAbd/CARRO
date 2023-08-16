import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyBottomBar extends StatefulWidget {
  final int bottomIndex;
  final Function changePage;
  const MyBottomBar(
      {super.key, required this.bottomIndex, required this.changePage});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      padding: EdgeInsets.only(bottom: 1.h, left: 2.w, right: 2.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.Q)
          // BorderRadius.only(
          //     topLeft: Radius.circular(50), topRight: Radius.circular(50))

          ),
      elevation: 15,
      snakeShape: SnakeShape.rectangle,
      snakeViewColor: Colors.deepPurple,
      showSelectedLabels: true,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: widget.bottomIndex,
      selectedLabelStyle: TextStyle(fontSize: 14.sp, color: Colors.deepPurple),
      onTap: (value) {
        widget.changePage(value);
      },
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.car_detailed),
          label: 'My Cars',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 28.Q,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.square_grid_2x2_fill,
            ),
            label: 'Categories'),
      ],
    );
  }
}
