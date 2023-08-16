import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/Core/Cubits/my_cars_cubit/my_cars_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyCarCard extends StatelessWidget {
  final CarData car;
  const MyCarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
      child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.Q)),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.Q),
                  border: Border.all(color: secondColor)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(8.Q),
                    width: 30.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(car.images[0]),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15.Q)),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 42.w,
                            child: Text(
                              car.model,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.directions_car_rounded,
                                color: secondColor,
                              ),
                              SizedBox(
                                width: 35.w,
                                child: Text(
                                  car.brand,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontSize: 15.sp, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.car_crash_rounded,
                                color: secondColor,
                              ),
                              Text(
                                car.forSale ? 'Selling' : 'Renting',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 15.sp, color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        DialogUtils.questionDialog(context,
                            icon: Icon(
                              Icons.question_mark_rounded,
                              color: secondColor,
                              size: 70.Q,
                            ),
                            content:
                                'Are you sure, you want to delete this car?',
                            buttonFuction: () async {
                          await context
                              .read<MyCarsCubit>()
                              .deleteCar(id: car.id);

                          Navigator.of(context).pop();
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.xmark,
                        size: 20.Q,
                      ))
                ],
              ))),
    );
  }
}
