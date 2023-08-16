import 'package:cars_app/UI/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyErrorWidget extends StatelessWidget {
  final String error;
  final Function func;
  const MyErrorWidget({super.key, required this.error, required this.func});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   child: Image.asset('assets/images/error.jpg'),
          // ),
          Icon(
            Icons.error,
            size: 70.Q,
            color: secondColor,
          ),
          Text(
            error,
            textAlign: TextAlign.center,
          ),
          TextButton.icon(
            onPressed: () {
              func();
            },
            label: Text(
              'Try again',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: Icon(Icons.replay),
          )
        ],
      ),
    );
  }
}
