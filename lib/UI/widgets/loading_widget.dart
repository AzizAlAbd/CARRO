import 'package:cars_app/UI/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:animate_do/animate_do.dart' as animation;
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final double? padding;
  const LoadingWidget({
    Key? key,
    this.size,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return animation.ZoomIn(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0, top: padding ?? 0.0),
        child: LoadingAnimationWidget.threeArchedCircle(
          size: size ?? 15.w,
          color: secondColor,
        ),
      ),
    );
  }
}
