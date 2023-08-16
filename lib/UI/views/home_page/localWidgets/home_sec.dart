import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/views/view_all_screen/view_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeSection extends StatelessWidget {
  final String label;
  final Widget bodyWidget;
  final String? sublabel;
  const HomeSection(
      {super.key,
      required this.label,
      required this.bodyWidget,
      this.sublabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3.w, right: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              sublabel != null
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(ViewAllScreen.routeName,
                            arguments: label);
                      },
                      child: Text(
                        sublabel!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: grayColor),
                      ))
                  : Container()
            ],
          ),
        ),
        bodyWidget
      ],
    );
  }
}
