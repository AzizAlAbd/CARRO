import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/Core/Cubits/notifications_cubit/notifications_cubit.dart';
import 'package:cars_app/Core/Models/notifications_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationCard extends StatelessWidget {
  final NotificationData not;
  const NotificationCard({super.key, required this.not});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.Q)),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.Q),
                  border: Border.all(
                    color: secondColor,
                  )),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 11.w,
                      height: 11.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                not.sender.avatar,
                              ),
                              fit: BoxFit.cover),
                          color: Colors.black,
                          shape: BoxShape.circle),
                    ),
                    title: Text(
                      not.sender.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Want to make an appointment with you'),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.directions_car,
                                color: secondColor,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                not.car.model,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 15.sp, color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: secondColor,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                '${DateFormat.yMMMEd().format(not.date)}  - ${DateFormat.jm().format(not.date)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 15.sp, color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              context
                                  .read<NotificationsCubit>()
                                  .replay(notID: not.id, accept: false);
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                foregroundColor: Colors.red),
                            child: Text(
                              'Decline',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(
                          height: 4.h,
                          child: VerticalDivider(
                            width: 0.w,
                            thickness: 2,
                            color: Color.fromARGB(255, 212, 212, 212),
                          )),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              context
                                  .read<NotificationsCubit>()
                                  .replay(notID: not.id, accept: true);
                            },
                            child: Text(
                              'Accept',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                visualDensity: VisualDensity(horizontal: -3),
                                foregroundColor: Colors.green)),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
