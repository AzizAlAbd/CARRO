import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../helpers/constants.dart';

class ImageContainer extends StatelessWidget {
  final XFile image;
  final Function(XFile) deleteOneImage;
  const ImageContainer(
      {super.key, required this.image, required this.deleteOneImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      child: Stack(children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    insetPadding: EdgeInsets.all(0),
                    elevation: 3,
                    content: Container(
                      height: 50.h,
                      child: Image.file(File(image.path)),
                    ));
              },
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 3.w, top: 1.h, bottom: 1.h),
            width: 20.w,
            height: 10.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Image.file(
              File(image.path),
            ),
          ),
        ),
        Positioned(
            right: -0.5.w,
            child: InkWell(
              onTap: () {
                deleteOneImage(image);
              },
              child: Icon(
                Icons.cancel,
                color: secondColor,
              ),
            ))
      ]),
    );
  }
}
