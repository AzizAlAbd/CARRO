import 'package:cars_app/UI/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyRadioButton extends StatelessWidget {
  final CarType value;
  final CarType groupValue;
  final String title;
  final Function(CarType value) onChanged;
  const MyRadioButton(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.title,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.w,
      child: RadioListTile(
        dense: true,
        contentPadding: EdgeInsets.all(0),
        visualDensity: VisualDensity(horizontal: -4),
        value: value,
        groupValue: groupValue,
        activeColor: secondColor,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        onChanged: (value) {
          onChanged(value!);
        },
      ),
    );
  }
}
