import 'package:animate_do/animate_do.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class OurDialog extends StatelessWidget {
  final Icon dialogIcon;
  final String contentText;
  final String firstButtonText;
  final String? secondButtonText;
  final Function? secoundButtonFunc;
  final Function? cancelButtonFunc;
  final bool preventBackword;
  const OurDialog(
      {Key? key,
      required this.dialogIcon,
      required this.contentText,
      this.secondButtonText,
      this.secoundButtonFunc,
      this.cancelButtonFunc,
      this.preventBackword = false,
      required this.firstButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(!preventBackword),
      child: SimpleDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 3.w),
          contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.Q)),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flash(child: dialogIcon),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  contentText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      text: firstButtonText,
                      textColor: const Color(0xFF999999),
                      elevation: 0,
                      buttonWidth: secondButtonText != null ? 30.w : 50.w,
                      borderColor: const Color(0xFF999999),
                      onPressed: () {
                        cancelButtonFunc == null
                            ? Navigator.of(context).pop()
                            : cancelButtonFunc!();
                      },
                      buttonColor: Colors.white,
                    ),
                    secondButtonText != null
                        ? Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Button(
                                text: secondButtonText!,
                                elevation: 0,
                                buttonWidth: 30.w,
                                onPressed: () => {
                                  secoundButtonFunc == null
                                      ? Navigator.of(context).pop()
                                      : secoundButtonFunc!()
                                },
                                buttonColor: secondColor,
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ]),
    );
  }
}
