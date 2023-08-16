import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart' as animation;
import 'package:responsive_sizer/responsive_sizer.dart';

class Button extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final double? buttonWidth;
  final double? buttonHight;
  final Color buttonColor;
  final Color textColor;
  final double? elevation;
  final Color? borderColor;
  final IconData? icon;
  final bool enable;
  const Button(
      {Key? key,
      this.text,
      required this.onPressed,
      this.buttonWidth,
      this.buttonHight,
      this.buttonColor = Colors.black,
      this.textColor = Colors.white,
      this.elevation,
      this.borderColor,
      this.icon,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return animation.FadeIn(
        duration: Duration(milliseconds: 500),
        child: SizedBox(
            width: buttonWidth ?? 30.w,
            height: 6.5.h,
            child: icon == null || (icon != null && text == null)
                ? ElevatedButton(
                    style: TextButton.styleFrom(
                        elevation: elevation,
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                            side: borderColor == null
                                ? BorderSide.none
                                : BorderSide(color: borderColor!, width: 2),
                            borderRadius: BorderRadius.circular(15.Q))),
                    onPressed: enable ? onPressed : null,
                    child: text == null
                        ? Icon(
                            icon,
                            color: textColor,
                            size: 28.Q,
                          )
                        : Text(
                            text!,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: textColor),
                          ))
                : ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      elevation: elevation,
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          side: borderColor == null
                              ? BorderSide.none
                              : BorderSide(
                                  color: borderColor!,
                                ),
                          borderRadius: BorderRadius.circular(15.Q)),
                    ),
                    onPressed: enable ? onPressed : null,
                    icon: Icon(
                      icon,
                      color: textColor,
                    ),
                    label: Text(
                      text!,
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: textColor),
                    ))));
  }
}
