import 'package:cars_app/Core/Models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarInfoWidget extends StatelessWidget {
  final CarData car;
  const CarInfoWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            'Brand: ',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            car.brand,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 2.h,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Model: ',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 70.w,
            child: Text(
              car.model,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 2.h,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location: ',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 70.w,
            child: Text(
              car.location,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 2.h,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Crossed Distance: ',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 50.w,
            child: Text(
              '${car.kilometerage} KM',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 2.h,
      ),
      Text(
        'Description: ',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 100.w,
        child: Text(
          car.description,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ),
    ]);
  }
}
