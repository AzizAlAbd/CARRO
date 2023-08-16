import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/Core/Cubits/schedual_cubit/schedual_cubit.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Core/Models/appointments_model.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentData appointment;
  final isReceived;
  const AppointmentCard(
      {super.key, required this.appointment, required this.isReceived});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h),
      child: Card(
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.Q)),
        child: Container(
          padding: EdgeInsets.only(bottom: 1.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.Q),
              border: Border.all(color: secondColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Container(
                        width: 13.w,
                        height: 13.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(isReceived
                                    ? appointment.sender.avatar
                                    : appointment.receiver.avatar),
                                fit: BoxFit.cover),
                            color: Colors.black,
                            shape: BoxShape.circle),
                      ),
                      title: Text(
                        isReceived
                            ? appointment.sender.name
                            : appointment.receiver.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(isReceived
                          ? appointment.sender.phoneNumber
                          : appointment.receiver.phoneNumber),
                    ),
                  ),
                  // PopupMenuButton(
                  //   itemBuilder: (context) {
                  //     return [
                  //       PopupMenuItem(
                  //           child: Text(
                  //         'Show Profile',
                  //         style: TextStyle(
                  //             fontSize: 14.sp, fontWeight: FontWeight.normal),
                  //       )),
                  //       PopupMenuItem(
                  //           child: Text(
                  //         'Cancel the Appointment',
                  //         style: TextStyle(
                  //             fontSize: 14.sp, fontWeight: FontWeight.normal),
                  //       ))
                  //     ];
                  //   },
                  // ),
                  IconButton(
                      onPressed: () {
                        DialogUtils.questionDialog(context,
                            icon: Icon(
                              Icons.question_mark_rounded,
                              color: secondColor,
                              size: 70.Q,
                            ),
                            content:
                                'Are you sure, you want to delete this appointment?',
                            buttonFuction: () async {
                          await context
                              .read<SchedualCubit>()
                              .deteleAppointment(id: appointment.id);

                          Navigator.of(context).pop();
                        });
                      },
                      splashRadius: 20.Q,
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        size: 24.Q,
                        color: Colors.red,
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Row(
                  children: [
                    Text(
                      DateFormat.jm().format(appointment.date),
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: secondColor),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      DateFormat.yMMMEd().format(appointment.date),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
