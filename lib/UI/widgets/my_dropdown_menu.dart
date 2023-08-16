import 'package:cars_app/UI/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyDropdownMenu extends StatelessWidget {
  final String? value;
  final List<String> menu;
  final String hint;
  final Function(String? value) onChange;
  final bool isItForSignup;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  const MyDropdownMenu(
      {super.key,
      required this.value,
      required this.onChange,
      required this.menu,
      required this.hint,
      this.isItForSignup = false,
      this.icon,
      this.validator});

  DropdownMenuItem<String> buildItem(String s) {
    return DropdownMenuItem(
      child: Text(s),
      value: s,
    );
  }

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.5.w),
                child: Icon(
                  icon,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 83.w,
                child: buildDropDown(),
              )
            ],
          )
        : buildDropDown();
  }

  buildDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
          border: Border.all(color: grayColor),
          borderRadius: BorderRadius.circular(15.Q)),
      child: DropdownButtonFormField(
        validator: validator ?? null,
        iconEnabledColor: secondColor,
        menuMaxHeight: 30.h,
        iconDisabledColor: secondColor,
        icon: Icon(
          Icons.arrow_drop_down,
          color: secondColor,
        ),
        borderRadius: BorderRadius.circular(15.Q),
        elevation: 3,
        style: TextStyle(fontSize: 16.sp, color: Colors.black),
        hint: Text(
          hint,
          style: isItForSignup
              ? TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3.w)
              : null,
        ),
        isExpanded: true,
        value: value,
        items: [...menu.map((e) => buildItem(e))],
        onChanged: onChange,
      ),
    );
  }
}
