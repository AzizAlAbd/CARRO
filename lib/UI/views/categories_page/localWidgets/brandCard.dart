import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/Core/Models/brands_model.dart';
import 'package:cars_app/UI/views/brand_cars_screen/brand_cars_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../helpers/constants.dart';

class BrandCard extends StatelessWidget {
  final BrandData data;
  final int index;
  const BrandCard({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).pushNamed(BrandCarsScreen.routeName,
            arguments: {'title': data.name, 'id': data.id});
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 50.w,
          height: 13.h,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: CachedNetworkImageProvider(data.avatar)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: mainColor.withOpacity(0.6), //Color.fromARGB(122, 0, 0, 0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                data.name,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 18.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
