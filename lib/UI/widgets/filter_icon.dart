import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterICon extends StatelessWidget {
  final Function? ontap;
  const FilterICon({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (ontap != null) {
            ontap!();
          }
        },
        child: SvgPicture.asset('assets/icons/filter.svg'));
  }
}
